package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * AliquotTypeController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class AliquotTypeController {

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
        respond aliquotTypeInstance
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
