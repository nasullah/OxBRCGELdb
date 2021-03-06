package geldb

import grails.converters.*
import grails.plugins.springsecurity.Secured
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent
import org.grails.plugin.filterpane.FilterPaneUtils

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * DispatchRecordController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class DispatchRecordController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def exportService
    def grailsApplication  //inject GrailsApplication
    def sampleMetadataExportService
    def qcTestExportService
    def omicsSampleMetadataExportService
    def allDispatchedDNASamplesService
    def allDispatchedOmicsSamplesService
    def filterPaneService
    def allDispatchedSamplesDataService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DispatchRecord.list(max: params.max, offset: params.offset, sort: "sentOn", order: "desc"), model: [dispatchRecordInstanceCount: DispatchRecord.count()]
    }

    def qcTestExport (){
        if(params?.format && params.format != "html"){
            def dispatchRecord = DispatchRecord.findById(params.long('dispatchRecord'))
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=Oxford_GMC_to_GEL_Test_Results_Cancer_${dispatchRecord?.sentOn?.format('yyyy-MM-dd')?.toString()?.replace('-','_')}.${params.extension}")
            def dispatchItems = DispatchItem.findAll {dispatchedBox.dispatchRecord == dispatchRecord}
            dispatchItems = dispatchItems.findAll {DNA_Extract.findById(it.identifiedSample.id)}
            exportService.export(params.format, response.outputStream, dispatchItems, qcTestExportService.summaryQCFields, qcTestExportService.summaryQCLabels, qcTestExportService.summaryQCFormatters, qcTestExportService.summaryQCParameters )
            exportService.export(params.format, response.outputStream, dispatchItems, qcTestExportService.trineanOD260Fields, qcTestExportService.trineanOD260Labels, qcTestExportService.trineanOD260Formatters,qcTestExportService.trineanOD260Parameters )
//            exportService.export(params.format, response.outputStream, dispatchItems, qcTestExportService.nanodropConcentrationFields, qcTestExportService.nanodropConcentrationLabels, qcTestExportService.nanodropConcentrationformatters,qcTestExportService.nanodropConcentrationParameters )
            exportService.export(params.format, response.outputStream, dispatchItems, qcTestExportService.qubitFields, qcTestExportService.qubitLabels, qcTestExportService.qubitFormatters,qcTestExportService.qubitParameters )
            def ffpeSamples = dispatchItems.findAll {ffpe -> ffpe.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')}
            exportService.export(params.format, response.outputStream, ffpeSamples, qcTestExportService.deltaCqFields, qcTestExportService.deltaCqLabels, qcTestExportService.deltaCqFormatters,qcTestExportService.deltaCqParameters )
            def tumourSamples = dispatchItems.findAll {tumour -> tumour?.identifiedSample?.aliquot?.specimen?.first()?.instanceOf(SolidSpecimen)}
            exportService.export(params.format, response.outputStream, tumourSamples, qcTestExportService.tumourContentFields, qcTestExportService.tumourContentLabels, qcTestExportService.tumourContentFormatters,qcTestExportService.tumourContentParameters )
            def filteredTumourSamplesForCellularity = tumourSamples.findAll {it.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.first() != 'blood_tumour'}
            filteredTumourSamplesForCellularity = filteredTumourSamplesForCellularity.findAll {it.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.first() != 'bone_marrow_aspirate_tumour_sorted_cells'}
            exportService.export(params.format, response.outputStream, filteredTumourSamplesForCellularity, qcTestExportService.cellularityFields, qcTestExportService.cellularityLabels, qcTestExportService.cellularityFormatters,qcTestExportService.cellularityParameters )
            def filteredTumourSamplesForNecrosis = filteredTumourSamplesForCellularity.findAll {it.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.first() != 'bone_marrow_aspirate_tumour_cells'}
            exportService.export(params.format, response.outputStream, filteredTumourSamplesForNecrosis, qcTestExportService.necrosisPercentageFields, qcTestExportService.necrosisPercentageLabels, qcTestExportService.necrosisPercentageFormatters,qcTestExportService.necrosisPercentageParameters )
        }
    }

    def sampleMetadataExport(){
        if(params?.format && params.format != "html"){
            def dispatchRecord = DispatchRecord.findById(params.long('dispatchRecord'))
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=Oxford_GMC_to_GEL_Sample_Metadata_Cancer_${dispatchRecord?.sentOn?.format('yyyy-MM-dd')?.toString()?.replace('-','_')}.${params.extension}")
            def dnaSamples = DispatchItem.findAll {dispatchedBox.dispatchRecord == dispatchRecord}
            dnaSamples = dnaSamples.findAll {DNA_Extract.findById(it.identifiedSample.id)}
            def omicsSamples = DispatchItem.findAll {dispatchedBox.dispatchRecord == dispatchRecord}
            omicsSamples = omicsSamples.findAll {Aliquot.findById(it.identifiedSample.id)}
            exportService.export(params.format, response.outputStream, dnaSamples, sampleMetadataExportService.fields, sampleMetadataExportService.labels, sampleMetadataExportService.formatters, sampleMetadataExportService.parameters)
            exportService.export(params.format, response.outputStream, omicsSamples, omicsSampleMetadataExportService.fields, [:], omicsSampleMetadataExportService.formatters, omicsSampleMetadataExportService.parameters)
        }
    }

    def exportAllDispatchedItemsData() {
        if (params?.format && params.format != "html") {
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= All Dispatched Item Data.${params.extension}")
            def allDispatchedItems = DispatchItem.list()
            def dnaSamples = allDispatchedItems.findAll {DNA_Extract.findById(it.identifiedSample.id)}
            exportService.export(params.format, response.outputStream, dnaSamples, allDispatchedSamplesDataService.fields, allDispatchedSamplesDataService.labels, allDispatchedSamplesDataService.formatters, allDispatchedSamplesDataService.parameters)
        }
    }

    def exportAllDispatchedDNASamples(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= All Dispatched DNA Samples.${params.extension}")
            def allDispatchedItems = DispatchItem.list()
            def dnaSamples = allDispatchedItems.findAll {DNA_Extract.findById(it.identifiedSample.id)}
            exportService.export(params.format, response.outputStream, dnaSamples, allDispatchedDNASamplesService.fields, allDispatchedDNASamplesService.labels, allDispatchedDNASamplesService.formatters, allDispatchedDNASamplesService.parameters )
        }
    }

    def exportAllDispatchedOmicsSamples(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= All Dispatched Omics Samples.${params.extension}")
            def allDispatchedItems = DispatchItem.list()
            def omicsSamples = allDispatchedItems.findAll {Aliquot.findById(it.identifiedSample.id)}
            exportService.export(params.format, response.outputStream, omicsSamples, allDispatchedOmicsSamplesService.fields, allDispatchedOmicsSamplesService.labels, allDispatchedOmicsSamplesService.formatters, allDispatchedOmicsSamplesService.parameters )
        }
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [dispatchRecordInstanceList: DispatchRecord.list(max: params.max, offset: params.offset, sort: "sentOn", order: "desc"), dispatchRecordInstanceTotal: DispatchRecord.count()]
    }

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ dispatchRecordInstanceList: filterPaneService.filter( params, DispatchRecord ),
                                     dispatchRecordInstanceTotal: filterPaneService.count( params, DispatchRecord ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def show(DispatchRecord dispatchRecordInstance) {
        def listDispatchRecordAuditLogData = AuditLogEvent.findAllByPersistedObjectId(dispatchRecordInstance?.id)
        respond dispatchRecordInstance, model: [listAuditLogData: listDispatchRecordAuditLogData]
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
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

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
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

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
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
