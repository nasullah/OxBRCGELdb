package geldb

import grails.plugins.springsecurity.Secured
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * DNAExtractionKitController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class DNAExtractionKitController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DNAExtractionKit.list(params), model: [DNAExtractionKitInstanceCount: DNAExtractionKit.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DNAExtractionKit.list(params), model: [DNAExtractionKitInstanceCount: DNAExtractionKit.count()]
    }

    def show(DNAExtractionKit DNAExtractionKitInstance) {
        def listDNAExtractionKitAuditLogData = AuditLogEvent.findAllByPersistedObjectId(DNAExtractionKitInstance?.id)
        respond DNAExtractionKitInstance, model: [listAuditLogData: listDNAExtractionKitAuditLogData]
    }

    def create() {
        respond new DNAExtractionKit(params)
    }

    @Transactional
    def save(DNAExtractionKit DNAExtractionKitInstance) {
        if (DNAExtractionKitInstance == null) {
            notFound()
            return
        }

        if (DNAExtractionKitInstance.hasErrors()) {
            respond DNAExtractionKitInstance.errors, view: 'create'
            return
        }

        DNAExtractionKitInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'DNAExtractionKitInstance.label', default: 'DNAExtractionKit'), DNAExtractionKitInstance.id])
                redirect DNAExtractionKitInstance
            }
            '*' { respond DNAExtractionKitInstance, [status: CREATED] }
        }
    }

    def edit(DNAExtractionKit DNAExtractionKitInstance) {
        respond DNAExtractionKitInstance
    }

    @Transactional
    def update(DNAExtractionKit DNAExtractionKitInstance) {
        if (DNAExtractionKitInstance == null) {
            notFound()
            return
        }

        if (DNAExtractionKitInstance.hasErrors()) {
            respond DNAExtractionKitInstance.errors, view: 'edit'
            return
        }

        DNAExtractionKitInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DNAExtractionKit.label', default: 'DNAExtractionKit'), DNAExtractionKitInstance.id])
                redirect DNAExtractionKitInstance
            }
            '*' { respond DNAExtractionKitInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(DNAExtractionKit DNAExtractionKitInstance) {

        if (DNAExtractionKitInstance == null) {
            notFound()
            return
        }

        DNAExtractionKitInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DNAExtractionKit.label', default: 'DNAExtractionKit'), DNAExtractionKitInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'DNAExtractionKitInstance.label', default: 'DNAExtractionKit'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
