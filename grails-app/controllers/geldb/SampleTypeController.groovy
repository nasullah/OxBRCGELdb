package geldb

import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * SampleTypeController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class SampleTypeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SampleType.list(params), model: [sampleTypeInstanceCount: SampleType.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SampleType.list(params), model: [sampleTypeInstanceCount: SampleType.count()]
    }

    def show(SampleType sampleTypeInstance) {
        def listSampleTypeAuditLogData = AuditLogEvent.findAllByPersistedObjectId(sampleTypeInstance?.id)
        respond sampleTypeInstance, model: [listAuditLogData: listSampleTypeAuditLogData]
    }

    def create() {
        respond new SampleType(params)
    }

    @Transactional
    def save(SampleType sampleTypeInstance) {
        if (sampleTypeInstance == null) {
            notFound()
            return
        }

        if (sampleTypeInstance.hasErrors()) {
            respond sampleTypeInstance.errors, view: 'create'
            return
        }

        sampleTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sampleTypeInstance.label', default: 'SampleType'), sampleTypeInstance.id])
                redirect sampleTypeInstance
            }
            '*' { respond sampleTypeInstance, [status: CREATED] }
        }
    }

    def edit(SampleType sampleTypeInstance) {
        respond sampleTypeInstance
    }

    @Transactional
    def update(SampleType sampleTypeInstance) {
        if (sampleTypeInstance == null) {
            notFound()
            return
        }

        if (sampleTypeInstance.hasErrors()) {
            respond sampleTypeInstance.errors, view: 'edit'
            return
        }

        sampleTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SampleType.label', default: 'SampleType'), sampleTypeInstance.id])
                redirect sampleTypeInstance
            }
            '*' { respond sampleTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SampleType sampleTypeInstance) {

        if (sampleTypeInstance == null) {
            notFound()
            return
        }

        sampleTypeInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SampleType.label', default: 'SampleType'), sampleTypeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sampleTypeInstance.label', default: 'SampleType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
