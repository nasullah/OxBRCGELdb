package geldb

import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * StudyController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class StudyController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Study.list(params), model: [studyInstanceCount: Study.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Study.list(params), model: [studyInstanceCount: Study.count()]
    }

    def show(Study studyInstance) {
        def listStudyAuditLogData = AuditLogEvent.findAllByPersistedObjectId(studyInstance?.id)
        respond studyInstance, model: [listAuditLogData: listStudyAuditLogData]
    }

    def create() {
        respond new Study(params)
    }

    @Transactional
    def save(Study studyInstance) {
        if (studyInstance == null) {
            notFound()
            return
        }

        if (studyInstance.hasErrors()) {
            respond studyInstance.errors, view: 'create'
            return
        }

        studyInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'studyInstance.label', default: 'Study'), studyInstance.id])
                redirect studyInstance
            }
            '*' { respond studyInstance, [status: CREATED] }
        }
    }

    def edit(Study studyInstance) {
        respond studyInstance
    }

    @Transactional
    def update(Study studyInstance) {
        if (studyInstance == null) {
            notFound()
            return
        }

        if (studyInstance.hasErrors()) {
            respond studyInstance.errors, view: 'edit'
            return
        }

        studyInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Study.label', default: 'Study'), studyInstance.id])
                redirect studyInstance
            }
            '*' { respond studyInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Study studyInstance) {

        if (studyInstance == null) {
            notFound()
            return
        }

        studyInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Study.label', default: 'Study'), studyInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'studyInstance.label', default: 'Study'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
