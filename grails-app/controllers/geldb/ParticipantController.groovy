package geldb

import GELBootsDB.User
import com.google.zxing.BarcodeFormat
import com.google.zxing.EncodeHintType
import com.google.zxing.common.BitMatrix
import com.google.zxing.datamatrix.DataMatrixWriter
import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogListener

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

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
    def pdfRenderingService
    def barcodeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def  participantWithGeLIDList = Participant.list().findAll{it.studySubject.findResult {it.studySubjectIdentifier ? it : null}}
        def  participantInstanceCount = participantWithGeLIDList.size()
        if (params.sort == "studySubject.studySubjectIdentifier" && params.order == "asc" ) {
            if (params.offset && params.offset?.toInteger() != 0 && participantInstanceCount - params.offset?.toInteger() < 10){
                respond Participant.list(offset: params.offset , max:participantInstanceCount % params.offset?.toInteger(), sort: "studySubject.studySubjectIdentifier" ), model: [participantInstanceCount: participantInstanceCount]
            }
            else{
                respond Participant.list(params), model: [participantInstanceCount: participantInstanceCount]
            }
        } else{
            respond Participant.list(params), model: [participantInstanceCount: Participant.count()]
        }
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

        results.consent.consents.each{ c->
            def consentCreatedDateFormatted = new Date().parse("dd-MM-yyyy HH:mm:ss", c.lastCompleted)

            if(c.form.namePrefix =="GEL"){

                def gelStudySubjectInstance = new StudySubject(study: geldb.Study.findByStudyName('GeL'), studySubjectIdentifier: null, consentFormNumber:c.consentFormId, consentStatus: Boolean.TRUE, recruitmentDate: consentCreatedDateFormatted, recruitedBy:c.consentTakerName, consentFormVersion: c.form.version)
                if (gelStudySubjectInstance){
                    consentList.add(gelStudySubjectInstance)
                }
            } else if(c.form.namePrefix =="GEN"){
                def orbStudySubjectInstance = new StudySubject(study: geldb.Study.findByStudyName('ORB'), studySubjectIdentifier: null, consentFormNumber:c.consentFormId, consentStatus: Boolean.TRUE, recruitmentDate: consentCreatedDateFormatted, recruitedBy:c.consentTakerName, consentFormVersion: c.form.version)
                if (orbStudySubjectInstance){
                    consentList.add(orbStudySubjectInstance)
                }
            }
        }
        //we find the patient and has the consent form
        def existingParticipant = Participant.findByHospitalNumber(hospitalNumber)
        if(existingParticipant){

            flash.message = "Could not be imported as the participant already exists in NGS-LIMS, see below."
            redirect(action: "show", id: existingParticipant.id)

        }else if (!consentList.empty && !existingParticipant) {
            def dateOfBirthFormatted = new Date().parse("dd-MM-yyyy HH:mm:ss", dateOfBirth)

            def participantInstance = new Participant(familyName: lastName, givenName: firstName, diagnosis: null,
                    dateOfBirth: dateOfBirthFormatted, nHSNumber: nhsNumber, hospitalNumber: hospitalNumber, gender: null, centre: Centre.findByCentreName('Oxford'))
            for (int i = 0; i < consentList.size(); i++) {
                participantInstance.addToStudySubject(consentList.get(i))
                participantInstance.save(failOnError: true)
            }
            redirect(action: "show", id: participantInstance.id)
        } else{
            flash.message = "Participant with NHS number ${nhsNumber} doesn't have any consent form"
            redirect(uri: '/importparticipant')
        }
    }

    def listBloodFollowUp() {

        def results = Participant.createCriteria().listDistinct{
            specimen {
                and {
                    ge("fluidSpecimenVolume", Float.parseFloat("10"))
                    aliquot {
                        eq('aliquotType',AliquotType.findByAliquotTypeName('Plasma'))
                    }
                }
            }
        }
        [participantList: results.sort {it.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def  participantWithGeLIDList = Participant.list().findAll{it.studySubject.findResult {it.studySubjectIdentifier ? it : null}}
        def  participantInstanceCount = participantWithGeLIDList.size()
        if (params.sort == "studySubject.studySubjectIdentifier" && params.order == "asc" ) {
            if (params.offset && params.offset?.toInteger() != 0 && participantInstanceCount - params.offset?.toInteger() < 10){
                [participantInstanceList: Participant.list(offset: params.offset, max:participantInstanceCount % params.offset?.toInteger(), sort: "studySubject.studySubjectIdentifier" ), participantInstanceTotal: participantInstanceCount]
            }
            else{
                [participantInstanceList: Participant.list(params), participantInstanceTotal: participantInstanceCount]
            }
        } else{
            [participantInstanceList: Participant.list(params), participantInstanceTotal: Participant.count()]
        }
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

    @Secured(['ROLE_ADMIN'])
    def exportSummaryReport(){

        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported Summary Report.${params.extension}")

            def exportSummaryReportData = Participant.list().sort {it.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}

            def gelId = { domain, value ->
                return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
            }
            def consentType = { domain, value ->
                return value.toString().replace('[','').replace(']','').replace('null','')
            }

            List fields = ["studySubject.studySubjectIdentifier","studySubject.study"]
            Map labels = ["studySubject.studySubjectIdentifier":"GEL Study ID", "studySubject.study":"Consent Type"]
            Map parameters = [title: "Exported Summary Report", "column.widths": [0.2, 0.3, 0.5]]
            Map formatters = ["studySubject.studySubjectIdentifier":gelId, "studySubject.study":consentType]

            exportService.export(params.format, response.outputStream, exportSummaryReportData, fields, labels, formatters, parameters )
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportParticipants(){

        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported All Participants.${params.extension}")

            def exportParticipantsData = Participant.list().sort {it.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}

            def cleanGelID = { domain, value ->
                return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
            }
            def cleanConsentType = { domain, value ->
                return value.toString().replace('[','').replace(']','').replace('null','').trim()
            }

            List fields = ["studySubject.studySubjectIdentifier", "studySubject.study", "familyName", "givenName","dateOfBirth","gender","nHSNumber","hospitalNumber","diagnosis","centre"]
            Map labels = ["familyName":"Family Name", "givenName":"Given Name", "dateOfBirth":"Date of Birth", "gender":"Gender", "nHSNumber":"NHS Number", "hospitalNumber":"Hospital Number", "diagnosis":"Diagnosis", "centre":"Centre", "studySubject.studySubjectIdentifier":"GEL Study ID", "studySubject.study":"Consent Type"]
            Map parameters = [title: "Participants", "column.widths": [0.2, 0.3, 0.5]]
            Map formatters = ["studySubject.studySubjectIdentifier":cleanGelID, "studySubject.study":cleanConsentType]

            exportService.export(params.format, response.outputStream, exportParticipantsData, fields, labels, formatters, parameters )
        }
    }

    def show(Participant participantInstance) {
        respond participantInstance
    }

    def scanBarcode(){

        def barcode = params.barcode
        if (!barcode.toString().contains('~')){
            def participantInstance = Participant.findByNHSNumber(barcode)
            if (participantInstance){
                redirect(action: "show", id: participantInstance.id)
            }else {
                flash.message = "No patient found"
                redirect(uri: '/scanbarcode')
            }
        }else{
            def barcodeVersionDate = barcode?.toString()?.split('~')?.last()
            if (barcode && barcodeVersionDate =='01/07/2015'){
                def barcodeParts = barcode.toString().split('~')
                def nHSNumber = barcodeParts[0].substring(11,21)
                def hospitalNumber = barcodeParts[1]
                def familyName = barcodeParts[3]
                def givenName = barcodeParts[2]
                def dateOfBirth = new Date().parse('d/M/yyyy',barcodeParts[4].substring(0,10))?.format('yyyy-MM-dd')
                def participantInstance = Participant.findByNHSNumber(nHSNumber)
                if (participantInstance){
                    redirect(action: "show", id: participantInstance.id)
                }else {
                    redirect(action: "create", params: [nHSNumber: nHSNumber, familyName: familyName, givenName: givenName, hospitalNumber: hospitalNumber, dateOfBirth: dateOfBirth ])
                }
            }else{
                flash.message = "Please scan the barcode version 1.0.0, 01/07/2015"
                redirect(uri: '/scanbarcode')
            }
        }
    }

    def renderFormPDF(){
        def tempFile = File.createTempFile("temp",".png")
//        def gelID = Participant.get(params.id)?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}
//        def hospitalNumber = Participant.get(params.id)?.getHospitalNumber()
        def nhSNumber = Participant.get(params.id)?.getnHSNumber()
//        def givenName = Participant.get(params.id)?.getGivenName()
//        def familyName = Participant.get(params.id)?.getFamilyName()
        def input= "${nhSNumber}"
        Map<EncodeHintType,Object> hintType =new HashMap<EncodeHintType,Object>();
        hintType.put(EncodeHintType.DATA_MATRIX_SHAPE, com.google.zxing.datamatrix.encoder.SymbolShapeHint.FORCE_SQUARE);
        barcodeService.generateDataMatrix(input,hintType,tempFile.path);
        def barcode = new File(tempFile.path)
        def ochre = new File(ApplicationHolder.application.parentContext.servletContext.getRealPath("/images/ochre.png"))
        def orb = new File(ApplicationHolder.application.parentContext.servletContext.getRealPath("/images/orb.png"))
        def formInstance = Participant.get(params.id)
        def args = [template:"pdf", model:[form:formInstance, barcode: barcode.bytes, ochre:ochre.bytes, orb:orb.bytes]]
        pdfRenderingService.render(args+[controller:this],response)
        File file = tempFile
        file.delete()
    }


    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def summaryReport() {
        def gelID = params.gelStudyId
        if (gelID) {
            def participantByGeLId = Participant.createCriteria().get {
                studySubject {
                    eq('studySubjectIdentifier', gelID, [ignoreCase: true])
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
            def gelSubject = participantInstance.studySubject.find {s ->s.study.studyName == 'GeL' }
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
