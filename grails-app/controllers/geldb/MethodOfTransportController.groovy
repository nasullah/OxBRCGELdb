package geldb

import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * MethodOfTransportController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class MethodOfTransportController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond MethodOfTransport.list(params), model: [methodOfTransportInstanceCount: MethodOfTransport.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond MethodOfTransport.list(params), model: [methodOfTransportInstanceCount: MethodOfTransport.count()]
    }

    def show(MethodOfTransport methodOfTransportInstance) {
        def listMethodOfTransportAuditLogData = AuditLogEvent.findAllByPersistedObjectId(methodOfTransportInstance?.id)
        respond methodOfTransportInstance, model: [listAuditLogData: listMethodOfTransportAuditLogData]
    }

    def create() {
        respond new MethodOfTransport(params)
    }

    @Transactional
    def save(MethodOfTransport methodOfTransportInstance) {
        if (methodOfTransportInstance == null) {
            notFound()
            return
        }

        if (methodOfTransportInstance.hasErrors()) {
            respond methodOfTransportInstance.errors, view: 'create'
            return
        }

        methodOfTransportInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'methodOfTransportInstance.label', default: 'MethodOfTransport'), methodOfTransportInstance.id])
                redirect methodOfTransportInstance
            }
            '*' { respond methodOfTransportInstance, [status: CREATED] }
        }
    }

    def edit(MethodOfTransport methodOfTransportInstance) {
        respond methodOfTransportInstance
    }

    @Transactional
    def update(MethodOfTransport methodOfTransportInstance) {
        if (methodOfTransportInstance == null) {
            notFound()
            return
        }

        if (methodOfTransportInstance.hasErrors()) {
            respond methodOfTransportInstance.errors, view: 'edit'
            return
        }

        methodOfTransportInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'MethodOfTransport.label', default: 'MethodOfTransport'), methodOfTransportInstance.id])
                redirect methodOfTransportInstance
            }
            '*' { respond methodOfTransportInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(MethodOfTransport methodOfTransportInstance) {

        if (methodOfTransportInstance == null) {
            notFound()
            return
        }

        methodOfTransportInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'MethodOfTransport.label', default: 'MethodOfTransport'), methodOfTransportInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'methodOfTransportInstance.label', default: 'MethodOfTransport'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
