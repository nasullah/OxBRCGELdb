package geldb

import grails.plugins.springsecurity.Secured
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * TumourLocationController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class TumourLocationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TumourLocation.list(params), model: [tumourLocationInstanceCount: TumourLocation.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TumourLocation.list(params), model: [tumourLocationInstanceCount: TumourLocation.count()]
    }

    def show(TumourLocation tumourLocationInstance) {
        def listTumourLocationAuditLogData = AuditLogEvent.findAllByPersistedObjectId(tumourLocationInstance?.id)
        respond tumourLocationInstance, model: [listAuditLogData: listTumourLocationAuditLogData]
    }

    def create() {
        respond new TumourLocation(params)
    }

    @Transactional
    def save(TumourLocation tumourLocationInstance) {
        if (tumourLocationInstance == null) {
            notFound()
            return
        }

        if (tumourLocationInstance.hasErrors()) {
            respond tumourLocationInstance.errors, view: 'create'
            return
        }

        tumourLocationInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tumourLocationInstance.label', default: 'TumourLocation'), tumourLocationInstance.id])
                redirect tumourLocationInstance
            }
            '*' { respond tumourLocationInstance, [status: CREATED] }
        }
    }

    def edit(TumourLocation tumourLocationInstance) {
        respond tumourLocationInstance
    }

    @Transactional
    def update(TumourLocation tumourLocationInstance) {
        if (tumourLocationInstance == null) {
            notFound()
            return
        }

        if (tumourLocationInstance.hasErrors()) {
            respond tumourLocationInstance.errors, view: 'edit'
            return
        }

        tumourLocationInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TumourLocation.label', default: 'TumourLocation'), tumourLocationInstance.id])
                redirect tumourLocationInstance
            }
            '*' { respond tumourLocationInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(TumourLocation tumourLocationInstance) {

        if (tumourLocationInstance == null) {
            notFound()
            return
        }

        tumourLocationInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TumourLocation.label', default: 'TumourLocation'), tumourLocationInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tumourLocationInstance.label', default: 'TumourLocation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
