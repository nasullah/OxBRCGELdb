package geldb

import grails.converters.XML

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.grails.plugins.excelimport.*
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
/**
 * DNA_ExtractController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class DNA_ExtractController {

    def exportService
    def exportKPIReportService
    def filterPaneService
    def exportAllDNAExtractService
    def importService
    def workListService
    def exportDNAListToCheckService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DNA_Extract.findAllByExhausted(false, params), model: [DNA_ExtractInstanceCount: DNA_Extract.findAllByExhausted(false).size()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [DNA_ExtractInstanceList: DNA_Extract.findAllByExhausted(false, params), DNA_ExtractInstanceTotal: DNA_Extract.findAllByExhausted(false).size()]
    }

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ DNA_ExtractInstanceList: filterPaneService.filter( params, DNA_Extract ),
                                     DNA_ExtractInstanceTotal: filterPaneService.count( params, DNA_Extract ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def findAliquotsByGeLId() {
        def gelId= params.search
        if (gelId) {
            def participantByGeLId = Participant.createCriteria().get {
                studySubject {
                    eq('studySubjectIdentifier', gelId, [ignoreCase: true])
                }
            }
            if(participantByGeLId){
                participantByGeLId = participantByGeLId.id
                def listAliquotsByGeLId = Aliquot.findAll {
                    specimen.participant.id == participantByGeLId
                }
                listAliquotsByGeLId = listAliquotsByGeLId.findAll { a ->
                    !a.exhausted
                }
                listAliquotsByGeLId = listAliquotsByGeLId.findAll { a ->
                    a.specimen.participant.id == participantByGeLId
                }
                if (!listAliquotsByGeLId.empty) {
                    render(template: "aliquotList", model: [listAliquotsByGeLId: listAliquotsByGeLId])
                }
            }
        }
    }

    def show(DNA_Extract DNA_ExtractInstance) {
        respond DNA_ExtractInstance
    }

    def create() {
        respond new DNA_Extract(params), model: [originalVolume: params.originalVolume, originalDnaId: params.originalDnaId]
    }

    def workLists() {
        workListService.workLists(params.sampleType)
    }

    @Transactional
    def readyToDispatch(){
        def dna = DNA_Extract.findById(params.long('dnaExtractId'))
        if (dna){
            if (!dna.checked || dna.checked == null){
                dna.checked = true
                dna.save flush: true
                flash.message ="Selected item has been checked"
            }else {
                dna.checked = false
                dna.save flush: true
                flash.message ="Selected item has been unchecked"
            }
        }
        def ffDNAExtract = DNA_Extract.createCriteria().list{
            and {
                aliquot {
                    eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy Frozen'))
                }
                ge("dNAConcentrationQubit", '18'.toFloat())
                eq("exhausted", false)
                eq("passFail", true)
                eq('extractionType', ExtractionType.findByExtractionTypeName('DNA Extraction'))
            }
        }
        def glDNAExtract = DNA_Extract.createCriteria().list {
            and {
                aliquot {
                    or {
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Blood Germline'))
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Buffy Coat'))
                    }
                }
                ge("dNAConcentrationQubit", '30'.toFloat())
                ge("dNAAmount", '100'.toDouble())
                eq("exhausted", false)
                eq("passFail", true)
                eq('extractionType', ExtractionType.findByExtractionTypeName('DNA Extraction'))
            }
        }
        def ffpDNAExtract = DNA_Extract.createCriteria().list {
            and {
                aliquot {
                    or {
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy FFPE, NBF'))
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy FFPE'))
                    }
                }
                lt("delatQC", '2.9'.toDouble())
                ge("dNAConcentrationQubit", '18'.toFloat())
                eq("exhausted", false)
                eq("passFail", true)
                eq('extractionType', ExtractionType.findByExtractionTypeName('DNA Extraction'))
            }
        }
        def ffPatientIds = ffDNAExtract.aliquot.specimen.participant.id.flatten().unique()
        def glPatientIds = glDNAExtract.aliquot.specimen.participant.id.flatten().unique()
        def ffpPatientIds = ffpDNAExtract.aliquot.specimen.participant.id.flatten().unique()
        def noFFSampleExpectedPatientIds = SolidSpecimen.findAllByNoFFSampleExpected(true).participant.id
        ffPatientIds.addAll(noFFSampleExpectedPatientIds)
        def patientIdList = ffPatientIds.intersect(glPatientIds).intersect(ffpPatientIds)
        def dispatchedItemSampleIdList = DispatchItem.list().identifiedSample.id
        def dispatchedItemDNAPatientIds = DNA_Extract.findAllByIdInList(dispatchedItemSampleIdList).aliquot.specimen.participant.id.flatten().unique()
        if(!dispatchedItemDNAPatientIds.empty){
            patientIdList -= dispatchedItemDNAPatientIds
        }
        ffDNAExtract = ffDNAExtract.findAll {c -> patientIdList.findAll {it == c.aliquot.specimen.participant.id.first()}}
        glDNAExtract = glDNAExtract.findAll {c -> patientIdList.findAll {it == c.aliquot.specimen.participant.id.first()}}
        ffpDNAExtract = ffpDNAExtract.findAll {c -> patientIdList.findAll {it == c.aliquot.specimen.participant.id.first()}}
        def trio = ffDNAExtract + glDNAExtract + ffpDNAExtract
        [trio: trio.sort {it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    def exportCheckedDNA(){
        List<DNA_Extract> dnaList = new ArrayList<DNA_Extract>();
        dnaList.addAll(readyToDispatch().trio)
        def checkedList = dnaList.findAll {d -> d.checked}

        if (params?.format && params.format != "html") {
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported FFPE.${params.extension}")

            def gelID = { domain, value ->
                return value?.toString()?.replace('[','')?.replace(']','')?.replace(' ','')?.replace(',','')?.replace('null','')
            }

            def clean = { domain, value ->
                return value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
            }

            def dateFormat = { domain, value ->
                if (value.toString().size() > 10){
                    return value?.toString()?.substring(0, 10)
                }else {
                    return value
                }
            }

            Map formatters = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier": gelID, "aliquot.aliquotType": clean, "aliquot.barcode": clean,
                              "extractionDate": dateFormat]

            List fields = ["Checked By", "aliquot.specimen.participant.studySubject.studySubjectIdentifier", "aliquot.aliquotType", "aliquot.barcode", "barcode",
                           "dNAConcentrationQubit", "extractionDate", "extractedBy.staffName"]

            Map labels = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier": "Participant Id ", "aliquot.aliquotType": "Sample Type",
                          "aliquot.barcode": "Original Aliquot Barcode", "barcode":"DNA Extract Barcode", "dNAConcentrationQubit":"Qubit Concentration",
                          "extractionDate":"Extraction Date", "extractedBy.staffName":"Extracted By"]

            Map parameters = [title: "DNA Extract Check List", "column.widths": [0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3]]
            exportService.export(params.format, response.outputStream, checkedList, fields, labels, formatters, parameters)
        }
    }

    @Transactional
    def uploadFile() {
        MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request;
        CommonsMultipartFile file = (CommonsMultipartFile) mpr.getFile("file");
        if (!file.originalFilename) {
            flash.message = "Please choose a file"
            redirect action: "index", method: "GET"
        } else{
            importService.importDate(file)
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportKPIReport (){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported KPI Report.${params.extension}")
            def exportKPIReportData = DNA_Extract.list().sort {it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
            exportService.export(params.format, response.outputStream, exportKPIReportData, exportKPIReportService.fields, exportKPIReportService.labels, exportKPIReportService.formatters, exportKPIReportService.parameters)
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportAllDNAExtracts (){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported DNA Extracts.${params.extension}")
            def dnaExtractList = DNA_Extract.list().sort {it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
            exportService.export(params.format, response.outputStream, dnaExtractList, exportAllDNAExtractService.fields, exportAllDNAExtractService.labels, exportAllDNAExtractService.formatters, exportAllDNAExtractService.parameters)
        }
    }

    def exportDNAExportListToCheck(){
        def aliquotType = params.long('aliquotTypeDNA')
        def paramsStartDate = params.startDateDNA
        def paramsEndDate = params.endDateDNA
        def startDate = new Date()
        def endDate =new Date()
        if (paramsStartDate){
            startDate = startDate.parse("yyyy-MM-dd", paramsStartDate.toString())
        }
        if (paramsEndDate){
            endDate = endDate.parse("yyyy-MM-dd", paramsEndDate.toString())
        }

        if (paramsEndDate && paramsStartDate && aliquotType){
            if (params?.format && params.format != "html") {
                response.contentType = grailsApplication.config.grails.mime.types[params.format]
                response.setHeader("Content-disposition", "attachment; filename= DNA_Extract.${params.extension}")
                def listDNA = DNA_Extract.createCriteria().list {
                    and {
                        le("extractionDate", endDate)
                        ge("extractionDate", startDate)
                        aliquot {
                            eq("aliquotType", AliquotType.findById(aliquotType))
                        }
                    }
                }?.sort {it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
                exportService.export(params.format, response.outputStream, listDNA, exportDNAListToCheckService.fields, exportDNAListToCheckService.labels, exportDNAListToCheckService.formatters, exportDNAListToCheckService.parameters)
            }
        }else {
            flash.message = "Enter start date, end date and sample type"
            redirect(uri: "/participant/summaryReport")
        }
    }

    @Transactional
    def save(DNA_Extract DNA_ExtractInstance) {
        if (DNA_ExtractInstance == null) {
            notFound()
            return
        }

        if (DNA_ExtractInstance.hasErrors()) {
            respond DNA_ExtractInstance.errors, view: 'create'
            return
        }

        if (params.aliquot){
            DNA_ExtractInstance.save flush: true
            def exhaustAliquot = params.exhaustAliquot
            if (exhaustAliquot == 'True'){
                DNA_ExtractInstance.aliquot.each{ a->
                    a.exhausted = true
                    a.save flush: true
                }
            }
        }else{
            flash.message = "Please enter participant GeL ID, click Find Aliquot button then select aliquot/aliquots from the list."
            respond DNA_ExtractInstance, view: 'create'
            return
        }

        if (params.originalVolume && params.originalDnaId){
            def originalDNA = DNA_Extract.findById(params.long('originalDnaId'))
            if (originalDNA){
                def originalVolume = params.originalVolume
                originalVolume = originalVolume?.toString()?.toDouble()
                if (originalVolume > DNA_ExtractInstance.dNAAmount){
                    def newVolume = originalVolume - DNA_ExtractInstance.dNAAmount
                    originalDNA.dNAAmount = newVolume
                    originalDNA.save flush: true
                }
            }
        }

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'DNA_ExtractInstance.label', default: 'DNA_Extract'), DNA_ExtractInstance.id])
                redirect DNA_ExtractInstance
            }
            '*' { respond DNA_ExtractInstance, [status: CREATED] }
        }
    }

    def getElution() {
        def aliquot = Aliquot.findById(params.selectAliquot)
        if(aliquot){
            def aliquotType = aliquot.getAliquotType()
            def gelId = aliquot?.specimen?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}
            if (aliquotType && gelId){
                def elution = ""
                if (aliquotType.aliquotTypeName == 'Buffy Coat'){
                    elution = gelId.toString() + "_" + "GL" + "_"
                    render([elution: elution] as XML)
                }else {
                    elution = gelId.toString() + "_" + aliquotType.toString().replace(" ","") + "_"
                    render([elution: elution] as XML)
                }
            }
        }
    }

    def edit(DNA_Extract DNA_ExtractInstance) {
        respond DNA_ExtractInstance
    }

    @Transactional
    def update(DNA_Extract DNA_ExtractInstance) {
        if (DNA_ExtractInstance == null) {
            notFound()
            return
        }

        if (DNA_ExtractInstance.hasErrors()) {
            respond DNA_ExtractInstance.errors, view: 'edit'
            return
        }
        if (params.aliquot){
            DNA_ExtractInstance.save flush: true
            def exhaustAliquot = params.exhaustAliquot
            if (exhaustAliquot == 'True'){
                DNA_ExtractInstance.aliquot.each{ a->
                    a.exhausted = true
                    a.save flush: true
                }
            }

            request.withFormat {
                form {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'DNA_Extract.label', default: 'DNA_Extract'), DNA_ExtractInstance.id])
                    redirect DNA_ExtractInstance
                }
                '*' { respond DNA_ExtractInstance, [status: OK] }
            }
        }else{
            flash.message = "Please enter participant GeL ID, click Find Aliquot button then select aliquot/aliquots from the list."
            respond DNA_ExtractInstance, view: 'create'
        }
    }

    @Transactional
    def delete(DNA_Extract DNA_ExtractInstance) {

        if (DNA_ExtractInstance == null) {
            notFound()
            return
        }

        DNA_ExtractInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DNA_Extract.label', default: 'DNA_Extract'), DNA_ExtractInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'DNA_ExtractInstance.label', default: 'DNA_Extract'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
