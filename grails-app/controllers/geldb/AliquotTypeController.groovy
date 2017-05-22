package geldb

import grails.plugins.springsecurity.Secured
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * AliquotTypeController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class AliquotTypeController {
    def exportService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AliquotType.list(params), model: [aliquotTypeInstanceCount: AliquotType.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AliquotType.list(params), model: [aliquotTypeInstanceCount: AliquotType.count()]
    }

    def show(AliquotType aliquotTypeInstance) {
        def listAliquotTypeAuditLogData = AuditLogEvent.findAllByPersistedObjectId(aliquotTypeInstance?.id)
        respond aliquotTypeInstance, model: [listAuditLogData: listAliquotTypeAuditLogData]
    }

    def enumerationsExport(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Enumerations.${params.extension}")

            def aliquotTypeList = AliquotType.list()
            List aliquotTypeFields = ["aliquotTypeName"]
            Map aliquotTypeLabels = ["aliquotTypeName":"aliquotType.aliquotTypeName"]
            exportService.export(params.format, response.outputStream, aliquotTypeList, aliquotTypeFields, aliquotTypeLabels, [:], [:])

            def anatomicalSiteList = AnatomicalSite.list()
            List anatomicalSiteFields = ["anatomicalSiteName"]
            Map anatomicalSiteLabels = ["anatomicalSiteName":"anatomicalSite.anatomicalSiteName"]
            exportService.export(params.format, response.outputStream, anatomicalSiteList, anatomicalSiteFields, anatomicalSiteLabels, [:], [:])

            def cellularityList = Cellularity.findAll()
            List cellularityFields = ["value"]
            Map cellularityLabels = ["value":"cellularity.cellularityName"]
            exportService.export(params.format, response.outputStream, cellularityList, cellularityFields, cellularityLabels, [:], [:])

            def centreList = Centre.list()
            List centreFields = ["centreName"]
            Map centreLabels = ["centreName":"Centre.centreName"]
            exportService.export(params.format, response.outputStream, centreList, centreFields, centreLabels, [:], [:])

            def collectionMethodList = CollectionMethod.list()
            List collectionMethodFields = ["collectionMethodName"]
            Map collectionMethodLabels = ["collectionMethodName":"collectionMethod.collectionMethodName"]
            exportService.export(params.format, response.outputStream, collectionMethodList, collectionMethodFields, collectionMethodLabels, [:], [:])

            def dNAExtractionKitList = DNAExtractionKit.list()
            List dNAExtractionKitFields = ["extractionKitName"]
            Map dNAExtractionKitLabels = ["extractionKitName":"extractionKit.extractionKitName"]
            exportService.export(params.format, response.outputStream, dNAExtractionKitList, dNAExtractionKitFields, dNAExtractionKitLabels, [:], [:])

            def extractionTypeList = ExtractionType.list()
            List extractionTypeFields = ["extractionTypeName"]
            Map extractionTypeLabels = ["extractionTypeName":"extractionType.extractionTypeName"]
            exportService.export(params.format, response.outputStream, extractionTypeList, extractionTypeFields, extractionTypeLabels, [:], [:])

            def processingScheduleList = ProcessingSchedule.findAll()
            List processingScheduleFields = ["value"]
            Map processingScheduleLabels = ["value":"processingSchedule.processingScheduleName"]
            exportService.export(params.format, response.outputStream, processingScheduleList, processingScheduleFields, processingScheduleLabels, [:], [:])

            def time12HourlyList = Time12Hourly.findAll()
            List time12HourlyFields = ["value"]
            Map time12HourlyLabels = ["value":"fixationPeriod.fixationPeriodName"]
            exportService.export(params.format, response.outputStream, time12HourlyList, time12HourlyFields, time12HourlyLabels, [:], [:])

            def fixationTypeList = FixationType.findAll()
            List fixationTypeFields = ["value"]
            Map fixationTypeLabels = ["value":"fixationType.fixationTypeName"]
            exportService.export(params.format, response.outputStream, fixationTypeList, fixationTypeFields, fixationTypeLabels, [:], [:])

            def fluidSampleTypeList = FluidSampleType.findAll()
            List fluidSampleTypeFields = ["value"]
            Map fluidSampleTypeLabels = ["value":"fluidSampleType.fluidSampleTypeName"]
            exportService.export(params.format, response.outputStream, fluidSampleTypeList, fluidSampleTypeFields, fluidSampleTypeLabels, [:], [:])

            def frozenByList = FrozenBy.findAll()
            List frozenByFields = ["value"]
            Map frozenByLabels = ["value":"frozenBy.frozenByName"]
            exportService.export(params.format, response.outputStream, frozenByList, frozenByFields, frozenByLabels, [:], [:])

            def imageSubjectList = ImageSubject.findAll()
            List imageSubjectFields = ["value"]
            Map imageSubjectLabels = ["value":"pathologyImageType.pathologyImageTypeName"]
            exportService.export(params.format, response.outputStream, imageSubjectList, imageSubjectFields, imageSubjectLabels, [:], [:])

            def locationList = Location.list()
            List locationFields = ["locationName"]
            Map locationLabels = ["locationName":"collectionLocation.collectionLocationName"]
            exportService.export(params.format, response.outputStream, locationList, locationFields, locationLabels, [:], [:])

            def methodOfTransportList = MethodOfTransport.list()
            List methodOfTransportFields = ["methodOfTransportName"]
            Map methodOfTransportLabels = ["methodOfTransportName":"methodOfTransport.methodOfTransportName"]
            exportService.export(params.format, response.outputStream, methodOfTransportList, methodOfTransportFields, methodOfTransportLabels, [:], [:])

            def primaryContainerTypeList = PrimaryContainerType.findAll()
            List primaryContainerTypeFields = ["value"]
            Map primaryContainerTypeLabels = ["value":"primaryContainerType.primaryContainerTypeName"]
            exportService.export(params.format, response.outputStream, primaryContainerTypeList, primaryContainerTypeFields, primaryContainerTypeLabels, [:], [:])

            def sampleTrackingEventTypeList = SampleTrackingEventType.list()
            List sampleTrackingEventTypeFields = ["sampleTrackingEventTypeName"]
            Map sampleTrackingEventTypeLabels = ["sampleTrackingEventTypeName":"sampleTrackingEventType.sampleTrackingEventTypeName"]
            exportService.export(params.format, response.outputStream, sampleTrackingEventTypeList, sampleTrackingEventTypeFields, sampleTrackingEventTypeLabels, [:], [:])

            def sampleTypeList = SampleType.list()
            List sampleTypeFields = ["sampleTypeName"]
            Map sampleTypeLabels = ["sampleTypeName":"sampleType.sampleTypeName"]
            exportService.export(params.format, response.outputStream, sampleTypeList, sampleTypeFields, sampleTypeLabels, [:], [:])

            def staffMemberList = StaffMember.list()
            List staffMemberFields = ["staffMemberName"]
            Map staffMemberLabels = ["staffMemberName":"staffMember.staffMemberName"]
            exportService.export(params.format, response.outputStream, staffMemberList, staffMemberFields, staffMemberLabels, [:], [:])

            def studyList = Study.list()
            List studyFields = ["studyName"]
            Map studyLabels = ["studyName":"study.studyName"]
            exportService.export(params.format, response.outputStream, studyList, studyFields, studyLabels, [:], [:])

            def tissueProcessorList = TissueProcessor.list()
            List tissueProcessorFields = ["tissueProcessorName"]
            Map tissueProcessorLabels = ["tissueProcessorName":"tissueProcessor.tissueProcessorName"]
            exportService.export(params.format, response.outputStream, tissueProcessorList, tissueProcessorFields, tissueProcessorLabels, [:], [:])

            def tumourContentVerificationList = TumourContentVerification.findAll()
            List tumourContentVerificationFields = ["value"]
            Map tumourContentVerificationLabels = ["value":"tumourContentVerification.tumourContentVerificationName"]
            exportService.export(params.format, response.outputStream, tumourContentVerificationList, tumourContentVerificationFields, tumourContentVerificationLabels, [:], [:])

            def tumourStatusList = TumourStatus.findAll()
            List tumourStatusFields = ["value"]
            Map tumourStatusLabels = ["value":"tumourStatus.tumourStatusName"]
            exportService.export(params.format, response.outputStream, tumourStatusList, tumourStatusFields, tumourStatusLabels, [:], [:])

            def tumourTypeList = TumourType.list()
            List tumourTypeFields = ["tumourType"]
            Map tumourTypeLabels = ["tumourType":"tumourType.tumourTypeName"]
            exportService.export(params.format, response.outputStream, tumourTypeList, tumourTypeFields, tumourTypeLabels, [:], [:])

            def unitTypeList = UnitType.findAll()
            List unitTypeFields = ["value"]
            Map unitTypeLabels = ["value":"tumourStatus.tumourStatusName"]
            exportService.export(params.format, response.outputStream, unitTypeList, unitTypeFields, unitTypeLabels, [:], [:])
        }
    }

    def create() {
        respond new AliquotType(params)
    }

    @Transactional
    def save(AliquotType aliquotTypeInstance) {
        if (aliquotTypeInstance == null) {
            notFound()
            return
        }

        if (aliquotTypeInstance.hasErrors()) {
            respond aliquotTypeInstance.errors, view: 'create'
            return
        }

        aliquotTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'aliquotTypeInstance.label', default: 'AliquotType'), aliquotTypeInstance.id])
                redirect aliquotTypeInstance
            }
            '*' { respond aliquotTypeInstance, [status: CREATED] }
        }
    }

    def edit(AliquotType aliquotTypeInstance) {
        respond aliquotTypeInstance
    }

    @Transactional
    def update(AliquotType aliquotTypeInstance) {
        if (aliquotTypeInstance == null) {
            notFound()
            return
        }

        if (aliquotTypeInstance.hasErrors()) {
            respond aliquotTypeInstance.errors, view: 'edit'
            return
        }

        aliquotTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'AliquotType.label', default: 'AliquotType'), aliquotTypeInstance.id])
                redirect aliquotTypeInstance
            }
            '*' { respond aliquotTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(AliquotType aliquotTypeInstance) {

        if (aliquotTypeInstance == null) {
            notFound()
            return
        }

        aliquotTypeInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'AliquotType.label', default: 'AliquotType'), aliquotTypeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'aliquotTypeInstance.label', default: 'AliquotType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
