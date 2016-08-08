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
    def exportParticipantService
    def exportSummaryReportService
    def listAuditLogDataService

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
        def existingConsentFormNumber = null
        results.consent.consents.each{ c->
            def consentCreatedDateFormatted = new Date().parse("dd-MM-yyyy HH:mm:ss", c.lastCompleted)
            if(c.consentFormId){
                existingConsentFormNumber = StudySubject?.findByConsentFormNumber(c.consentFormId)?.consentFormNumber
            }
            if(c.form.namePrefix =="GEL" && !existingConsentFormNumber){
                def gelStudySubjectInstance = new StudySubject(study: geldb.Study.findByStudyName('GeL'), studySubjectIdentifier: null, consentFormNumber:c.consentFormId, consentStatus: Boolean.TRUE, recruitmentDate: consentCreatedDateFormatted, recruitedBy:c.consentTakerName, consentFormVersion: c.form.version)
                if (gelStudySubjectInstance){
                    consentList.add(gelStudySubjectInstance)
                }
            } else if(c.form.namePrefix =="GEN" && !existingConsentFormNumber){
                def orbStudySubjectInstance = new StudySubject(study: geldb.Study.findByStudyName('ORB'), studySubjectIdentifier: null, consentFormNumber:c.consentFormId, consentStatus: Boolean.TRUE, recruitmentDate: consentCreatedDateFormatted, recruitedBy:c.consentTakerName, consentFormVersion: c.form.version)
                if (orbStudySubjectInstance){
                    consentList.add(orbStudySubjectInstance)
                }
            }else if(c.form.namePrefix =="GLM" && !existingConsentFormNumber){
                def gelMainStudySubjectInstance = new StudySubject(study: geldb.Study.findByStudyName('100K Genomes Main Project'), studySubjectIdentifier: null, consentFormNumber:c.consentFormId, consentStatus: Boolean.TRUE, recruitmentDate: consentCreatedDateFormatted, recruitedBy:c.consentTakerName, consentFormVersion: c.form.version)
                if (gelMainStudySubjectInstance){
                    consentList.add(gelMainStudySubjectInstance)
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
        }else if (existingConsentFormNumber) {
            flash.message = "Participant with consent form number ${existingConsentFormNumber} already exist in NGS-LIMS."
            redirect(uri: '/importparticipant')
        } else{
            flash.message = "Participant with NHS number ${nhsNumber} doesn't have any consent form"
            redirect(uri: '/importparticipant')
        }
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
            exportService.export(params.format, response.outputStream, auditLogExport, listAuditLogDataService.fields, listAuditLogDataService.labels, [:], listAuditLogDataService.parameters )
//            if (params.delete){
//                AuditLogEvent.executeUpdate('delete from AuditLogEvent')
//            }
        }
        [listAuditLogData: listAuditLogData]
    }

    @Secured(['ROLE_ADMIN'])
    def exportSummaryReport(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported Summary Report.${params.extension}")
            def exportSummaryReportData = Participant.list().sort {it.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
            exportService.export(params.format, response.outputStream, exportSummaryReportData, exportSummaryReportService.fields, exportSummaryReportService.labels, exportSummaryReportService.formatters, exportSummaryReportService.parameters )
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportParticipants(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported All Participants.${params.extension}")
            def exportParticipantsData = Participant.list().sort {it.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
            exportService.export(params.format, response.outputStream, exportParticipantsData, exportParticipantService.fields, exportParticipantService.labels, exportParticipantService.formatters, exportParticipantService.parameters )
        }
    }

    def show(Participant participantInstance) {
        def listParticipantAuditLogData = AuditLogEvent.findAllByPersistedObjectId(participantInstance?.id)
        def listStudySubjectAuditLogData = AuditLogEvent.findAllByPersistedObjectIdInList(participantInstance?.studySubject?.id)
        listParticipantAuditLogData.addAll(listStudySubjectAuditLogData)
        respond participantInstance, model: [listAuditLogData: listParticipantAuditLogData]
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
            if (barcode && (barcodeVersionDate =='01/07/2015' ||  barcodeVersionDate == '01/09/2015' || barcodeVersionDate == '09/11/2015')){
                def barcodeParts = barcode.toString().split('~')
                def nHSNumber = barcodeParts[0].substring(11,21)
                def barcodePart0Parts= barcodeParts[0].split("[^\\x20-\\x7e]")
                def participantId = barcodePart0Parts[1].substring(2, 11)
                def hospitalNumber = barcodeParts[1]
                def familyName = barcodeParts[3]
                def givenName = barcodeParts[2]
                def consentFormVersion = "Version 2.1 dated 24.09.2015"
                def dateOfBirth = new Date().parse('d/M/yyyy',barcodeParts[4].substring(0,10))
                def existingParticipant = Participant.findByNHSNumber(nHSNumber)
                def study = Study.findByStudyName('100K Genomes Main Project')
                if (existingParticipant){
                    redirect(action: "show", id: existingParticipant.id)
                }else {
                    def bindingMap = [nHSNumber: nHSNumber, familyName: familyName, givenName: givenName, hospitalNumber: hospitalNumber, dateOfBirth: dateOfBirth]
                    def participantInstance = new Participant(bindingMap)
                    render(view : "createFromBarcode", model:[participantInstance:participantInstance, studySubjectIdentifier: participantId, consentFormVersion:consentFormVersion, study: study]);
                }
            }else{
                flash.message = "Please scan the barcode version (1.0.0, 01/07/2015) or (1.0.1, 01/09/2015) or (1.0.2, 09/11/2015)"
                redirect(uri: '/scanbarcode')
            }
        }
    }

    def createFromBarcode() {
        respond new Participant(params)
    }

    @Transactional
    def saveFromBarcode(Participant participantInstance) {
        if (participantInstance){
            def study = params.study.id
            def studySubjectIdentifier = params.studySubjectIdentifier
            def consentFormNumber = params.consentFormNumber
            def consentStatus = params.consentStatus
            def recruitmentDate = params.recruitmentDate
            def recruitedBy = params.recruitedBy
            def consentFormVersion = params.consentFormVersion
            def studySubjectInstance = new StudySubject(study: study, studySubjectIdentifier: studySubjectIdentifier, consentFormNumber:consentFormNumber, consentStatus:consentStatus,
                                                        recruitmentDate:recruitmentDate, recruitedBy:recruitedBy, consentFormVersion:consentFormVersion)
            participantInstance.addToStudySubject(studySubjectInstance).save flush: true
        }

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'participantInstance.label', default: 'Participant'), participantInstance.id])
                redirect participantInstance
            }
            '*' { respond participantInstance, [status: CREATED] }
        }
    }

    def renderTissueWorksheet(){
        def tempFile = File.createTempFile("temp",".png")
        def nhSNumber = Participant.get(params.id)?.getnHSNumber()
        def input= "${nhSNumber}"
        Map<EncodeHintType,Object> hintType =new HashMap<EncodeHintType,Object>();
        hintType.put(EncodeHintType.DATA_MATRIX_SHAPE, com.google.zxing.datamatrix.encoder.SymbolShapeHint.FORCE_SQUARE);
        barcodeService.generateDataMatrix(input,hintType,tempFile.path);
        def barcode = new File(tempFile.path)
        def ochre = new File(ApplicationHolder.application.parentContext.servletContext.getRealPath("/images/ochre.png"))
        def orb = new File(ApplicationHolder.application.parentContext.servletContext.getRealPath("/images/orb.png"))
        def formInstance = Participant.get(params.id)
        def args = [template:"tissueWorksheet", model:[form:formInstance, barcode: barcode.bytes, ochre:ochre.bytes, orb:orb.bytes]]
        pdfRenderingService.render(args+[controller:this],response)
        File file = tempFile
        file.delete()
    }

    def renderTissueWorksheetProstate(){
        def tempFile = File.createTempFile("temp",".png")
        def nhSNumber = Participant.get(params.id)?.getnHSNumber()
        def input= "${nhSNumber}"
        Map<EncodeHintType,Object> hintType =new HashMap<EncodeHintType,Object>();
        hintType.put(EncodeHintType.DATA_MATRIX_SHAPE, com.google.zxing.datamatrix.encoder.SymbolShapeHint.FORCE_SQUARE);
        barcodeService.generateDataMatrix(input,hintType,tempFile.path);
        def barcode = new File(tempFile.path)
        def ochre = new File(ApplicationHolder.application.parentContext.servletContext.getRealPath("/images/ochre.png"))
        def orb = new File(ApplicationHolder.application.parentContext.servletContext.getRealPath("/images/orb.png"))
        def formInstance = Participant.get(params.id)
        def args = [template:"tissueWorksheetProstate", model:[form:formInstance, barcode: barcode.bytes, ochre:ochre.bytes, orb:orb.bytes]]
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

    def searchICD10 = {
        def listICD10 = ICD10.createCriteria().listDistinct {
            or {
                and {ilike("meaning", "%${params.query}%")}
                and {ilike("code", "%${params.query}%")}
            }
        }
        //Create XML response
        render(contentType: "text/xml") {
            results() {
                listICD10.each { icd10 ->
                    result(){
                        name(icd10)
                        //Optional id which will be available in onItemSelect
                        id(icd10.id)
                    }
                }
            }
        }
    }

    def searchParticipant = {
        def listParticipant = Participant.createCriteria().listDistinct {
           ilike("nHSNumber", "%${params.query}%")
        }
        //Create XML response
        render(contentType: "text/xml") {
            results() {
                listParticipant.each { participant ->
                    result(){
                        name(participant)
                        //Optional id which will be available in onItemSelect
                        id(participant.id)
                    }
                }
            }
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
