package geldb

import grails.converters.XML
import grails.plugins.springsecurity.Secured
import org.grails.plugin.filterpane.FilterPaneUtils

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * FFPE_Tissue_ReportController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class FFPE_Tissue_ReportController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond FFPE_Tissue_Report.list(params), model: [FFPE_Tissue_ReportInstanceCount: FFPE_Tissue_Report.count()]
    }

//    def list(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond FFPE_Tissue_Report.list(params), model: [FFPE_Tissue_ReportInstanceCount: FFPE_Tissue_Report.count()]
//    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [FFPE_Tissue_ReportInstanceList: FFPE_Tissue_Report.list(params), FFPE_Tissue_ReportInstanceTotal: FFPE_Tissue_Report.count()]
    }
    def filterPaneService

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ FFPE_Tissue_ReportInstanceList: filterPaneService.filter( params, FFPE_Tissue_Report ),
                                     FFPE_Tissue_ReportInstanceTotal: filterPaneService.count( params, FFPE_Tissue_Report ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def show(FFPE_Tissue_Report FFPE_Tissue_ReportInstance) {
        respond FFPE_Tissue_ReportInstance
    }

    def create() {
        respond new FFPE_Tissue_Report(params)
    }

    def download(long id) {
        FFPE_Tissue_Report FFPE_Tissue_ReportInstance = FFPE_Tissue_Report.get(id)
        if ( FFPE_Tissue_ReportInstance == null) {
            flash.message = "Tissue Worksheet File not found."
            redirect (action:'index')
        } else {
            response.setContentType("APPLICATION/OCTET-STREAM")
            response.setHeader("Content-Disposition", "Attachment;Filename=\"${FFPE_Tissue_ReportInstance.tissueWorksheet}\"")

            def file = new File(FFPE_Tissue_ReportInstance.tissueWorksheet)
            def fileInputStream = new FileInputStream(file)
            def outputStream = response.getOutputStream()

            byte[] buffer = new byte[4096];
            int len;
            while ((len = fileInputStream.read(buffer)) > 0) {
                outputStream.write(buffer, 0, len);
            }

            outputStream.flush()
            outputStream.close()
            fileInputStream.close()
        }
    }

    def sampleCollectionDate(){
        def collectionDate = SolidSpecimen.get(params.long('solidSpecimen'))?.collectionDate
        if(collectionDate){
            render collectionDate as XML
        }
    }

    @Transactional
    def deleteTissueWorksheet(long id){
        FFPE_Tissue_Report FFPE_Tissue_ReportInstance = FFPE_Tissue_Report.get(id)
        def file = new File(FFPE_Tissue_ReportInstance.tissueWorksheet)
        if (file.exists()) {
            boolean fileDeletedSuccessfully = new File(FFPE_Tissue_ReportInstance.tissueWorksheet).delete()
            if (fileDeletedSuccessfully) {
                FFPE_Tissue_ReportInstance.tissueWorksheet = null
                FFPE_Tissue_ReportInstance.save flush: true
                flash.message = "Tissue Worksheet File has been deleted successfully."
                redirect(controller: 'FFPE_Tissue_Report', action: 'show', params: [id: FFPE_Tissue_ReportInstance.id])
            }
        }else {
            FFPE_Tissue_ReportInstance.tissueWorksheet = null
            FFPE_Tissue_ReportInstance.save flush: true
            flash.message = "You can load a new Tissue Worksheet File."
            redirect(controller: 'FFPE_Tissue_Report', action: 'show', params: [id: FFPE_Tissue_ReportInstance.id])
        }
    }

    @Transactional
    def upLoadTissueWorkSheet(){
        long id = params.long('id')
        FFPE_Tissue_Report FFPE_Tissue_ReportInstance = FFPE_Tissue_Report.get(id)
        def file = request.getFile('tissueWorksheetFile')
        if (file?.originalFilename){
            if (file?.empty) {
                flash.message = "File cannot be empty."
                redirect(controller:'FFPE_Tissue_Report',action: 'show', params: [id: FFPE_Tissue_ReportInstance.id])
                return
            }
            FFPE_Tissue_ReportInstance.tissueWorksheet = grailsApplication.config.uploadFolder +'TissueWorksheets/'+
                    FFPE_Tissue_ReportInstance.id.toString() + '.' + file.originalFilename
            def destinationFile = new File(FFPE_Tissue_ReportInstance.tissueWorksheet)

            try {
                file.transferTo(destinationFile)
                FFPE_Tissue_ReportInstance.save flush: true
                flash.message = "Tissue Worksheet File has been uploaded successfully."
                redirect(controller:'FFPE_Tissue_Report',action: 'show', params: [id: FFPE_Tissue_ReportInstance.id])
            }
            catch (Exception ex) {
                log.error(ex)
                FFPE_Tissue_ReportInstance.tissueWorksheet = null
                FFPE_Tissue_ReportInstance.save flush: true
                flash.message = "Tissue Worksheet File could not be uploaded."
                redirect(controller:'FFPE_Tissue_Report',action: 'show', params: [id: FFPE_Tissue_ReportInstance.id])
            }

        }else {
            flash.message = "Please choose a file."
            redirect(controller:'FFPE_Tissue_Report',action: 'show', params: [id: FFPE_Tissue_ReportInstance.id])
        }
    }

    @Transactional
    def save(FFPE_Tissue_Report FFPE_Tissue_ReportInstance) {
        if (FFPE_Tissue_ReportInstance == null) {
            notFound()
            return
        }

        if (FFPE_Tissue_ReportInstance.hasErrors()) {
            respond FFPE_Tissue_ReportInstance.errors, view: 'create'
            return
        }

        List<Snomed> snomedCodeList = new ArrayList<Snomed>();
        if (params.snomedCode0){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode0))
        }
        if (params.snomedCode1){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode1))
        }
        if (params.snomedCode2){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode2))
        }
        if (params.snomedCode3){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode3))
        }
        if (params.snomedCode4){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode4))
        }
        if (params.snomedCode5){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode5))
        }
        if (params.snomedCode6){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode6))
        }
        if (params.snomedCode7){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode7))
        }
        if (params.snomedCode8){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode8))
        }
        if (params.snomedCode9){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode9))
        }

        for (int i = 0; i <snomedCodeList.size(); i++ ){
            FFPE_Tissue_ReportInstance.addToSnomed(snomedCodeList.get(i)).save flush: true
        }

        def file = request.getFile('tissueWorksheetFile')
        if (file?.originalFilename){
            if (file?.empty) {
                flash.message = "File cannot be empty"
                redirect(controller:'solidSpecimen',action: 'show', params: [id: FFPE_Tissue_ReportInstance.solidSpecimen.id])
                return
            }
            FFPE_Tissue_ReportInstance.tissueWorksheet = grailsApplication.config.uploadFolder +'TissueWorksheets/'+
                    FFPE_Tissue_ReportInstance.id.toString() + '.' + file.originalFilename
            def destinationFile = new File(FFPE_Tissue_ReportInstance.tissueWorksheet)

            try {
                file.transferTo(destinationFile)
                FFPE_Tissue_ReportInstance.save flush: true
                flash.message = "Main Specimen Report is created with ID ${FFPE_Tissue_ReportInstance.id}."
                redirect(controller:'solidSpecimen',action: 'show', params: [id: FFPE_Tissue_ReportInstance.solidSpecimen.id])
            }
            catch (Exception ex) {
                log.error(ex)
                FFPE_Tissue_ReportInstance.tissueWorksheet = null
                FFPE_Tissue_ReportInstance.save flush: true
                flash.message = "Main Specimen Report is created with ID ${FFPE_Tissue_ReportInstance.id}. Tissue Worksheet File could not be uploaded."
                redirect(controller:'solidSpecimen',action: 'show', params: [id: FFPE_Tissue_ReportInstance.solidSpecimen.id])
            }

        } else {
            flash.message = "Main Specimen Report is created with ID ${FFPE_Tissue_ReportInstance.id}."
            redirect(controller:'solidSpecimen',action: 'show', params: [id: FFPE_Tissue_ReportInstance.solidSpecimen.id])
        }
    }

    def edit(FFPE_Tissue_Report FFPE_Tissue_ReportInstance) {
        respond FFPE_Tissue_ReportInstance
    }

    @Transactional
    def update(FFPE_Tissue_Report FFPE_Tissue_ReportInstance) {
        if (FFPE_Tissue_ReportInstance == null) {
            notFound()
            return
        }

        if (FFPE_Tissue_ReportInstance.hasErrors()) {
            respond FFPE_Tissue_ReportInstance.errors, view: 'edit'
            return
        }

        def oldSnomedCodeList = Snomed.findAllByFFPE_Tissue_Report(FFPE_Tissue_ReportInstance)
        if (!oldSnomedCodeList.empty){
            oldSnomedCodeList.each {it.delete flush: true}
        }
        List<Snomed> snomedCodeList = new ArrayList<Snomed>();
        if (params.snomedCode0){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode0))
        }
        if (params.snomedCode1){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode1))
        }
        if (params.snomedCode2){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode2))
        }
        if (params.snomedCode3){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode3))
        }
        if (params.snomedCode4){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode4))
        }
        if (params.snomedCode5){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode5))
        }
        if (params.snomedCode6){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode6))
        }
        if (params.snomedCode7){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode7))
        }
        if (params.snomedCode8){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode8))
        }
        if (params.snomedCode9){
            snomedCodeList.add(new Snomed(snomedCode:params.snomedCode9))
        }

        for (int i = 0; i <snomedCodeList.size(); i++ ){
            FFPE_Tissue_ReportInstance.addToSnomed(snomedCodeList.get(i)).save flush: true
        }

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FFPE_Tissue_Report.label', default: 'FFPE_Tissue_Report'), FFPE_Tissue_ReportInstance.id])
                redirect(controller:'solidSpecimen',action: 'show', params: [id: FFPE_Tissue_ReportInstance.solidSpecimen.id])
            }
            '*' { respond FFPE_Tissue_ReportInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(FFPE_Tissue_Report FFPE_Tissue_ReportInstance) {

        if (FFPE_Tissue_ReportInstance == null) {
            notFound()
            return
        }

        if (FFPE_Tissue_ReportInstance.tissueWorksheet){
            def tissueWorksheetFile = new File(FFPE_Tissue_ReportInstance.tissueWorksheet)
            if (tissueWorksheetFile.exists()){
                boolean fileDeletedSuccessfully = new File(FFPE_Tissue_ReportInstance.tissueWorksheet).delete()
                if (fileDeletedSuccessfully){
                    FFPE_Tissue_ReportInstance.delete flush: true
                    flash.message = "Main Specimen Report Instance has been deleted"
                    redirect action: "index", method: "GET"
                } else{
                    flash.message = "Could not delete the Tissue Worksheet file"
                    redirect action: "index", method: "GET"
                }
            }

        }else {
            FFPE_Tissue_ReportInstance.delete flush: true
            flash.message = "Main Specimen Report Instance has been deleted"
            redirect action: "index", method: "GET"
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'FFPE_Tissue_ReportInstance.label', default: 'FFPE_Tissue_Report'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
