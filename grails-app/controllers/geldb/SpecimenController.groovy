package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * SpecimenController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class SpecimenController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Specimen.list(params), model: [specimenInstanceCount: Specimen.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Specimen.list(params), model: [specimenInstanceCount: Specimen.count()]
    }

    def show(Specimen specimenInstance) {
        respond specimenInstance
    }

    def create() {
        respond new Specimen(params)
    }

    @Transactional
    def save(Specimen specimenInstance) {
        if (specimenInstance == null) {
            notFound()
            return
        }

        if (specimenInstance.hasErrors()) {
            respond specimenInstance.errors, view: 'create'
            return
        }

        specimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'specimenInstance.label', default: 'Specimen'), specimenInstance.id])
                redirect specimenInstance
            }
            '*' { respond specimenInstance, [status: CREATED] }
        }
    }

    def edit(Specimen specimenInstance) {
        respond specimenInstance
    }

    @Transactional
    def update(Specimen specimenInstance) {
        if (specimenInstance == null) {
            notFound()
            return
        }

        if (specimenInstance.hasErrors()) {
            respond specimenInstance.errors, view: 'edit'
            return
        }

        specimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Specimen.label', default: 'Specimen'), specimenInstance.id])
                redirect specimenInstance
            }
            '*' { respond specimenInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Specimen specimenInstance) {

        if (specimenInstance == null) {
            notFound()
            return
        }

        specimenInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Specimen.label', default: 'Specimen'), specimenInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'specimenInstance.label', default: 'Specimen'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
