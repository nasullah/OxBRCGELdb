package geldb

import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * UnitsController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class UnitsController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Units.list(params), model: [unitsInstanceCount: Units.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Units.list(params), model: [unitsInstanceCount: Units.count()]
    }

    def show(Units unitsInstance) {
        def listUnitsAuditLogData = AuditLogEvent.findAllByPersistedObjectId(unitsInstance?.id)
        respond unitsInstance, model: [listAuditLogData: listUnitsAuditLogData]
    }

    def create() {
        respond new Units(params)
    }

    @Transactional
    def save(Units unitsInstance) {
        if (unitsInstance == null) {
            notFound()
            return
        }

        if (unitsInstance.hasErrors()) {
            respond unitsInstance.errors, view: 'create'
            return
        }

        unitsInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'unitsInstance.label', default: 'Units'), unitsInstance.id])
                redirect unitsInstance
            }
            '*' { respond unitsInstance, [status: CREATED] }
        }
    }

    def edit(Units unitsInstance) {
        respond unitsInstance
    }

    @Transactional
    def update(Units unitsInstance) {
        if (unitsInstance == null) {
            notFound()
            return
        }

        if (unitsInstance.hasErrors()) {
            respond unitsInstance.errors, view: 'edit'
            return
        }

        unitsInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Units.label', default: 'Units'), unitsInstance.id])
                redirect unitsInstance
            }
            '*' { respond unitsInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Units unitsInstance) {

        if (unitsInstance == null) {
            notFound()
            return
        }

        unitsInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Units.label', default: 'Units'), unitsInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'unitsInstance.label', default: 'Units'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
