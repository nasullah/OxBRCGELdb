package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * ColocationController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class ColocationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Colocation.list(params), model: [colocationInstanceCount: Colocation.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Colocation.list(params), model: [colocationInstanceCount: Colocation.count()]
    }

    def show(Colocation colocationInstance) {
        respond colocationInstance
    }

    def create() {
        respond new Colocation(params)
    }

    @Transactional
    def save(Colocation colocationInstance) {
        if (colocationInstance == null) {
            notFound()
            return
        }

        if (colocationInstance.hasErrors()) {
            respond colocationInstance.errors, view: 'create'
            return
        }

        colocationInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'colocationInstance.label', default: 'Colocation'), colocationInstance.id])
                redirect colocationInstance
                //redirect(controller:'aliquot',action: 'show', params: [id:colocationInstance.aliquot.id])
            }
            '*' { respond colocationInstance, [status: CREATED] }
        }
    }

    def edit(Colocation colocationInstance) {
        respond colocationInstance
    }

    @Transactional
    def update(Colocation colocationInstance) {
        if (colocationInstance == null) {
            notFound()
            return
        }

        if (colocationInstance.hasErrors()) {
            respond colocationInstance.errors, view: 'edit'
            return
        }

        colocationInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Colocation.label', default: 'Colocation'), colocationInstance.id])
                redirect colocationInstance
            }
            '*' { respond colocationInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Colocation colocationInstance) {

        if (colocationInstance == null) {
            notFound()
            return
        }

        colocationInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Colocation.label', default: 'Colocation'), colocationInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'colocationInstance.label', default: 'Colocation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
