package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * TissueProcessorController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class TissueProcessorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TissueProcessor.list(params), model: [tissueProcessorInstanceCount: TissueProcessor.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TissueProcessor.list(params), model: [tissueProcessorInstanceCount: TissueProcessor.count()]
    }

    def show(TissueProcessor tissueProcessorInstance) {
        respond tissueProcessorInstance
    }

    def create() {
        respond new TissueProcessor(params)
    }

    @Transactional
    def save(TissueProcessor tissueProcessorInstance) {
        if (tissueProcessorInstance == null) {
            notFound()
            return
        }

        if (tissueProcessorInstance.hasErrors()) {
            respond tissueProcessorInstance.errors, view: 'create'
            return
        }

        tissueProcessorInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tissueProcessorInstance.label', default: 'TissueProcessor'), tissueProcessorInstance.id])
                redirect tissueProcessorInstance
            }
            '*' { respond tissueProcessorInstance, [status: CREATED] }
        }
    }

    def edit(TissueProcessor tissueProcessorInstance) {
        respond tissueProcessorInstance
    }

    @Transactional
    def update(TissueProcessor tissueProcessorInstance) {
        if (tissueProcessorInstance == null) {
            notFound()
            return
        }

        if (tissueProcessorInstance.hasErrors()) {
            respond tissueProcessorInstance.errors, view: 'edit'
            return
        }

        tissueProcessorInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TissueProcessor.label', default: 'TissueProcessor'), tissueProcessorInstance.id])
                redirect tissueProcessorInstance
            }
            '*' { respond tissueProcessorInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(TissueProcessor tissueProcessorInstance) {

        if (tissueProcessorInstance == null) {
            notFound()
            return
        }

        tissueProcessorInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TissueProcessor.label', default: 'TissueProcessor'), tissueProcessorInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tissueProcessorInstance.label', default: 'TissueProcessor'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
