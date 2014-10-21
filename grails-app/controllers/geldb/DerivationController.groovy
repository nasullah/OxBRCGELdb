package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * DerivationController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class DerivationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Derivation.list(params), model: [derivationInstanceCount: Derivation.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Derivation.list(params), model: [derivationInstanceCount: Derivation.count()]
    }

    def show(Derivation derivationInstance) {
        respond derivationInstance
    }

    def create() {
        respond new Derivation(params)
    }

    @Transactional
    def save(Derivation derivationInstance) {
        if (derivationInstance == null) {
            notFound()
            return
        }

        if (derivationInstance.hasErrors()) {
            respond derivationInstance.errors, view: 'create'
            return
        }

        derivationInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'derivationInstance.label', default: 'Derivation'), derivationInstance.id])
                redirect derivationInstance
            }
            '*' { respond derivationInstance, [status: CREATED] }
        }
    }

    def edit(Derivation derivationInstance) {
        respond derivationInstance
    }

    @Transactional
    def update(Derivation derivationInstance) {
        if (derivationInstance == null) {
            notFound()
            return
        }

        if (derivationInstance.hasErrors()) {
            respond derivationInstance.errors, view: 'edit'
            return
        }

        derivationInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Derivation.label', default: 'Derivation'), derivationInstance.id])
                redirect derivationInstance
            }
            '*' { respond derivationInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Derivation derivationInstance) {

        if (derivationInstance == null) {
            notFound()
            return
        }

        derivationInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Derivation.label', default: 'Derivation'), derivationInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'derivationInstance.label', default: 'Derivation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
