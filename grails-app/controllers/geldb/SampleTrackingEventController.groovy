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

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [sampleTrackingEventnstanceList: SampleTrackingEvent.list(params), sampleTrackingEventnstanceTotal: Aliquot.count()]
//    }
//    def filterPaneService
//
//    def filter = {
//        if(!params.max) params.max = 10
//        render( view:'list', model:[ aliquotInstanceList: filterPaneService.filter( params, Aliquot ),
//                                     aliquotInstanceTotal: filterPaneService.count( params, Aliquot ),
//                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
//    }

    def show(SampleTrackingEvent sampleTrackingEventInstance) {
        respond sampleTrackingEventInstance
    }

    def create() {
        respond new SampleTrackingEvent(params)
    }

    def createReceived() {
        respond new SampleTrackingEvent(params)
        render(view: "createReceived")
    }

    def findSpecimenToDispatchByGeLId() {
        def gelId= params.search
        def participantId = null
        if (gelId) {
            def participantByGeLId = Participant.createCriteria().get {
                studySubject {
                    eq('studySubjectIdentifier', gelId)
                }
            }
            if(participantByGeLId){
                participantId = participantByGeLId.id
            }
        }
        if (gelId && participantId) {
            def listSpecimenByGeLId = Specimen.where {
                participant.id == participantId
            }.findAllByExhausted(false)
            listSpecimenByGeLId = listSpecimenByGeLId.findAll {s -> s.sampleTrackingEvent.sampleTrackingEventType.sampleTrackingEventTypeName != 'Despatched to Oxford' }
            if(listSpecimenByGeLId){
                render(template: "specimenList",  model: [listSpecimenByGeLId: listSpecimenByGeLId])
            }
        }

    }

    def findReceivedSpecimenByGeLId() {
        def gelId= params.search
        def participantId = null
        if (gelId) {
            def participantByGeLId = Participant.createCriteria().get {
                studySubject {
                    eq('studySubjectIdentifier', gelId)
                }
            }
            if(participantByGeLId){
                participantId = participantByGeLId.id
            }
        }
        if (gelId && participantId) {
            def listSpecimenByGeLId = Specimen.where {
                participant.id == participantId
            }.findAllByExhausted(false)
            listSpecimenByGeLId = listSpecimenByGeLId.findAll {s -> s.sampleTrackingEvent.sampleTrackingEventType.sampleTrackingEventTypeName != 'Received at Oxford' }
            if(listSpecimenByGeLId){
                render(template: "specimenList",  model: [listSpecimenByGeLId: listSpecimenByGeLId])
            }
        }
    }

    def fluidSpecimenInTransit() {

        def dispatchList = FluidSpecimen.where {
            sampleTrackingEvent.sampleTrackingEventType.sampleTrackingEventTypeName == 'Despatched to Oxford'
        }.findAll()

        def receivedList = FluidSpecimen.where {
            sampleTrackingEvent.sampleTrackingEventType.sampleTrackingEventTypeName == 'Received at Oxford'
        }.findAll()

        if(receivedList){
            def results= dispatchList.intersect(receivedList)
            if (results){
                def remainingList = dispatchList.removeAll(results)
                if (remainingList){
                    render(view: "fluidSpecimenInTransit",  model: [fluidSpecimenInTransit: dispatchList])
                }
            }
        } else {
            render(view: "fluidSpecimenInTransit",  model: [fluidSpecimenInTransit: dispatchList])
        }
    }

    def solidSpecimenInTransit() {

        List <SolidSpecimen> dispatchList = SolidSpecimen.where {
            sampleTrackingEvent.sampleTrackingEventType.sampleTrackingEventTypeName == 'Despatched to Oxford'
        }.findAll()

        List <SolidSpecimen> receivedList = SolidSpecimen.where {
            sampleTrackingEvent.sampleTrackingEventType.sampleTrackingEventTypeName == 'Received at Oxford'
        }.findAll()

        if(receivedList){
            def results= dispatchList.intersect(receivedList)
            if (results){
                def remainingList = dispatchList.removeAll(results)
                if (remainingList) {
                    render(view: "solidSpecimenInTransit", model: [solidSpecimenInTransit: dispatchList])
                }
            }
        } else {
            render(view: "solidSpecimenInTransit",  model: [solidSpecimenInTransit: dispatchList])
        }
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

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sampleTrackingEventInstance.label', default: 'SampleTrackingEvent'), sampleTrackingEventInstance.id])
                redirect(controller:'aliquot',action: 'show', params: [id: sampleTrackingEventInstance.identifiedSample.id])
            }
            '*' { respond sampleTrackingEventInstance, [status: CREATED] }
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

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SampleTrackingEvent.label', default: 'SampleTrackingEvent'), sampleTrackingEventInstance.id])
                redirect(controller:'aliquot',action: 'show', params: [id: sampleTrackingEventInstance.identifiedSample.id])
            }
            '*' { respond sampleTrackingEventInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SampleTrackingEvent sampleTrackingEventInstance) {

        if (sampleTrackingEventInstance == null) {
            notFound()
            return
        }

        sampleTrackingEventInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SampleTrackingEvent.label', default: 'SampleTrackingEvent'), sampleTrackingEventInstance.id])
                redirect(controller:'aliquot',action: 'show', params: [id: sampleTrackingEventInstance.identifiedSample.id])
            }
            '*' { render status: NO_CONTENT }
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
