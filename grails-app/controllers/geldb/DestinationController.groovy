package geldb

import grails.converters.JSON
import grails.plugins.springsecurity.Secured
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * DestinationController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class DestinationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Destination.list(params), model: [destinationInstanceCount: Destination.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Destination.list(params), model: [destinationInstanceCount: Destination.count()]
    }

    def show(Destination destinationInstance) {
        def listDestinationAuditLogData = AuditLogEvent.findAllByPersistedObjectId(destinationInstance?.id)
        respond destinationInstance, model: [listAuditLogData: listDestinationAuditLogData]
    }

    def create() {
        respond new Destination(params)
    }

    @Transactional
    def save(Destination destinationInstance) {
        if (destinationInstance == null) {
            notFound()
            return
        }

        if (destinationInstance.hasErrors()) {
            respond destinationInstance.errors, view: 'create'
            return
        }

        destinationInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'destinationInstance.label', default: 'Destination'), destinationInstance.id])
                redirect destinationInstance
            }
            '*' { respond destinationInstance, [status: CREATED] }
        }
    }

    def edit(Destination destinationInstance) {
        respond destinationInstance
    }

    @Transactional
    def update(Destination destinationInstance) {
        if (destinationInstance == null) {
            notFound()
            return
        }

        if (destinationInstance.hasErrors()) {
            respond destinationInstance.errors, view: 'edit'
            return
        }

        destinationInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Destination.label', default: 'Destination'), destinationInstance.id])
                redirect destinationInstance
            }
            '*' { respond destinationInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Destination destinationInstance) {

        if (destinationInstance == null) {
            notFound()
            return
        }

        destinationInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Destination.label', default: 'Destination'), destinationInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'destinationInstance.label', default: 'Destination'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
