package geldb

import GELBootsDB.User
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogListener

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
import grails.converters.JSON
import groovy.json.JsonSlurper
/**
 * ParticipantController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class ParticipantController {

    def consentService
    def filterPaneService
    def exportService
    def grailsApplication

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Participant.list(params), model: [participantInstanceCount: Participant.count()]
    }

    def getJson () {
        params.nhsOrHospitalNumberId

        //call Greenlight service here
        def results = consentService.getConsent( params.nhsOrHospitalNumberId)
        //internal error accessing Greenlight
        if(results.erros){
            flash.message = results.errorMessage;
            redirect(uri: '/importparticipant')
            return
        }
        //Greenlight can not find the patient
        if(results.consent.errors){
            flash.message = "Can not find patient with NHS number ${params.nhsOrHospitalNumberId} in Consent Management system"
            redirect(uri: '/importparticipant')
            return
        }

        def lastName = results.consent.lastName
        def firstName = results.consent.firstName
        def dateOfBirth =results.consent.dateOfBirth
        def nhsNumber = results.consent.nhsNumber
        def hospitalNumber =  results.consent.hospitalNumber

        List<StudySubject> consentList = new ArrayList<StudySubject>();
//        def consentTakerName = ""
//        def lastCompleted = new Date()
//        def version =""
//        def foundGEL = false
//        def foundORB = false
        results.consent.consents.each{ c->
            if(c.form.namePrefix =="GEL"){
                def gelStudySubjectInstance = new StudySubject(study: geldb.Study.findByStudyName('GeL'), studySubjectIdentifier: null, consentFormNumber:c.consentFormId, consentStatus: Boolean.TRUE, recruitmentDate: c.lastCompleted, recruitedBy:c.consentTakerName, consentFormVersion: c.form.version)
                if (gelStudySubjectInstance){
                    consentList.add(gelStudySubjectInstance)
                }
            } else if(c.form.namePrefix =="GEN"){
                def orbStudySubjectInstance = new StudySubject(study: geldb.Study.findByStudyName('ORB'), studySubjectIdentifier: null, consentFormNumber:c.consentFormId, consentStatus: Boolean.TRUE, recruitmentDate: c.lastCompleted, recruitedBy:c.consentTakerName, consentFormVersion: c.form.version)
                if (orbStudySubjectInstance){
                    consentList.add(orbStudySubjectInstance)
                }
            }
        }
        //we find the patient and has the consent form
        def existingParticipant = Participant.findByHospitalNumber(hospitalNumber)
        if(existingParticipant){

            existingParticipant.centre = Centre.findByCentreName('Oxford')
            existingParticipant.dateOfBirth = new Date().parse("yyyy-MM-dd", dateOfBirth)
            existingParticipant.diagnosis = null
            existingParticipant.gender = null
            existingParticipant.familyName = lastName
            existingParticipant.givenName = firstName
            existingParticipant.nHSNumber = nhsNumber

            existingParticipant.save(failOnError: true)
            redirect(action: "show", id: existingParticipant.id)

        }else if (!consentList.empty && !existingParticipant) {
            def participantInstance = new Participant(familyName: lastName, givenName: firstName, diagnosis: null,
                    dateOfBirth: dateOfBirth, nHSNumber: nhsNumber, hospitalNumber: hospitalNumber, gender: null, centre: Centre.findByCentreName('Oxford'))
            for (int i = 0; i < consentList.size(); i++) {

                participantInstance.addToStudySubject(consentList.get(i))
                participantInstance.save(failOnError: true)
            }

            redirect(action: "show", id: participantInstance.id)
        } else{
            flash.message = "Patient with NHS number ${nhsNumber} doesn't have any consent form"
            redirect(uri: '/importparticipant')
        }

    }
//            def participantInstance = new Participant(familyName: lastName, givenName: firstName, diagnosis: null,
//                    dateOfBirth: dateOfBirth, nHSNumber: nhsNumber, hospitalNumber: hospitalNumber, gender: null, centre: Centre.findByCentreName('Oxford'))
//
//            def studySubjectInstance = new StudySubject(study: geldb.Study.findByStudyName('GeL Study'), studySubjectIdentifier: consentFormId, consentStatus: Boolean.TRUE, recruitmentDate: lastCompleted,
//                    recruitedBy:consentTakerName, consentFormVersion: version)
//            participantInstance.addToStudySubject(studySubjectInstance).save(failOnError: true)
//            redirect(action: "show", id: participantInstance.id)

    //find the patient but it does not have GEL form

    def listBloodFollowUp() {

        def results = Participant.createCriteria().listDistinct{
            specimen {
                aliquot {
                    eq('aliquotType',AliquotType.findByAliquotTypeName('Plasma'))
                }
            }
        }
        [participantList: results.sort {it.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [participantInstanceList: Participant.list(params), participantInstanceTotal: Participant.count()]
    }

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ participantInstanceList: filterPaneService.filter( params, Participant ),
                                     participantInstanceTotal: filterPaneService.count( params, Participant ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    @Secured(['ROLE_ADMIN'])
    @Transactional
    def listAuditLogData(){
        def user = User?.get(params.long('user.id'))
        def listAuditLogData = AuditLogEvent?.findAllByActor(user?.username)
        listAuditLogData = listAuditLogData.sort {it.dateCreated}
        listAuditLogData = listAuditLogData.reverse()
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported User Activity Log.${params.extension}")

            def auditLogExport = AuditLogEvent.list().sort {it.actor}
            auditLogExport = auditLogExport.reverse()

            List fields = ["actor", "eventName", "dateCreated", "className", "persistedObjectId", "oldValue", "newValue"]
            Map labels = ["actor":"Username", "eventName":"Event Name", "dateCreated":"Date & Time",
                          "className":"Table", "persistedObjectId":"Record ID", "oldValue":"Old Value",
                          "newValue":"New Value"]
            Map parameters = [title: "Exported User Activity Log", "column.widths": [0.2, 0.3, 0.5]]
            Map formatters = [:]

            exportService.export(params.format, response.outputStream, auditLogExport, fields, labels, formatters, parameters )

            if (params.delete){
                AuditLogEvent.executeUpdate('delete from AuditLogEvent')
            }
        }

        [listAuditLogData: listAuditLogData]
    }

    def show(Participant participantInstance) {
        respond participantInstance
    }

    def summaryReport() {
        def gelID = params.gelStudyId
        if (gelID) {
            def participantByGeLId = Participant.createCriteria().get {
                studySubject {
                    eq('studySubjectIdentifier', gelID)
                }
            }
            if (participantByGeLId && gelID) {
                [participantSummary: participantByGeLId]
            }
        }
    }

    def findICD10() {
        def searchDiagnosis= params.searchDiagnosis
        def parts =searchDiagnosis.toString().split(' ')
        def listICD10 = ICD10.createCriteria().listDistinct {
            or {
                and {parts.each {ilike("meaning", '%' + it + '%')}}
                and {parts.each {ilike("code", '%' + it + '%')}}
            }
        }
        if (!listICD10.empty){
            render(template: "listICD10",  model: [listICD10: listICD10])
        }
    }

    def create() {
        respond new Participant(params)
    }

    @Transactional
    def save(Participant participantInstance) {
        if (participantInstance == null) {
            notFound()
            return
        }

        if (participantInstance.hasErrors()) {
            respond participantInstance.errors, view: 'create'
            return
        }

        participantInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'participantInstance.label', default: 'Participant'), participantInstance.id])
                redirect participantInstance
            }
            '*' { respond participantInstance, [status: CREATED] }
        }
    }

    def edit(Participant participantInstance) {
        respond participantInstance
    }

    @Transactional
    def update(Participant participantInstance) {
        if (participantInstance == null) {
            notFound()
            return
        }

        if (participantInstance.hasErrors()) {
            respond participantInstance.errors, view: 'edit'
            return
        }

        participantInstance.save flush: true

        def gelId = params.studySubjectIdentifier
        if (gelId){
            def gelSubject = participantInstance.studySubject.find {s ->s.study.studyName = 'GeL' }
            if (gelSubject){
                gelSubject.studySubjectIdentifier = gelId
                gelSubject.save flush: true
                flash.message = "Participant ${participantInstance.id} has been updated"
                redirect(controller:'participant',action: 'show', params: [id:participantInstance.id])
            }else {
                def firstSubject =  participantInstance.studySubject.first()
                firstSubject.studySubjectIdentifier = gelId
                firstSubject.save flush: true
                flash.message = "Participant ${participantInstance.id} has been updated"
                redirect(controller:'participant',action: 'show', params: [id:participantInstance.id])
            }
        } else{
            flash.message = "Participant ${participantInstance.id}has been updated"
            redirect participantInstance
        }
    }

    @Transactional
    def delete(Participant participantInstance) {

        if (participantInstance == null) {
            notFound()
            return
        }

        participantInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Participant.label', default: 'Participant'), participantInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'participantInstance.label', default: 'Participant'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
