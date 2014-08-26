package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * CentrifugationController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Transactional(readOnly = true)
class CentrifugationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Centrifugation.list(params), model: [centrifugationInstanceCount: Centrifugation.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Centrifugation.list(params), model: [centrifugationInstanceCount: Centrifugation.count()]
    }

    def show(Centrifugation centrifugationInstance) {
        respond centrifugationInstance
    }

    def create() {
        respond new Centrifugation(params)
    }

    @Transactional
    def save(Centrifugation centrifugationInstance) {
        if (centrifugationInstance == null) {
            notFound()
            return
        }

        if (centrifugationInstance.hasErrors()) {
            respond centrifugationInstance.errors, view: 'create'
            return
        }

        centrifugationInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'centrifugationInstance.label', default: 'Centrifugation'), centrifugationInstance.id])
                redirect centrifugationInstance
            }
            '*' { respond centrifugationInstance, [status: CREATED] }
        }
    }

    def edit(Centrifugation centrifugationInstance) {
        respond centrifugationInstance
    }

    @Transactional
    def update(Centrifugation centrifugationInstance) {
        if (centrifugationInstance == null) {
            notFound()
            return
        }

        if (centrifugationInstance.hasErrors()) {
            respond centrifugationInstance.errors, view: 'edit'
            return
        }

        centrifugationInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Centrifugation.label', default: 'Centrifugation'), centrifugationInstance.id])
                redirect centrifugationInstance
            }
            '*' { respond centrifugationInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Centrifugation centrifugationInstance) {

        if (centrifugationInstance == null) {
            notFound()
            return
        }

        centrifugationInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Centrifugation.label', default: 'Centrifugation'), centrifugationInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'centrifugationInstance.label', default: 'Centrifugation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
