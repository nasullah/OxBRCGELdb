package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * LaneController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Transactional(readOnly = true)
class LaneController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Lane.list(params), model: [laneInstanceCount: Lane.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Lane.list(params), model: [laneInstanceCount: Lane.count()]
    }

    def show(Lane laneInstance) {
        respond laneInstance
    }

    def create() {
        respond new Lane(params)
    }

    @Transactional
    def save(Lane laneInstance) {
        if (laneInstance == null) {
            notFound()
            return
        }

        if (laneInstance.hasErrors()) {
            respond laneInstance.errors, view: 'create'
            return
        }

        laneInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'laneInstance.label', default: 'Lane'), laneInstance.id])
                redirect laneInstance
            }
            '*' { respond laneInstance, [status: CREATED] }
        }
    }

    def edit(Lane laneInstance) {
        respond laneInstance
    }

    @Transactional
    def update(Lane laneInstance) {
        if (laneInstance == null) {
            notFound()
            return
        }

        if (laneInstance.hasErrors()) {
            respond laneInstance.errors, view: 'edit'
            return
        }

        laneInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Lane.label', default: 'Lane'), laneInstance.id])
                redirect laneInstance
            }
            '*' { respond laneInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Lane laneInstance) {

        if (laneInstance == null) {
            notFound()
            return
        }

        laneInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Lane.label', default: 'Lane'), laneInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'laneInstance.label', default: 'Lane'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
