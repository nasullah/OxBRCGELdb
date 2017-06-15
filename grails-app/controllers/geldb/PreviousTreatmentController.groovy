package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * PreviousTreatmentController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class PreviousTreatmentController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PreviousTreatment.list(params), model: [previousTreatmentInstanceCount: PreviousTreatment.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PreviousTreatment.list(params), model: [previousTreatmentInstanceCount: PreviousTreatment.count()]
    }

    def show(PreviousTreatment previousTreatmentInstance) {
        respond previousTreatmentInstance
    }

    def create() {
        respond new PreviousTreatment(params)
    }

    @Transactional
    def save(PreviousTreatment previousTreatmentInstance) {
        if (previousTreatmentInstance == null) {
            notFound()
            return
        }

        if (previousTreatmentInstance.hasErrors()) {
            respond previousTreatmentInstance.errors, view: 'create'
            return
        }

        previousTreatmentInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'previousTreatmentInstance.label', default: 'PreviousTreatment'), previousTreatmentInstance.id])
//                redirect previousTreatmentInstance
                redirect(controller:'participant',action: 'show', params: [id: previousTreatmentInstance.participant.id])
            }
            '*' { respond previousTreatmentInstance, [status: CREATED] }
        }
    }

    def edit(PreviousTreatment previousTreatmentInstance) {
        respond previousTreatmentInstance
    }

    @Transactional
    def update(PreviousTreatment previousTreatmentInstance) {
        if (previousTreatmentInstance == null) {
            notFound()
            return
        }

        if (previousTreatmentInstance.hasErrors()) {
            respond previousTreatmentInstance.errors, view: 'edit'
            return
        }

        previousTreatmentInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PreviousTreatment.label', default: 'PreviousTreatment'), previousTreatmentInstance.id])
//                redirect previousTreatmentInstance
                redirect(controller:'participant',action: 'show', params: [id: previousTreatmentInstance.participant.id])
            }
            '*' { respond previousTreatmentInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PreviousTreatment previousTreatmentInstance) {

        if (previousTreatmentInstance == null) {
            notFound()
            return
        }

        previousTreatmentInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PreviousTreatment.label', default: 'PreviousTreatment'), previousTreatmentInstance.id])
//                redirect action: "index", method: "GET"
                redirect(controller:'participant',action: 'show', params: [id: previousTreatmentInstance.participant.id])
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'previousTreatmentInstance.label', default: 'PreviousTreatment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
