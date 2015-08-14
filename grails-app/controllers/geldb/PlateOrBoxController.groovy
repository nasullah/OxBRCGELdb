package geldb

import grails.plugins.springsecurity.Secured
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.ss.usermodel.WorkbookFactory
import org.grails.plugin.filterpane.FilterPaneUtils
import org.grails.plugins.excelimport.ExcelImportService
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * PlateOrBoxController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class PlateOrBoxController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PlateOrBox.list(params), model: [plateOrBoxInstanceCount: PlateOrBox.count()]
    }

//    def list(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond PlateOrBox.list(params), model: [plateOrBoxInstanceCount: PlateOrBox.count()]
//    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [plateOrBoxInstanceList: PlateOrBox.list(params), plateOrBoxInstanceTotal: PlateOrBox.count()]
    }
    def filterPaneService

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ plateOrBoxInstanceList: filterPaneService.filter( params, PlateOrBox ),
                                     plateOrBoxInstanceTotal: filterPaneService.count( params, PlateOrBox ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def show(PlateOrBox plateOrBoxInstance) {
        respond plateOrBoxInstance
    }

    def create() {
        respond new PlateOrBox(params)
    }

    def getExcelImportService() {
        ExcelImportService.getService()
    }

    @Transactional
    def uploadScannerFile(){

        Map CONFIG_BOOK_COLUMN_MAP = [
                sheet:'Sheet1',
                startRow: 0,
                columnMap:  [
                        //Col, Map-Key
                        'A':'position',
                        'B':'barcode',
                ]
        ]

        def boxInstance = PlateOrBox.findById(params.long('box'))

        MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request;
        CommonsMultipartFile file = (CommonsMultipartFile) mpr.getFile("file");
        def fileExt = file.originalFilename.substring(file.originalFilename.lastIndexOf('.', file.originalFilename.length()))
        if (fileExt.toString() == '.xls'){
            Workbook workbook = WorkbookFactory.create(file.inputStream)
            //Iterate through bookList and create/persists your domain instances
            def bookList = excelImportService.columns(workbook, CONFIG_BOOK_COLUMN_MAP)
            bookList.each { Map bookParams ->
                def barcode = bookParams.get('barcode')?.toString()?.replace('.', '')?.replace('E9', '')
                def scannedPosition = bookParams.get('position')
                def letter = scannedPosition?.toString()?.substring(0,1)
                def number = scannedPosition?.toString()?.substring(1, scannedPosition?.toString()?.length())
                def identifiedSampleInstance = IdentifiedSample?.findByBarcode(barcode)
                def position = new Position(letter: letter, number: number, plateOrBox: boxInstance)
                if (position && identifiedSampleInstance){
                    position.addToContainedSamples(identifiedSampleInstance).save flush: true
                }
            }
        }else{
            flash.message = "load a xls file"
        }
        redirect boxInstance
    }

    @Transactional
    def save(PlateOrBox plateOrBoxInstance) {
        if (plateOrBoxInstance == null) {
            notFound()
            return
        }

        if (plateOrBoxInstance.hasErrors()) {
            respond plateOrBoxInstance.errors, view: 'create'
            return
        }

        plateOrBoxInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'plateOrBoxInstance.label', default: 'PlateOrBox'), plateOrBoxInstance.id])
                redirect plateOrBoxInstance
            }
            '*' { respond plateOrBoxInstance, [status: CREATED] }
        }
    }

    def edit(PlateOrBox plateOrBoxInstance) {
        respond plateOrBoxInstance
    }

    @Transactional
    def update(PlateOrBox plateOrBoxInstance) {
        if (plateOrBoxInstance == null) {
            notFound()
            return
        }

        if (plateOrBoxInstance.hasErrors()) {
            respond plateOrBoxInstance.errors, view: 'edit'
            return
        }

        plateOrBoxInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PlateOrBox.label', default: 'PlateOrBox'), plateOrBoxInstance.id])
                redirect plateOrBoxInstance
            }
            '*' { respond plateOrBoxInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PlateOrBox plateOrBoxInstance) {

        if (plateOrBoxInstance == null) {
            notFound()
            return
        }

        plateOrBoxInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PlateOrBox.label', default: 'PlateOrBox'), plateOrBoxInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'plateOrBoxInstance.label', default: 'PlateOrBox'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
