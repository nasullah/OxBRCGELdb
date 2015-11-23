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

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def getExcelImportService() {
        ExcelImportService.getService()
    }

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
        respond new DNA_Extract(params)
    }

    def workLists() {
        def sampleType = params.sampleType
        if (sampleType == 'Samples awaiting FF DNA extraction') {
            def aliquotInstanceList = Aliquot.createCriteria().list{
                and {
                    isEmpty('dNA_Extract')
                    eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy Frozen'))
                }
            }
            [aliquotInstanceList: aliquotInstanceList.sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}, title: sampleType]
        }else if (sampleType == 'Samples awaiting FFPE DNA extraction') {
            def aliquotInstanceList = Aliquot.createCriteria().list{
                and {
                    isEmpty('dNA_Extract')
                    or {
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy FFPE, NBF'))
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy FFPE'))
                    }
                }
            }
            [aliquotInstanceList: aliquotInstanceList.sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}, title: sampleType]
        }else if (sampleType == 'Samples awaiting Germline DNA extraction') {
            def aliquotInstanceList = Aliquot.createCriteria().list{
                and {
                    isEmpty('dNA_Extract')
                    eq('aliquotType', AliquotType.findByAliquotTypeName('Buffy Coat'))
                }
            }
            [aliquotInstanceList: aliquotInstanceList.sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}, title: sampleType]
        }
    }

    def test(){
        def ffDNAExtract = DNA_Extract.createCriteria().list{
            or {
                and {
                    aliquot {
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy Frozen'))
                    }
                    ge("dNAConcentrationNanodrop", '1.8'.toFloat())
                    ge("dNAConcentrationQubit", '18'.toFloat())
                }
                and {
                    aliquot {
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Buffy Coat'))
                    }
                    ge("dNAConcentrationNanodrop", '3'.toFloat())
                    ge("dNAConcentrationQubit", '30'.toFloat())
                    ge("dNAAmount", '100'.toDouble())
                }
                and {
                    aliquot {
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy FFPE, NBF'))
                    }
                    lt("delatQC", '2.9'.toDouble())
                    ge("dNAConcentrationNanodrop", '1.8'.toFloat())
                    ge("dNAConcentrationQubit", '18'.toFloat())
                }
            }

        }
        def p = Participant.createCriteria().list {
            specimen {
                aliquot {
                    eq('aliquotType', AliquotType.findByAliquotTypeName('Buffy Coat'))
                    dNA_Extract {
                        ge("dNAConcentrationNanodrop", '3'.toFloat())
                        ge("dNAConcentrationQubit", '30'.toFloat())
                        ge("dNAAmount", '100'.toDouble())
                    }
                }
            }
        }.id

        print(p)

        ffDNAExtract = ffDNAExtract.findAll {it?.aliquot?.specimen?.participant?.id == p}
        print(ffDNAExtract)
        redirect action: "index", method: "GET"

//        and {
//            aliquot {
//                eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy Frozen'))
//            }
//            ge("dNAConcentrationNanodrop", 1.8)
//            ge("dNAConcentrationQubit", 18)
//        }

//        def glDNAExtract = DNA_Extract.createCriteria().list{
//            and {
//                aliquot {
//                    eq('aliquotType', AliquotType.findByAliquotTypeName('Buffy Coat'))
//                }
//                ge("dNAConcentrationNanodrop", 3)
//                ge("dNAConcentrationQubit", 30)
//                ge("dNAAmount", 100)
//            }
//        }
//
//        def ffpeDNAExtract = DNA_Extract.createCriteria().list{
//            and {
//                aliquot {
//                    eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy FFPE, NBF'))
//                }
//                lt("delatQC", 2.9)
//                ge("dNAConcentrationNanodrop", 1.8)
//                ge("dNAConcentrationQubit", 18)
//            }
//        }
    }

    @Transactional
    def uploadFile() {
        Map CONFIG_DNA_EXTRACT_COLUMN_MAP = [
                sheet:'GEL',
                startRow: 1,
                columnMap:  [
                        'A':'rowNumber',
                        'B':'Sample ID',
                        'C':'Sample',
                        'D':'User name',
                        'E':'Date',
                        'F':'Nanodrop concentration',
                        'G':'Unit',
                        'H':'260/280',
                        'I':'260/230',
                        'J':'Sample Type',
                        'K':'Qubit concentration',
                        'L':'Unit',
                        'M':'Delta Cq',
                        'N':'Pass/Fail',
                        'O':'Pass/Fail Reason',
                        'P':'Notes',
                        'Q':'Barcode original aliquot',
                        'R':'Barcode DNA tube',
                        'S':'Experiment name',
                        'T':'Kit',
                        'U':'Volume',
                        'V':'Units',
                        'W':'Exhaust original aliquot',
                        'X':'Elution'
                ]
        ]
        MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request;
        CommonsMultipartFile file = (CommonsMultipartFile) mpr.getFile("file");
        if (!file.originalFilename) {
            flash.message = "Please choose a file"
            redirect action: "index", method: "GET"
        } else{
            def passedList =[]
            def failedList =[]
            def duplicatedList =[]
            Workbook workbook = WorkbookFactory.create(file.inputStream)
            def dnaExtractList = excelImportService.columns(workbook, CONFIG_DNA_EXTRACT_COLUMN_MAP)
            dnaExtractList.each { Map dnaExtractParams ->
                def rowNumber = null
                def sampleID = null
                def aliquot = null
                def dNAConcentrationNanodrop
                def dNAConcentrationQubit
                def extractionDate = null
                def extractedBy = null
                def participantID
                def sapphireIdentifier = null
                def barcode
                def dNAAmount
                def delatQC
                def a260A280
                def a260A230
                def experimentName
                def extractionKit = null
                def extractionType = null
                def existingDNAExtract
                def notes
                def passFailureReason

                if (dnaExtractParams.get('rowNumber').toString().trim().isNumber()){
                    rowNumber = Double?.valueOf(dnaExtractParams.get('rowNumber')?.toString()?.trim())?.toInteger()?.toString()
                }
                if (dnaExtractParams.get('Sample ID').toString().trim().isNumber()){
                    sampleID = Double?.valueOf(dnaExtractParams.get('Sample ID')?.toString()?.trim())?.toInteger()?.toString()
                }
                if (dnaExtractParams.get('Barcode original aliquot')){
                    if(dnaExtractParams.get('Barcode original aliquot').toString().trim().isNumber()){
                        def barcodeOfAliquot = Double?.valueOf(dnaExtractParams.get('Barcode original aliquot')?.toString()?.trim())?.toInteger()?.toString()
                        aliquot = Aliquot.findByBarcode(barcodeOfAliquot)
                    }else {
                        def barcodeOfAliquot = dnaExtractParams.get('Barcode original aliquot')?.toString()?.trim()
                        aliquot = Aliquot.findByBarcode(barcodeOfAliquot)
                    }
                }
                dNAConcentrationNanodrop = dnaExtractParams.get('Nanodrop concentration')?.toString()?.trim()
                dNAConcentrationQubit = dnaExtractParams.get('Qubit concentration')?.toString()?.trim()
                if (dnaExtractParams.get('Date') && dnaExtractParams.get('Date')?.toString()?.trim()?.size() == 10){
                    extractionDate =Date?.parse("yyyy-MM-dd", dnaExtractParams.get('Date')?.toString()?.trim())
                }
                if (dnaExtractParams.get('User name')){
                    extractedBy = StaffMember?.findByStaffName(dnaExtractParams.get('User name')?.toString()?.trim())
                }
                participantID = aliquot?.specimen?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}
                if (aliquot && participantID){
                    if (aliquot?.aliquotType?.aliquotTypeName == 'Buffy Coat'){
                        sapphireIdentifier = participantID?.toString() + "_" + "GL" + "_" + dnaExtractParams.get('Elution')?.toString()?.trim()
                    }else {
                        sapphireIdentifier = participantID?.toString() + "_" + aliquot?.aliquotType?.aliquotTypeName?.toString()?.replace(" ","") + "_" + dnaExtractParams.get('Elution')?.toString()?.trim()
                    }
                }
                if (dnaExtractParams.get('Barcode DNA tube').toString().trim().isNumber()){
                    barcode = Double?.valueOf(dnaExtractParams.get('Barcode DNA tube')?.toString()?.trim())?.toInteger()?.toString()
                }else{
                    barcode = dnaExtractParams.get('Barcode DNA tube')?.toString()?.trim()
                }
                dNAAmount = dnaExtractParams.get('Volume')?.toString()?.trim()
                delatQC = dnaExtractParams.get('Delta Cq')?.toString()?.trim()
                a260A280 = dnaExtractParams.get('260/280')?.toString()?.trim()
                a260A230 = dnaExtractParams.get('260/230')?.toString()?.trim()
                experimentName = dnaExtractParams.get('Experiment name')?.toString()?.trim()
                notes = dnaExtractParams.get('Notes')?.toString()?.trim()
                passFailureReason = dnaExtractParams.get('Pass/Fail Reason')?.toString()?.trim()
                if (dnaExtractParams.get('Kit')){
                    extractionKit = DNAExtractionKit.findByExtractionKitName(dnaExtractParams.get('Kit')?.toString()?.trim())
                }
                if (dnaExtractParams.get('Sample Type')){
                    extractionType = ExtractionType.findByExtractionTypeName(dnaExtractParams.get('Sample Type')?.toString()?.trim())
                }
                if (sapphireIdentifier){
                    existingDNAExtract = DNA_Extract.findBySapphireIdentifier(sapphireIdentifier)
                }
                def row = 'Row Number ' + rowNumber  + '--------------------' +'Sample ID ' + sampleID  + '--------------------' + 'Elution ' + sapphireIdentifier + '--------------------' + 'Aliquot barcode ' + aliquot?.barcode
                if (existingDNAExtract){
                    duplicatedList.add(row)
                } else if (aliquot
                            && dNAConcentrationNanodrop
                            && dNAConcentrationQubit
                            && extractionDate
                            && dNAAmount
                            && a260A280
                            && a260A230
                            && experimentName
                            && extractionKit
                            && extractionType
                            && !existingDNAExtract) {
                    def dnaExtractInstance = new DNA_Extract(aliquot: aliquot, dNAConcentrationNanodrop: dNAConcentrationNanodrop, dNAConcentrationQubit: dNAConcentrationQubit, extractionDate: extractionDate,
                                                            extractedBy: extractedBy, sapphireIdentifier: sapphireIdentifier, barcode: barcode, dNAAmount: dNAAmount, notes: notes, passFailReason: passFailureReason,
                                                            delatQC: delatQC, a260A280: a260A280, a260A230: a260A230, experimentName: experimentName, extractionKit: extractionKit, extractionType: extractionType)
                    dnaExtractInstance.save failOnError: true
                    if (dnaExtractParams.get('Exhaust original aliquot').toString().trim() == "Yes"){
                        aliquot.exhausted = true
                        aliquot.save flush: true
                    }
                    passedList.add(row)
                }else {
                    failedList.add(row)
                }
            }
            [passedList : passedList, failedList : failedList, duplicatedList : duplicatedList]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportKPIReport (){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported KPI Report.${params.extension}")
            def exportKPIReportData = DNA_Extract.list().sort {it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
            exportService.export(params.format, response.outputStream, exportKPIReportData, exportKPIReportService.fields, exportKPIReportService.labels, exportKPIReportService.formatters, exportKPIReportService.parameters )
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
