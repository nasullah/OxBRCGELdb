package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * FreezerController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Transactional(readOnly = true)
class FreezerController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Freezer.list(params), model: [freezerInstanceCount: Freezer.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Freezer.list(params), model: [freezerInstanceCount: Freezer.count()]
    }

    def show(Freezer freezerInstance) {
        respond freezerInstance
    }

    def create() {
        respond new Freezer(params)
    }

    @Transactional
    def save(Freezer freezerInstance) {
        if (freezerInstance == null) {
            notFound()
            return
        }

        if (freezerInstance.hasErrors()) {
            respond freezerInstance.errors, view: 'create'
            return
        }

        freezerInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'freezerInstance.label', default: 'Freezer'), freezerInstance.id])
                redirect freezerInstance
            }
            '*' { respond freezerInstance, [status: CREATED] }
        }
    }

    def edit(Freezer freezerInstance) {
        respond freezerInstance
    }

    @Transactional
    def update(Freezer freezerInstance) {
        if (freezerInstance == null) {
            notFound()
            return
        }

        if (freezerInstance.hasErrors()) {
            respond freezerInstance.errors, view: 'edit'
            return
        }

        freezerInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Freezer.label', default: 'Freezer'), freezerInstance.id])
                redirect freezerInstance
            }
            '*' { respond freezerInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Freezer freezerInstance) {

        if (freezerInstance == null) {
            notFound()
            return
        }

        freezerInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Freezer.label', default: 'Freezer'), freezerInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'freezerInstance.label', default: 'Freezer'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
