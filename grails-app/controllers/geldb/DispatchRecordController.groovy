package geldb

import grails.converters.*
import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * DispatchRecordController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class DispatchRecordController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def exportService
    def grailsApplication  //inject GrailsApplication
    def sampleMetadataExportService
    def qcTestExportService
    def omicsSampleMetadataExportService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DispatchRecord.list(params), model: [dispatchRecordInstanceCount: DispatchRecord.count()]
    }

    def qcTestExport (){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=GMC_to_GEL_QC_test.${params.extension}")
            def dispatchRecord = DispatchRecord.findById(params.long('dispatchRecord'))
            def dispatchItems = DispatchItem.findAll {dispatchedBox.dispatchRecord == dispatchRecord}
            dispatchItems = dispatchItems.findAll {DNA_Extract.findById(it.identifiedSample.id)}
            exportService.export(params.format, response.outputStream, dispatchItems, qcTestExportService.summaryQCFields, qcTestExportService.summaryQCLabels, qcTestExportService.summaryQCFormatters, qcTestExportService.summaryQCParameters )
            exportService.export(params.format, response.outputStream, dispatchItems, qcTestExportService.trineanOD260Fields, qcTestExportService.trineanOD260Labels, qcTestExportService.trineanOD260Formatters,qcTestExportService.trineanOD260Parameters )
            exportService.export(params.format, response.outputStream, dispatchItems, qcTestExportService.nanodropConcentrationFields, qcTestExportService.nanodropConcentrationLabels, qcTestExportService.nanodropConcentrationformatters,qcTestExportService.nanodropConcentrationParameters )
            exportService.export(params.format, response.outputStream, dispatchItems, qcTestExportService.qubitFields, qcTestExportService.qubitLabels, qcTestExportService.qubitFormatters,qcTestExportService.qubitParameters )
            def ffpeSamples = dispatchItems.findAll {ffpe -> ffpe.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')}
            exportService.export(params.format, response.outputStream, ffpeSamples, qcTestExportService.deltaCqFields, qcTestExportService.deltaCqLabels, qcTestExportService.deltaCqFormatters,qcTestExportService.deltaCqParameters )
        }
    }

    def sampleMetadataExport(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=GMC_GEL_Sample_Metadata_Cancer.${params.extension}")
            def dispatchRecord = DispatchRecord.findById(params.long('dispatchRecord'))
            def dnaSamples = DispatchItem.findAll {dispatchedBox.dispatchRecord == dispatchRecord}
            dnaSamples = dnaSamples.findAll {DNA_Extract.findById(it.identifiedSample.id)}
            def omicsSamples = DispatchItem.findAll {dispatchedBox.dispatchRecord == dispatchRecord}
            omicsSamples = omicsSamples.findAll {Aliquot.findById(it.identifiedSample.id)}
            exportService.export(params.format, response.outputStream, dnaSamples, sampleMetadataExportService.fields, sampleMetadataExportService.labels, sampleMetadataExportService.formatters, sampleMetadataExportService.parameters)
            exportService.export(params.format, response.outputStream, omicsSamples, omicsSampleMetadataExportService.fields, [:], omicsSampleMetadataExportService.formatters, omicsSampleMetadataExportService.parameters)
        }
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DispatchRecord.list(params), model: [dispatchRecordInstanceCount: DispatchRecord.count()]

    }

    def show(DispatchRecord dispatchRecordInstance) {
        respond dispatchRecordInstance
    }

    def create() {
        respond new DispatchRecord(params)
    }

    def findDestination() {
        def destination = Destination.findById(params.destinationId)
        if(destination){
            render destination as XML
        }
    }

    @Transactional
    def save(DispatchRecord dispatchRecordInstance) {
        if (dispatchRecordInstance == null) {
            notFound()
            return
        }

        if (dispatchRecordInstance.hasErrors()) {
            respond dispatchRecordInstance.errors, view: 'create'
            return
        }

        dispatchRecordInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'dispatchRecordInstance.label', default: 'DispatchRecord'), dispatchRecordInstance.id])
                redirect dispatchRecordInstance
            }
            '*' { respond dispatchRecordInstance, [status: CREATED] }
        }
    }

    def edit(DispatchRecord dispatchRecordInstance) {
        respond dispatchRecordInstance
    }

    @Transactional
    def update(DispatchRecord dispatchRecordInstance) {
        if (dispatchRecordInstance == null) {
            notFound()
            return
        }

        if (dispatchRecordInstance.hasErrors()) {
            respond dispatchRecordInstance.errors, view: 'edit'
            return
        }

        dispatchRecordInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DispatchRecord.label', default: 'DispatchRecord'), dispatchRecordInstance.id])
                redirect dispatchRecordInstance
            }
            '*' { respond dispatchRecordInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(DispatchRecord dispatchRecordInstance) {

        if (dispatchRecordInstance == null) {
            notFound()
            return
        }

        dispatchRecordInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DispatchRecord.label', default: 'DispatchRecord'), dispatchRecordInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'dispatchRecordInstance.label', default: 'DispatchRecord'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
