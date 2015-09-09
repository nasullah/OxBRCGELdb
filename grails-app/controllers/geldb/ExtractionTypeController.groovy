package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * ExtractionTypeController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class ExtractionTypeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ExtractionType.list(params), model: [extractionTypeInstanceCount: ExtractionType.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ExtractionType.list(params), model: [extractionTypeInstanceCount: ExtractionType.count()]
    }

    def show(ExtractionType extractionTypeInstance) {
        respond extractionTypeInstance
    }

    def create() {
        respond new ExtractionType(params)
    }

    @Transactional
    def save(ExtractionType extractionTypeInstance) {
        if (extractionTypeInstance == null) {
            notFound()
            return
        }

        if (extractionTypeInstance.hasErrors()) {
            respond extractionTypeInstance.errors, view: 'create'
            return
        }

        extractionTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'extractionTypeInstance.label', default: 'ExtractionType'), extractionTypeInstance.id])
                redirect extractionTypeInstance
            }
            '*' { respond extractionTypeInstance, [status: CREATED] }
        }
    }

    def edit(ExtractionType extractionTypeInstance) {
        respond extractionTypeInstance
    }

    @Transactional
    def update(ExtractionType extractionTypeInstance) {
        if (extractionTypeInstance == null) {
            notFound()
            return
        }

        if (extractionTypeInstance.hasErrors()) {
            respond extractionTypeInstance.errors, view: 'edit'
            return
        }

        extractionTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ExtractionType.label', default: 'ExtractionType'), extractionTypeInstance.id])
                redirect extractionTypeInstance
            }
            '*' { respond extractionTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ExtractionType extractionTypeInstance) {

        if (extractionTypeInstance == null) {
            notFound()
            return
        }

        extractionTypeInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ExtractionType.label', default: 'ExtractionType'), extractionTypeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'extractionTypeInstance.label', default: 'ExtractionType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
