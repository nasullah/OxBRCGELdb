package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
/**
 * SolidSpecimenController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class SolidSpecimenController {

    def exportService
    def exportSolidSpecimenService
    def filterPaneService
    def pdfRenderingService
    def barcodeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SolidSpecimen.findAllByExhausted(false, params), model: [solidSpecimenInstanceCount: SolidSpecimen.findAllByExhausted(false).size()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [solidSpecimenInstanceList: SolidSpecimen.findAllByExhausted(false, params), solidSpecimenInstanceTotal: SolidSpecimen.findAllByExhausted(false).size()]
    }

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ solidSpecimenInstanceList: filterPaneService.filter( params, SolidSpecimen ),
                                     solidSpecimenInstanceTotal: filterPaneService.count( params, SolidSpecimen ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def findParticipantByGeLId() {
        def gelId= params.search
        if (gelId) {
            def participantByGeLId = Participant.createCriteria().get {
                studySubject {
                    eq('studySubjectIdentifier', gelId, [ignoreCase: true])
                }
            }
            if (participantByGeLId && gelId) {
                render(template: "participantList", model: [listParticipantByGeLId: participantByGeLId])
            }
        }
    }

    def findParticipantByBarcode() {
        def barcode= params.barcode
        if (barcode) {
            def participantByByBarcode = Participant.findByNHSNumber(barcode)
            if (participantByByBarcode && barcode) {
                render(template: "participantList", model: [listParticipantByGeLId: participantByByBarcode])
            }
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportSolidSpecimens(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported All Main Specimens and Reports.${params.extension}")
            def exportSolidSpecimensData = SolidSpecimen.list().sort {it.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
            exportService.export(params.format, response.outputStream, exportSolidSpecimensData, exportSolidSpecimenService.fields, exportSolidSpecimenService.labels, exportSolidSpecimenService.formatters, exportSolidSpecimenService.parameters )
        }
    }

    def renderBarcode(){
        if (!request.getFile('csvFile')?.originalFilename) {
            flash.message = "Please choose a file"
            redirect(uri: "/participant/summaryReport")
        }else{
            List <File> fileList = new ArrayList()
            List <String> barcodeList = new ArrayList()
            List <File> positionList = new ArrayList()
            def counter = 0
            request.getFile('csvFile').inputStream.splitEachLine(',')
                    { fields ->
                        def tempFile = File.createTempFile("temp"+counter,".png")
                        def barcode = fields[1].trim()
                        def input= barcode
                        barcodeService.generateCode128(input,tempFile.path);
                        barcodeList.add(fields[1].trim())
                        positionList.add(fields[0].trim())
                        fileList.add(tempFile)
                        counter ++
                    }
            def args = [template:"printbarcode", model:[fileList: fileList,barcodeList: barcodeList, positionList:positionList]]
            pdfRenderingService.render(args+[controller:this],response)
            for (int i = 0; i < fileList.size(); i ++){
                fileList.get(i).delete()
            }
        }
    }

    def awaitingMainSpecimen() {
        def fluidSpecimen = FluidSpecimen.list()
        fluidSpecimen = fluidSpecimen.findAll {specimen -> !SolidSpecimen.findByParticipant(specimen.participant)}
        def results = fluidSpecimen.participant.unique()
        [participantList: results.sort {it.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    def show(SolidSpecimen solidSpecimenInstance) {
        respond solidSpecimenInstance
    }

    def create() {
        respond new SolidSpecimen(params)
    }

    @Transactional
    def save(SolidSpecimen solidSpecimenInstance) {
        if (solidSpecimenInstance == null) {
            notFound()
            return
        }

        if (solidSpecimenInstance.hasErrors()) {
            respond solidSpecimenInstance.errors, view: 'create'
            return
        }

        solidSpecimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'solidSpecimenInstance.label', default: 'SolidSpecimen'), solidSpecimenInstance.id])
                redirect solidSpecimenInstance
            }
            '*' { respond solidSpecimenInstance, [status: CREATED] }
        }
    }

    def edit(SolidSpecimen solidSpecimenInstance) {
        respond solidSpecimenInstance
    }

    @Transactional
    def update(SolidSpecimen solidSpecimenInstance) {
        if (solidSpecimenInstance == null) {
            notFound()
            return
        }

        if (solidSpecimenInstance.hasErrors()) {
            respond solidSpecimenInstance.errors, view: 'edit'
            return
        }

        solidSpecimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SolidSpecimen.label', default: 'SolidSpecimen'), solidSpecimenInstance.id])
                redirect solidSpecimenInstance
            }
            '*' { respond solidSpecimenInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SolidSpecimen solidSpecimenInstance) {

        if (solidSpecimenInstance == null) {
            notFound()
            return
        }

        solidSpecimenInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SolidSpecimen.label', default: 'SolidSpecimen'), solidSpecimenInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'solidSpecimenInstance.label', default: 'SolidSpecimen'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
