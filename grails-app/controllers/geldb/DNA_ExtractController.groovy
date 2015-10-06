package geldb

import grails.converters.XML

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
        Map CONFIG_BOOK_COLUMN_MAP = [
                sheet:'GEL',
                startRow: 1,
                columnMap:  [
                        'A':'',
                        'B':'Sample ID',
                        'C':'Elution',
                        'D':'',
                        'E':'Date and Time',
                        'F':'Nucleic Acid',
                        'G':'',
                        'H':'',
                        'I':'',
                        'J':'260/280',
                        'K':'260/230',
                        'L':'Sample Type',
                        'M':'',
                        'N':'Qubit',
                        'O':'Barcode aliquot',
                        'P':'Barcode tube',
                        'Q':'Experiment name',
                        'R':'Kit',
                        'S':'Volume',
                ]
        ]
        MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request;
        CommonsMultipartFile file = (CommonsMultipartFile) mpr.getFile("file");
        if (!file.originalFilename) {
            flash.message = "Please choose a file"
            redirect action: "index", method: "GET"
        } else{
            def counter = 0
            Workbook workbook = WorkbookFactory.create(file.inputStream)
            def bookList = excelImportService.columns(workbook, CONFIG_BOOK_COLUMN_MAP)
            bookList.each { Map bookParams ->
                println bookParams.get('val1')
                            def aliquot = Aliquot.findByBarcodeAndExhausted(bookParams.get('Barcode aliquot')?.toString()?.trim(), false)
                print(aliquot)
                            def dNAConcentrationNanodrop = bookParams.get('Nucleic Acid')?.toString()?.trim()
                print(dNAConcentrationNanodrop)
                            def dNAConcentrationQubit = bookParams.get('Qubit')?.toString()?.trim()
                print(dNAConcentrationQubit)
                            def extractionDate =Date.parse("yyyy-MM-dd", bookParams.get('Date and Time')?.toString()?.trim())
                print(extractionDate)
                            def extractedBy = StaffMember.findByStaffName(bookParams.get('Barcode aliquot').toString().trim())
                print(extractedBy)
                            def sapphireIdentifier = bookParams.get('Elution').toString().trim()
                print(sapphireIdentifier)
                            def barcode = bookParams.get('Barcode tube').toString().trim()
                print(barcode)
                            def dNAAmount = bookParams.get('Volume').toString().trim()
                print(dNAAmount)
                            def delatQC = 1
                print(delatQC)
                            def a260A280 = bookParams.get('260/280').toString().trim()
                print(a260A280)
                            def a260A230 = bookParams.get('260/230').toString().trim()
                print(a260A230)
                            def experimentName = bookParams.get('Experiment name').toString().trim()
                print(experimentName)
                            def extractionKit = DNAExtractionKit.findByExtractionKitName(bookParams.get('Kit').toString().trim())
                print(extractionKit)
                            def extractionType = ExtractionType.findByExtractionTypeName(bookParams.get('Sample Type').toString().trim())
                print(extractionType)
                            def participantID = aliquot?.specimen?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}
                print(participantID)
                            boolean check = bookParams.get('Sample ID').toString().trim().equals(participantID)
                print(check)
                            if (aliquot
                                        && dNAConcentrationNanodrop
                                        && dNAConcentrationQubit
                                        && extractionDate
                                        && dNAAmount
                                        && a260A280
                                        && a260A230
                                        && experimentName
                                        && extractionKit
                                        && extractionType) {
                                def dnaExtractInstance = new DNA_Extract(aliquot: aliquot, dNAConcentrationNanodrop: dNAConcentrationNanodrop, dNAConcentrationQubit: dNAConcentrationQubit, extractionDate: extractionDate,
                                                                        extractedBy: extractedBy, sapphireIdentifier: sapphireIdentifier, barcode: barcode, dNAAmount: dNAAmount,
                                                                        delatQC: delatQC, a260A280: a260A280, a260A230: a260A230, experimentName: experimentName, extractionKit: extractionKit, extractionType: extractionType)
                                dnaExtractInstance.save failOnError: true
                                counter ++
                            }
                    }
            if (counter > 0){
                flash.message = "${counter} DNA extract record have been created"
                redirect action: "index", method: "GET"
            }else{
                flash.message = "No DNA extract record has been created"
                redirect action: "index", method: "GET"
            }
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
