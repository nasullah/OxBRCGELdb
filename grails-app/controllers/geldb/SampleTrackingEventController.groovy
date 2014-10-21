package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * SampleTrackingEventController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN'])
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

    def getIDByScanner(){
         Specimen.findBySapphireIdentifier("%${params.barcode}%").id
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
                redirect sampleTrackingEventInstance
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
                redirect sampleTrackingEventInstance
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
                redirect action: "index", method: "GET"
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
