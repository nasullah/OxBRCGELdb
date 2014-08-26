package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * PlateOrBoxController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Transactional(readOnly = true)
class PlateOrBoxController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PlateOrBox.list(params), model: [plateOrBoxInstanceCount: PlateOrBox.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PlateOrBox.list(params), model: [plateOrBoxInstanceCount: PlateOrBox.count()]
    }

    def show(PlateOrBox plateOrBoxInstance) {
        respond plateOrBoxInstance
    }

    def create() {
        respond new PlateOrBox(params)
    }

    @Transactional
    def save(PlateOrBox plateOrBoxInstance) {
        if (plateOrBoxInstance == null) {
            notFound()
            return
        }

        if (plateOrBoxInstance.hasErrors()) {
            respond plateOrBoxInstance.errors, view: 'create'
            return
        }

        plateOrBoxInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'plateOrBoxInstance.label', default: 'PlateOrBox'), plateOrBoxInstance.id])
                redirect plateOrBoxInstance
            }
            '*' { respond plateOrBoxInstance, [status: CREATED] }
        }
    }

    def edit(PlateOrBox plateOrBoxInstance) {
        respond plateOrBoxInstance
    }

    @Transactional
    def update(PlateOrBox plateOrBoxInstance) {
        if (plateOrBoxInstance == null) {
            notFound()
            return
        }

        if (plateOrBoxInstance.hasErrors()) {
            respond plateOrBoxInstance.errors, view: 'edit'
            return
        }

        plateOrBoxInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PlateOrBox.label', default: 'PlateOrBox'), plateOrBoxInstance.id])
                redirect plateOrBoxInstance
            }
            '*' { respond plateOrBoxInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PlateOrBox plateOrBoxInstance) {

        if (plateOrBoxInstance == null) {
            notFound()
            return
        }

        plateOrBoxInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PlateOrBox.label', default: 'PlateOrBox'), plateOrBoxInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'plateOrBoxInstance.label', default: 'PlateOrBox'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
