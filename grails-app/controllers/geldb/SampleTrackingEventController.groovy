package geldb

import org.grails.plugin.filterpane.FilterPaneUtils

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * SampleTrackingEventController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class SampleTrackingEventController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SampleTrackingEvent.list(params), model: [sampleTrackingEventInstanceCount: SampleTrackingEvent.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SampleTrackingEvent.list(params), model: [sampleTrackingEventInstanceCount: SampleTrackingEvent.count()]
    }

    def show(SampleTrackingEvent sampleTrackingEventInstance) {
        respond sampleTrackingEventInstance
    }

    def create() {
        respond new SampleTrackingEvent(params)
    }

    def awaitingFluidSpecimenToBeDispatched() {
        def waitingFluidSpecimenDispatchList = FluidSpecimen.where{
            participant == Participant.findByCentre(Centre.findByCentreName('Bristol'))
        }.list()
        waitingFluidSpecimenDispatchList = waitingFluidSpecimenDispatchList.findAll {s -> s.sampleTrackingEvent.empty}
        [waitingFluidSpecimenDispatchList:waitingFluidSpecimenDispatchList]
    }

    def fluidSpecimenInTransit() {
        def fluidSpecimenList = FluidSpecimen.where{
            participant == Participant.findByCentre(Centre.findByCentreName('Bristol'))
        }.list()
        fluidSpecimenList = fluidSpecimenList.findAll {fluidSpecimen -> !fluidSpecimen.sampleTrackingEvent.empty}
        fluidSpecimenList = fluidSpecimenList.findAll {fluidSpecimen -> SampleTrackingEvent.findBySampleTrackingEventTypeAndIdentifiedSample(SampleTrackingEventType.findBySampleTrackingEventTypeName('Despatched to Oxford'), fluidSpecimen)}
        fluidSpecimenList = fluidSpecimenList.findAll {fluidSpecimen -> !SampleTrackingEvent.findBySampleTrackingEventTypeAndIdentifiedSample(SampleTrackingEventType.findBySampleTrackingEventTypeName('Received at Oxford'), fluidSpecimen)}
        [fluidSpecimenList:fluidSpecimenList]
    }

    def awaitingToBeDispatchedToMDC(){
        def ffAliquots = Aliquot.findAllByAliquotType(AliquotType.findByAliquotTypeName('Punch Biopsy Frozen'))
        def ffpeAliquots = Aliquot.findAllByAliquotTypeOrAliquotType(AliquotType.findByAliquotTypeName('Punch Biopsy FFPE, NBF'), AliquotType.findByAliquotTypeName('Punch Biopsy FFPE'))
        def ffAliquotSpecimen = ffAliquots.specimen.unique()
        ffpeAliquots = ffpeAliquots.findAll {aliquot -> !ffAliquotSpecimen.find {it == aliquot.specimen}}
        ffAliquots.addAll(ffpeAliquots)
        ffAliquots = ffAliquots.findAll {aliquot -> aliquot.sampleTrackingEvent.empty}
        ffAliquots = ffAliquots.findAll {aliquot ->
            if (aliquot.createdOn){
                aliquot.createdOn > new Date().parse('yyyy-MM-dd', '2016-05-01')
            }else if(aliquot?.derivedFrom){
                aliquot?.derivedFrom?.aliquot?.createdOn > new Date().parse('yyyy-MM-dd', '2016-05-01')
            }
        }
        [aliquotInstanceList: ffAliquots.sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    def inTransitToMDC(){
        def aliquotInstanceList = Aliquot.findAllByAliquotTypeOrAliquotTypeOrAliquotTypeOrAliquotTypeOrAliquotType(AliquotType.findByAliquotTypeName('Punch Biopsy FFPE, NBF'), AliquotType.findByAliquotTypeName('Punch Biopsy FFPE'),
                AliquotType.findByAliquotTypeName('Punch biopsy, PAXgene'), AliquotType.findByAliquotTypeName('Section'), AliquotType.findByAliquotTypeName('Punch Biopsy Frozen'))
        aliquotInstanceList = aliquotInstanceList.findAll {aliquot -> !aliquot.sampleTrackingEvent.empty}
        aliquotInstanceList = aliquotInstanceList.findAll {aliquot -> SampleTrackingEvent.findBySampleTrackingEventTypeAndIdentifiedSample(SampleTrackingEventType.findBySampleTrackingEventTypeName('Dispatch to MDC lab'), aliquot)}
        aliquotInstanceList = aliquotInstanceList.findAll {aliquot -> !SampleTrackingEvent.findBySampleTrackingEventTypeAndIdentifiedSample(SampleTrackingEventType.findBySampleTrackingEventTypeName('Received at MDC lab'), aliquot) }
        [aliquotInstanceList: aliquotInstanceList.sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    @Transactional
    def save(SampleTrackingEvent sampleTrackingEventInstance) {
        if (sampleTrackingEventInstance == null) {
            notFound()
            return
        }

        if (sampleTrackingEventInstance.hasErrors()) {
            respond sampleTrackingEventInstance.errors, view: 'create'
            return
        }

        sampleTrackingEventInstance.save flush: true

        def identifiedSample = sampleTrackingEventInstance.identifiedSample
        flash.message = "Sample Tracking Event ${sampleTrackingEventInstance.id} is created"
        if (identifiedSample.instanceOf(FluidSpecimen)){
            redirect(controller:'fluidSpecimen',action: 'show', params: [id: sampleTrackingEventInstance.identifiedSample.id])
        }else if (identifiedSample.instanceOf(SolidSpecimen)){
            redirect(controller:'solidSpecimen',action: 'show', params: [id: sampleTrackingEventInstance.identifiedSample.id])
        }else if (identifiedSample.instanceOf(Aliquot)){
            redirect(controller:'aliquot',action: 'show', params: [id: sampleTrackingEventInstance.identifiedSample.id])
        }
    }

    def edit(SampleTrackingEvent sampleTrackingEventInstance) {
        respond sampleTrackingEventInstance
    }

    @Transactional
    def update(SampleTrackingEvent sampleTrackingEventInstance) {
        if (sampleTrackingEventInstance == null) {
            notFound()
            return
        }

        if (sampleTrackingEventInstance.hasErrors()) {
            respond sampleTrackingEventInstance.errors, view: 'edit'
            return
        }

        sampleTrackingEventInstance.save flush: true

        def identifiedSample = sampleTrackingEventInstance.identifiedSample
        flash.message = "Sample Tracking Event ${sampleTrackingEventInstance.id} is created"
        if (identifiedSample.instanceOf(FluidSpecimen)){
            redirect(controller:'fluidSpecimen',action: 'show', params: [id: sampleTrackingEventInstance.identifiedSample.id])
        }else if (identifiedSample.instanceOf(SolidSpecimen)){
            redirect(controller:'solidSpecimen',action: 'show', params: [id: sampleTrackingEventInstance.identifiedSample.id])
        }else if (identifiedSample.instanceOf(Aliquot)){
            redirect(controller:'aliquot',action: 'show', params: [id: sampleTrackingEventInstance.identifiedSample.id])
        }
    }

    @Transactional
    def delete(SampleTrackingEvent sampleTrackingEventInstance) {

        if (sampleTrackingEventInstance == null) {
            notFound()
            return
        }

        sampleTrackingEventInstance.delete flush: true

        def identifiedSample = sampleTrackingEventInstance.identifiedSample
        flash.message = "Sample Tracking Event ${sampleTrackingEventInstance.id} is created"
        if (identifiedSample.instanceOf(FluidSpecimen)){
            redirect(controller:'fluidSpecimen',action: 'show', params: [id: sampleTrackingEventInstance.identifiedSample.id])
        }else if (identifiedSample.instanceOf(SolidSpecimen)){
            redirect(controller:'solidSpecimen',action: 'show', params: [id: sampleTrackingEventInstance.identifiedSample.id])
        }else if (identifiedSample.instanceOf(Aliquot)){
            redirect(controller:'aliquot',action: 'show', params: [id: sampleTrackingEventInstance.identifiedSample.id])
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sampleTrackingEventInstance.label', default: 'SampleTrackingEvent'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
