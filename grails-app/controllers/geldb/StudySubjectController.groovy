package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * StudySubjectController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Transactional(readOnly = true)
class StudySubjectController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StudySubject.list(params), model: [studySubjectInstanceCount: StudySubject.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StudySubject.list(params), model: [studySubjectInstanceCount: StudySubject.count()]
    }

    def show(StudySubject studySubjectInstance) {
        respond studySubjectInstance
    }

    def create() {
        respond new StudySubject(params)
    }

    @Transactional
    def save(StudySubject studySubjectInstance) {
        if (studySubjectInstance == null) {
            notFound()
            return
        }

        if (studySubjectInstance.hasErrors()) {
            respond studySubjectInstance.errors, view: 'create'
            return
        }

        studySubjectInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'studySubjectInstance.label', default: 'StudySubject'), studySubjectInstance.id])
                redirect studySubjectInstance
            }
            '*' { respond studySubjectInstance, [status: CREATED] }
        }
    }

    def edit(StudySubject studySubjectInstance) {
        respond studySubjectInstance
    }

    @Transactional
    def update(StudySubject studySubjectInstance) {
        if (studySubjectInstance == null) {
            notFound()
            return
        }

        if (studySubjectInstance.hasErrors()) {
            respond studySubjectInstance.errors, view: 'edit'
            return
        }

        studySubjectInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'StudySubject.label', default: 'StudySubject'), studySubjectInstance.id])
                redirect studySubjectInstance
            }
            '*' { respond studySubjectInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(StudySubject studySubjectInstance) {

        if (studySubjectInstance == null) {
            notFound()
            return
        }

        studySubjectInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'StudySubject.label', default: 'StudySubject'), studySubjectInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'studySubjectInstance.label', default: 'StudySubject'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
