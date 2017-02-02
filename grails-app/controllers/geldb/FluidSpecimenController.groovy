package geldb

import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
/**
 * FluidSpecimenController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class FluidSpecimenController {

    def exportService
    def exportFluidSpecimenService
    def filterPaneService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond FluidSpecimen.findAllByExhausted(false, params), model: [fluidSpecimenInstanceCount: FluidSpecimen.findAllByExhausted(false).size()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [fluidSpecimenInstanceList: FluidSpecimen.findAllByExhausted(false, params), fluidSpecimenInstanceTotal: FluidSpecimen.findAllByExhausted(false).size()]
    }

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ fluidSpecimenInstanceList: filterPaneService.filter( params, FluidSpecimen ),
                                     fluidSpecimenInstanceTotal: filterPaneService.count( params, FluidSpecimen ),
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

    def listBloodFollowUp() {
        def results = Participant.createCriteria().listDistinct{
            specimen {
                and {
                    ge("fluidSpecimenVolume", Float.parseFloat("10"))
                    aliquot {
                        eq('aliquotType',AliquotType.findByAliquotTypeName('Plasma'))
                    }
                }
            }
        }
        [participantList: results.sort {it.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    def awaitingBlood(){
        def results = Participant.list()
        results = results.findAll {participantInstance -> !FluidSpecimen.findByParticipant(participantInstance)}
        [participantList: results.sort {it.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def createMultiple(){
        List primaryContainerTypes = ["EDTA_GL", "EDTA_cfDNA", "Strek_cfDNA", "Strek_cfDNA", "Strek_cfDNA", "Oragene_kit_SALIVA_GL", "Vacutainer_potassium_EDTA_or_equivalent_PED"]
        respond new FluidSpecimen(params), model: [primaryContainerTypes: primaryContainerTypes]
    }

    @Transactional
    def saveMultiple() {
        def counter = 0
        for (int i = 0; i < PrimaryContainerType?.values()?.size(); i++){
            if (params.find{it.key.equals('primaryContainer_'+ i)}?.value && params.find{it.key.equals('fluidSpecimenVolume_'+ i)}?.value
                    && params.participant && params.collectionDate && params.collectedBy && params.collectionLocation && params.volumeUnit
                    && params.fluidSampleType){
                def fluidSpecimenVolume = params.find{it.key.equals('fluidSpecimenVolume_'+ i)}?.value
                def primaryContainer = params.find{it.key.equals('primaryContainer_'+ i)}?.value?.toString()
                def barcode = params.find{it.key.equals('barcode_'+ i)}?.value
                new FluidSpecimen(participant: params.participant, collectionDate: params.collectionDate, collectionTime: params.collectionTime,
                        collectionLocation: params.collectionLocation, collectedBy: params.collectedBy, primaryContainer: primaryContainer,
                        fluidSampleType: params.fluidSampleType, fluidSpecimenVolume: fluidSpecimenVolume , volumeUnit: params.volumeUnit,
                        barcode: barcode, timePoint: params.timePoint).save flush: true
                counter ++
            }
        }
        if (counter != 0){
            flash.message = "${counter} fluid specimen are created"
            redirect action: "index", method: "GET"
        } else {
            flash.message = "Fluid specimen could not be created"
            redirect action: "index", method: "GET"
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportFluidSpecimens(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported All FluidSpecimens.${params.extension}")
            def exportFluidSpecimensData = FluidSpecimen.list().sort {it.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
            exportService.export(params.format, response.outputStream, exportFluidSpecimensData, exportFluidSpecimenService.fields, exportFluidSpecimenService.labels, exportFluidSpecimenService.formatters, exportFluidSpecimenService.parameters)
        }
    }

    def show(FluidSpecimen fluidSpecimenInstance) {
        def listFluidSpecimenAuditLogData = AuditLogEvent.findAllByPersistedObjectId(fluidSpecimenInstance?.id)
        respond fluidSpecimenInstance, model: [listAuditLogData: listFluidSpecimenAuditLogData]
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def create() {
        respond new FluidSpecimen(params)
    }

    def fluidSpecimenSummary(){
        def summary = Participant.createCriteria().list {
            studySubject {
                eq("study", Study?.findByStudyName("100K Genomes Main Project"))
            }
        }
        summary = summary.sort {it.id}
        [summary: summary.reverse()]
    }

    @Transactional
    def save(FluidSpecimen fluidSpecimenInstance) {
        if (fluidSpecimenInstance == null) {
            notFound()
            return
        }

        if (fluidSpecimenInstance.hasErrors()) {
            respond fluidSpecimenInstance.errors, view: 'create'
            return
        }

        fluidSpecimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'fluidSpecimenInstance.label', default: 'FluidSpecimen'), fluidSpecimenInstance.id])
                redirect fluidSpecimenInstance
            }
            '*' { respond fluidSpecimenInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def edit(FluidSpecimen fluidSpecimenInstance) {
        respond fluidSpecimenInstance
    }

    @Transactional
    def update(FluidSpecimen fluidSpecimenInstance) {
        if (fluidSpecimenInstance == null) {
            notFound()
            return
        }

        if (fluidSpecimenInstance.hasErrors()) {
            respond fluidSpecimenInstance.errors, view: 'edit'
            return
        }

        fluidSpecimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FluidSpecimen.label', default: 'FluidSpecimen'), fluidSpecimenInstance.id])
                redirect fluidSpecimenInstance
            }
            '*' { respond fluidSpecimenInstance, [status: OK] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    @Transactional
    def delete(FluidSpecimen fluidSpecimenInstance) {

        if (fluidSpecimenInstance == null) {
            notFound()
            return
        }

        fluidSpecimenInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FluidSpecimen.label', default: 'FluidSpecimen'), fluidSpecimenInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'fluidSpecimenInstance.label', default: 'FluidSpecimen'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
