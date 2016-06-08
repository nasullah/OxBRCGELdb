package geldb

import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * CollectionMethodController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class CollectionMethodController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CollectionMethod.list(params), model: [collectionMethodInstanceCount: CollectionMethod.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CollectionMethod.list(params), model: [collectionMethodInstanceCount: CollectionMethod.count()]
    }

    def show(CollectionMethod collectionMethodInstance) {
        def listCollectionMethodAuditLogData = AuditLogEvent.findAllByPersistedObjectId(collectionMethodInstance?.id)
        respond collectionMethodInstance, model: [listAuditLogData: listCollectionMethodAuditLogData]
    }

    def create() {
        respond new CollectionMethod(params)
    }

    @Transactional
    def save(CollectionMethod collectionMethodInstance) {
        if (collectionMethodInstance == null) {
            notFound()
            return
        }

        if (collectionMethodInstance.hasErrors()) {
            respond collectionMethodInstance.errors, view: 'create'
            return
        }

        collectionMethodInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'collectionMethodInstance.label', default: 'CollectionMethod'), collectionMethodInstance.id])
                redirect collectionMethodInstance
            }
            '*' { respond collectionMethodInstance, [status: CREATED] }
        }
    }

    def edit(CollectionMethod collectionMethodInstance) {
        respond collectionMethodInstance
    }

    @Transactional
    def update(CollectionMethod collectionMethodInstance) {
        if (collectionMethodInstance == null) {
            notFound()
            return
        }

        if (collectionMethodInstance.hasErrors()) {
            respond collectionMethodInstance.errors, view: 'edit'
            return
        }

        collectionMethodInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CollectionMethod.label', default: 'CollectionMethod'), collectionMethodInstance.id])
                redirect collectionMethodInstance
            }
            '*' { respond collectionMethodInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CollectionMethod collectionMethodInstance) {

        if (collectionMethodInstance == null) {
            notFound()
            return
        }

        collectionMethodInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CollectionMethod.label', default: 'CollectionMethod'), collectionMethodInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'collectionMethodInstance.label', default: 'CollectionMethod'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
