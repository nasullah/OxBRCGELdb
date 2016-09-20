package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * SnomedController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class SnomedController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Snomed.list(params), model: [snomedInstanceCount: Snomed.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Snomed.list(params), model: [snomedInstanceCount: Snomed.count()]
    }

    def show(Snomed snomedInstance) {
        respond snomedInstance
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def create() {
        respond new Snomed(params)
    }

    @Transactional
    def save(Snomed snomedInstance) {
        if (snomedInstance == null) {
            notFound()
            return
        }

        if (snomedInstance.hasErrors()) {
            respond snomedInstance.errors, view: 'create'
            return
        }

        snomedInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'snomedInstance.label', default: 'Snomed'), snomedInstance.id])
                redirect snomedInstance
            }
            '*' { respond snomedInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def edit(Snomed snomedInstance) {
        respond snomedInstance
    }

    @Transactional
    def update(Snomed snomedInstance) {
        if (snomedInstance == null) {
            notFound()
            return
        }

        if (snomedInstance.hasErrors()) {
            respond snomedInstance.errors, view: 'edit'
            return
        }

        snomedInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Snomed.label', default: 'Snomed'), snomedInstance.id])
//                redirect snomedInstance
                redirect(controller:'FFPE_Tissue_Report',action: 'show', params: [id: snomedInstance.fFPE_Tissue_Report.id])
            }
            '*' { respond snomedInstance, [status: OK] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    @Transactional
    def delete(Snomed snomedInstance) {

        if (snomedInstance == null) {
            notFound()
            return
        }

        snomedInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Snomed.label', default: 'Snomed'), snomedInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'snomedInstance.label', default: 'Snomed'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}