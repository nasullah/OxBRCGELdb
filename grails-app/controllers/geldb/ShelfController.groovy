package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * ShelfController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class ShelfController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Shelf.list(params), model: [shelfInstanceCount: Shelf.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Shelf.list(params), model: [shelfInstanceCount: Shelf.count()]
    }

    def show(Shelf shelfInstance) {
        respond shelfInstance
    }

    def create() {
        respond new Shelf(params)
    }

    @Transactional
    def save(Shelf shelfInstance) {
        if (shelfInstance == null) {
            notFound()
            return
        }

        if (shelfInstance.hasErrors()) {
            respond shelfInstance.errors, view: 'create'
            return
        }

        shelfInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'shelfInstance.label', default: 'Shelf'), shelfInstance.id])
                //redirect shelfInstance
                redirect(controller:'freezer',action: 'show', params: [id:shelfInstance.freezer.id])
            }
            '*' { respond shelfInstance, [status: CREATED] }
        }
    }

    def edit(Shelf shelfInstance) {
        respond shelfInstance
    }

    @Transactional
    def update(Shelf shelfInstance) {
        if (shelfInstance == null) {
            notFound()
            return
        }

        if (shelfInstance.hasErrors()) {
            respond shelfInstance.errors, view: 'edit'
            return
        }

        shelfInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Shelf.label', default: 'Shelf'), shelfInstance.id])
                redirect shelfInstance
            }
            '*' { respond shelfInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Shelf shelfInstance) {

        if (shelfInstance == null) {
            notFound()
            return
        }

        shelfInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Shelf.label', default: 'Shelf'), shelfInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'shelfInstance.label', default: 'Shelf'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
