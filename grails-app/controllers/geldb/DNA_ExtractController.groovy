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

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def getExcelImportService() {
        ExcelImportService.getService()
    }

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DNA_Extract.findAllByExhausted(false, params), model: [DNA_ExtractInstanceCount: DNA_Extract.count()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [DNA_ExtractInstanceList: DNA_Extract.findAllByExhausted(false, params), DNA_ExtractInstanceTotal: DNA_Extract.count()]
    }
    def filterPaneService

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
        if (sampleType == 'Samples awaiting FF extraction') {
            def aliquotInstanceList = Aliquot.createCriteria().list{
                and {
                    isEmpty('dNA_Extract')
                    eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy Frozen'))
                }
            }
            [aliquotInstanceList: aliquotInstanceList.sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}, title: sampleType]
        }else if (sampleType == 'Samples awaiting FFPE extraction') {
            def aliquotInstanceList = Aliquot.createCriteria().list{
                and {
                    isEmpty('dNA_Extract')
                    eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy FFPE, NBF'))
                }
            }
            [aliquotInstanceList: aliquotInstanceList.sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}, title: sampleType]
        }else if (sampleType == 'Samples awaiting germline extraction') {
            def aliquotInstanceList = Aliquot.createCriteria().list{
                and {
                    isEmpty('dNA_Extract')
                    eq('aliquotType', AliquotType.findByAliquotTypeName('Buffy Coat'))
                }
            }
            [aliquotInstanceList: aliquotInstanceList.sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}, title: sampleType]
        }
    }

    def upload = {

        Map CONFIG_BOOK_COLUMN_MAP = [
                sheet:'Sheet1',
                startRow: 1,
                columnMap:  [
                        //Col, Map-Key
                        'A':'val1',
                        'B':'val2',

                ]
        ]


        MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request;
        CommonsMultipartFile file = (CommonsMultipartFile) mpr.getFile("file");

        Workbook workbook = WorkbookFactory.create(file.inputStream)
        //Iterate through bookList and create/persists your domain instances
        def bookList = excelImportService.columns(workbook, CONFIG_BOOK_COLUMN_MAP)
        bookList.each { Map bookParams ->
            println bookParams.get('val1')}

        redirect action: "index", method: "GET"
    }

    @Secured(['ROLE_ADMIN'])
    def exportSampleManifestBioRepository(){

        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported Sample Manifest Biorepository.${params.extension}")

            def exportSampleManifestBioRepositoryData = DNA_Extract.list().sort {it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}

            def gelId = { domain, value ->
                return value.toString().replace('[','').replace(']','').replace('null','').replace(',','')
            }

            def anatomicalSite = { domain, value ->
                if (value.toString().startsWith('Fluid Specimen-')) {
                    return ''
                } else return value
            }

            List fields = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier","aliquot.specimen.anatomicalSite", "aliquot.aliquotType", "aliquot.blockNumber",
                           "aliquot.aliquotRanking", "aliquot.aliquotVolumeMass", "aliquot.unit", "test1", "test2", "test3", "test4", "test5","test6","test7", "test8"]
            Map labels = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier":"GEL Study ID", "aliquot.specimen.anatomicalSite":"Group",
                          "aliquot.aliquotType":"Investigation", "aliquot.blockNumber":"Profile", "aliquot.aliquotRanking":"Sample from", "aliquot.aliquotVolumeMass":"Sample type",
                          "aliquot.unit":"Container type", "test1":"External PID", "test8":"Barcode ", "test2":"Centre", "test3":"Volume", "test4":"Gender",
                          "test5":"DNA concentration", "test6":"Tumour type", "test7":" DNA A260/A280 ratio"]
            Map parameters = [title: "Sample Manifest", "column.widths": [0.2, 0.3, 0.5]]
            Map formatters = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier":gelId, "aliquot.specimen.anatomicalSite":anatomicalSite]

            exportService.export(params.format, response.outputStream, exportSampleManifestBioRepositoryData, fields, labels, formatters, parameters )
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportKPIReport (){

        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported KPI Report.${params.extension}")

            def exportKPIReportData = DNA_Extract.list().sort {it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}

            def gelId = { domain, value ->
                return value.toString().replace('[','').replace(']','').replace('null','').replace(',','')
            }

            def anatomicalSite = { domain, value ->
                if (value.toString().startsWith('Fluid Specimen-')) {
                    return ''
                } else return value
            }

            List fields = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier","aliquot.specimen.anatomicalSite", "aliquot.aliquotType", "aliquot.blockNumber",
                           "aliquot.aliquotRanking", "aliquot.aliquotVolumeMass", "aliquot.unit", "test2", "test3", "test4", "test5","test6","test7", "test8"]
            Map labels = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier":"GEL Study ID", "aliquot.specimen.anatomicalSite":"Patients approached",
                          "aliquot.aliquotType":"Patients consented", "aliquot.blockNumber":"FF QC fails diagnosis ineligible for GeL", "aliquot.aliquotRanking":"FF QC fails insufficient tissue", "aliquot.aliquotVolumeMass":"FF QC fails insufficient DNA",
                          "aliquot.unit":"FFPE QC fails diagnosis ineligible for GeL", "test2":"FFPE QC fails insufficient tissue", "test3":"FFPE QC fails insufficient DNA", "test4":"Blood sample fails insufficient DNA",
                          "test5":"Number of blood samples collected awaiting for matched tumou", "test6":"Number of tumour collected awaiting for blood sample", "test7":"Pairs awaiting for dispatch", "test8":" Pairs sent"]
            Map parameters = [title: "KPI Report", "column.widths": [0.2, 0.3, 0.5]]
            Map formatters = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier":gelId, "aliquot.specimen.anatomicalSite":anatomicalSite]

            exportService.export(params.format, response.outputStream, exportKPIReportData, fields, labels, formatters, parameters )
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

//    @Transactional
//    def saveDuplicates() {
//        def DNA_ExtractInstance = new DNA_Extract(params)
//        if (DNA_ExtractInstance == null) {
//            notFound()
//            return
//        }
//
//        if (DNA_ExtractInstance.hasErrors()) {
//            respond DNA_ExtractInstance.errors, view: 'create'
//            return
//        }
//
//        DNA_ExtractInstance.save flush: true
//        flash.message = "This is the newly created duplicate DNA extract with id ${DNA_ExtractInstance.id}"
//        redirect DNA_ExtractInstance
//    }

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
