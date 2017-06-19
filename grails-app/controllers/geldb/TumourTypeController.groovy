package geldb

import grails.plugins.springsecurity.Secured
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent
import org.grails.plugin.filterpane.FilterPaneUtils

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * TumourTypeController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class TumourTypeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TumourType.list(params), model: [tumourTypeInstanceCount: TumourType.count()]
    }

//    def list(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond TumourType.list(params), model: [tumourTypeInstanceCount: TumourType.count()]
//    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tumourTypeInstanceList: TumourType.list(params), tumourTypeInstanceTotal: TumourType.count()]
    }

    def filterPaneService
    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ tumourTypeInstanceList: filterPaneService.filter( params, TumourType ),
                                     tumourTypeInstanceTotal: filterPaneService.count( params, TumourType ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def show(TumourType tumourTypeInstance) {
        def listTumourTypeAuditLogData = AuditLogEvent.findAllByPersistedObjectId(tumourTypeInstance?.id)
        respond tumourTypeInstance, model: [listAuditLogData: listTumourTypeAuditLogData]
    }

    def create() {
        respond new TumourType(params)
    }

    @Transactional
    def save(TumourType tumourTypeInstance) {
        if (tumourTypeInstance == null) {
            notFound()
            return
        }

        if (tumourTypeInstance.hasErrors()) {
            respond tumourTypeInstance.errors, view: 'create'
            return
        }

        tumourTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tumourTypeInstance.label', default: 'TumourType'), tumourTypeInstance.id])
                redirect tumourTypeInstance
            }
            '*' { respond tumourTypeInstance, [status: CREATED] }
        }
    }

    def edit(TumourType tumourTypeInstance) {
        respond tumourTypeInstance
    }

    @Transactional
    def update(TumourType tumourTypeInstance) {
        if (tumourTypeInstance == null) {
            notFound()
            return
        }

        if (tumourTypeInstance.hasErrors()) {
            respond tumourTypeInstance.errors, view: 'edit'
            return
        }

        tumourTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TumourType.label', default: 'TumourType'), tumourTypeInstance.id])
                redirect tumourTypeInstance
            }
            '*' { respond tumourTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(TumourType tumourTypeInstance) {

        if (tumourTypeInstance == null) {
            notFound()
            return
        }

        tumourTypeInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TumourType.label', default: 'TumourType'), tumourTypeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tumourTypeInstance.label', default: 'TumourType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
