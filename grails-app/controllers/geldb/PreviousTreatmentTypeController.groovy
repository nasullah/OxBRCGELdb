package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * PreviousTreatmentTypeController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class PreviousTreatmentTypeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PreviousTreatmentType.list(params), model: [previousTreatmentTypeInstanceCount: PreviousTreatmentType.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PreviousTreatmentType.list(params), model: [previousTreatmentTypeInstanceCount: PreviousTreatmentType.count()]
    }

    def show(PreviousTreatmentType previousTreatmentTypeInstance) {
        respond previousTreatmentTypeInstance
    }

    def create() {
        respond new PreviousTreatmentType(params)
    }

    @Transactional
    def save(PreviousTreatmentType previousTreatmentTypeInstance) {
        if (previousTreatmentTypeInstance == null) {
            notFound()
            return
        }

        if (previousTreatmentTypeInstance.hasErrors()) {
            respond previousTreatmentTypeInstance.errors, view: 'create'
            return
        }

        previousTreatmentTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'previousTreatmentTypeInstance.label', default: 'PreviousTreatmentType'), previousTreatmentTypeInstance.id])
                redirect previousTreatmentTypeInstance
            }
            '*' { respond previousTreatmentTypeInstance, [status: CREATED] }
        }
    }

    def edit(PreviousTreatmentType previousTreatmentTypeInstance) {
        respond previousTreatmentTypeInstance
    }

    @Transactional
    def update(PreviousTreatmentType previousTreatmentTypeInstance) {
        if (previousTreatmentTypeInstance == null) {
            notFound()
            return
        }

        if (previousTreatmentTypeInstance.hasErrors()) {
            respond previousTreatmentTypeInstance.errors, view: 'edit'
            return
        }

        previousTreatmentTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PreviousTreatmentType.label', default: 'PreviousTreatmentType'), previousTreatmentTypeInstance.id])
                redirect previousTreatmentTypeInstance
            }
            '*' { respond previousTreatmentTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PreviousTreatmentType previousTreatmentTypeInstance) {

        if (previousTreatmentTypeInstance == null) {
            notFound()
            return
        }

        previousTreatmentTypeInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PreviousTreatmentType.label', default: 'PreviousTreatmentType'), previousTreatmentTypeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'previousTreatmentTypeInstance.label', default: 'PreviousTreatmentType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
