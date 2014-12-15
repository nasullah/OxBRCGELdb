package geldb


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
        if(results.errors){
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

        def consentFormId = ""
        def consentTakerName = ""
        def lastCompleted = new Date()
        def version =""
        def foundGEL = false

        results.consent.consents.each{ c->
            if(c.form.namePrefix =="GEL"){
                foundGEL = true
                consentFormId    = c.consentFormId
                consentTakerName = c.consentTakerName
                lastCompleted    = c.lastCompleted
                version          = c.form.version
            }
        }
        //we find the patient and has the consent form
        def existingParticipant = Participant.findByHospitalNumber(hospitalNumber)
        if(foundGEL && existingParticipant){
            existingParticipant.centre = Centre.findByCentreName('Oxford')
            existingParticipant.dateOfBirth = new Date().parse("yyyy-MM-dd", dateOfBirth)
            existingParticipant.diagnosis = null
            existingParticipant.gender = null
            existingParticipant.familyName = lastName
            existingParticipant.givenName = firstName
            existingParticipant.nHSNumber = nhsNumber

            existingParticipant.save(failOnError: true)
            redirect(action: "show", id: existingParticipant.id)

        }else if (foundGEL && !existingParticipant){
                def participantInstance = new Participant(familyName: lastName, givenName: firstName, diagnosis: null,
                        dateOfBirth: dateOfBirth, nHSNumber: nhsNumber, hospitalNumber: hospitalNumber, gender: null, centre: Centre.findByCentreName('Oxford'))

                def studySubjectInstance = new StudySubject(study: geldb.Study.findByStudyName('GeL Study'), studySubjectIdentifier: null, consentStatus: Boolean.TRUE, recruitmentDate: lastCompleted,
                        recruitedBy:consentTakerName, consentFormVersion: version)
                participantInstance.addToStudySubject(studySubjectInstance).save(failOnError: true)
                redirect(action: "show", id: participantInstance.id)
        }

//            def participantInstance = new Participant(familyName: lastName, givenName: firstName, diagnosis: null,
//                    dateOfBirth: dateOfBirth, nHSNumber: nhsNumber, hospitalNumber: hospitalNumber, gender: null, centre: Centre.findByCentreName('Oxford'))
//
//            def studySubjectInstance = new StudySubject(study: geldb.Study.findByStudyName('GeL Study'), studySubjectIdentifier: consentFormId, consentStatus: Boolean.TRUE, recruitmentDate: lastCompleted,
//                    recruitedBy:consentTakerName, consentFormVersion: version)
//            participantInstance.addToStudySubject(studySubjectInstance).save(failOnError: true)
//            redirect(action: "show", id: participantInstance.id)

        //find the patient but it does not have GEL form
        else{
            flash.message = "Patient with NHS number ${nhsNumber} doesn't have any GEL consent form"
            redirect(uri: '/importparticipant')
        }
    }

    def listBloodFollowUp() {

        List <Participant> results = Participant.createCriteria().listDistinct{
            specimen {
                aliquot {
                    eq('aliquotType',AliquotType.findByAliquotTypeName('Plasma'))
                }
            }
        }
    [participantList: results]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [participantInstanceList: Participant.list(params), participantInstanceTotal: Participant.count()]
    }
    def filterPaneService

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ participantInstanceList: filterPaneService.filter( params, Participant ),
                                     participantInstanceTotal: filterPaneService.count( params, Participant ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }


    def show(Participant participantInstance) {
        respond participantInstance
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

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Participant.label', default: 'Participant'), participantInstance.id])
                redirect participantInstance
            }
            '*' { respond participantInstance, [status: OK] }
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
