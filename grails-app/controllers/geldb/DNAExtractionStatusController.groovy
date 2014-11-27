package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * DNAExtractionStatusController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class DNAExtractionStatusController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DNAExtractionStatus.list(params), model: [DNAExtractionStatusInstanceCount: DNAExtractionStatus.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DNAExtractionStatus.list(params), model: [DNAExtractionStatusInstanceCount: DNAExtractionStatus.count()]
    }

    def show(DNAExtractionStatus DNAExtractionStatusInstance) {
        respond DNAExtractionStatusInstance
    }

    def create() {
        respond new DNAExtractionStatus(params)
    }

    @Transactional
    def save(DNAExtractionStatus DNAExtractionStatusInstance) {
        if (DNAExtractionStatusInstance == null) {
            notFound()
            return
        }

        if (DNAExtractionStatusInstance.hasErrors()) {
            respond DNAExtractionStatusInstance.errors, view: 'create'
            return
        }

        DNAExtractionStatusInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'DNAExtractionStatusInstance.label', default: 'DNAExtractionStatus'), DNAExtractionStatusInstance.id])
                redirect DNAExtractionStatusInstance
            }
            '*' { respond DNAExtractionStatusInstance, [status: CREATED] }
        }
    }

    def edit(DNAExtractionStatus DNAExtractionStatusInstance) {
        respond DNAExtractionStatusInstance
    }

    @Transactional
    def update(DNAExtractionStatus DNAExtractionStatusInstance) {
        if (DNAExtractionStatusInstance == null) {
            notFound()
            return
        }

        if (DNAExtractionStatusInstance.hasErrors()) {
            respond DNAExtractionStatusInstance.errors, view: 'edit'
            return
        }

        DNAExtractionStatusInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DNAExtractionStatus.label', default: 'DNAExtractionStatus'), DNAExtractionStatusInstance.id])
                redirect DNAExtractionStatusInstance
            }
            '*' { respond DNAExtractionStatusInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(DNAExtractionStatus DNAExtractionStatusInstance) {

        if (DNAExtractionStatusInstance == null) {
            notFound()
            return
        }

        DNAExtractionStatusInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DNAExtractionStatus.label', default: 'DNAExtractionStatus'), DNAExtractionStatusInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'DNAExtractionStatusInstance.label', default: 'DNAExtractionStatus'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
