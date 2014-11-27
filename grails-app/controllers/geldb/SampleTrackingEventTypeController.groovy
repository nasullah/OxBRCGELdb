package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * SampleTrackingEventTypeController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class SampleTrackingEventTypeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SampleTrackingEventType.list(params), model: [sampleTrackingEventTypeInstanceCount: SampleTrackingEventType.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SampleTrackingEventType.list(params), model: [sampleTrackingEventTypeInstanceCount: SampleTrackingEventType.count()]
    }

    def show(SampleTrackingEventType sampleTrackingEventTypeInstance) {
        respond sampleTrackingEventTypeInstance
    }

    def create() {
        respond new SampleTrackingEventType(params)
    }

    @Transactional
    def save(SampleTrackingEventType sampleTrackingEventTypeInstance) {
        if (sampleTrackingEventTypeInstance == null) {
            notFound()
            return
        }

        if (sampleTrackingEventTypeInstance.hasErrors()) {
            respond sampleTrackingEventTypeInstance.errors, view: 'create'
            return
        }

        sampleTrackingEventTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sampleTrackingEventTypeInstance.label', default: 'SampleTrackingEventType'), sampleTrackingEventTypeInstance.id])
                redirect sampleTrackingEventTypeInstance
            }
            '*' { respond sampleTrackingEventTypeInstance, [status: CREATED] }
        }
    }

    def edit(SampleTrackingEventType sampleTrackingEventTypeInstance) {
        respond sampleTrackingEventTypeInstance
    }

    @Transactional
    def update(SampleTrackingEventType sampleTrackingEventTypeInstance) {
        if (sampleTrackingEventTypeInstance == null) {
            notFound()
            return
        }

        if (sampleTrackingEventTypeInstance.hasErrors()) {
            respond sampleTrackingEventTypeInstance.errors, view: 'edit'
            return
        }

        sampleTrackingEventTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SampleTrackingEventType.label', default: 'SampleTrackingEventType'), sampleTrackingEventTypeInstance.id])
                redirect sampleTrackingEventTypeInstance
            }
            '*' { respond sampleTrackingEventTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SampleTrackingEventType sampleTrackingEventTypeInstance) {

        if (sampleTrackingEventTypeInstance == null) {
            notFound()
            return
        }

        sampleTrackingEventTypeInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SampleTrackingEventType.label', default: 'SampleTrackingEventType'), sampleTrackingEventTypeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sampleTrackingEventTypeInstance.label', default: 'SampleTrackingEventType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
