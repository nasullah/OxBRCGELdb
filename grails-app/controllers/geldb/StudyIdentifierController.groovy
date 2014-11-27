package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * StudyIdentifierController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class StudyIdentifierController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StudyIdentifier.list(params), model: [studyIdentifierInstanceCount: StudyIdentifier.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StudyIdentifier.list(params), model: [studyIdentifierInstanceCount: StudyIdentifier.count()]
    }

    def show(StudyIdentifier studyIdentifierInstance) {
        respond studyIdentifierInstance
    }

    def create() {
        respond new StudyIdentifier(params)
    }

    @Transactional
    def save(StudyIdentifier studyIdentifierInstance) {
        if (studyIdentifierInstance == null) {
            notFound()
            return
        }

        if (studyIdentifierInstance.hasErrors()) {
            respond studyIdentifierInstance.errors, view: 'create'
            return
        }

        studyIdentifierInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'studyIdentifierInstance.label', default: 'StudyIdentifier'), studyIdentifierInstance.id])
                redirect studyIdentifierInstance
            }
            '*' { respond studyIdentifierInstance, [status: CREATED] }
        }
    }

    def edit(StudyIdentifier studyIdentifierInstance) {
        respond studyIdentifierInstance
    }

    @Transactional
    def update(StudyIdentifier studyIdentifierInstance) {
        if (studyIdentifierInstance == null) {
            notFound()
            return
        }

        if (studyIdentifierInstance.hasErrors()) {
            respond studyIdentifierInstance.errors, view: 'edit'
            return
        }

        studyIdentifierInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'StudyIdentifier.label', default: 'StudyIdentifier'), studyIdentifierInstance.id])
                redirect studyIdentifierInstance
            }
            '*' { respond studyIdentifierInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(StudyIdentifier studyIdentifierInstance) {

        if (studyIdentifierInstance == null) {
            notFound()
            return
        }

        studyIdentifierInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'StudyIdentifier.label', default: 'StudyIdentifier'), studyIdentifierInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'studyIdentifierInstance.label', default: 'StudyIdentifier'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
