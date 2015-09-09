package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * TissueIschaemiaController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class TissueIschaemiaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TissueIschaemia.list(params), model: [tissueIschaemiaInstanceCount: TissueIschaemia.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TissueIschaemia.list(params), model: [tissueIschaemiaInstanceCount: TissueIschaemia.count()]
    }

    def show(TissueIschaemia tissueIschaemiaInstance) {
        respond tissueIschaemiaInstance
    }

    def create() {
        respond new TissueIschaemia(params)
    }

    @Transactional
    def save(TissueIschaemia tissueIschaemiaInstance) {
        if (tissueIschaemiaInstance == null) {
            notFound()
            return
        }

        if (tissueIschaemiaInstance.hasErrors()) {
            respond tissueIschaemiaInstance.errors, view: 'create'
            return
        }

        tissueIschaemiaInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tissueIschaemiaInstance.label', default: 'TissueIschaemia'), tissueIschaemiaInstance.id])
                redirect tissueIschaemiaInstance
            }
            '*' { respond tissueIschaemiaInstance, [status: CREATED] }
        }
    }

    def edit(TissueIschaemia tissueIschaemiaInstance) {
        respond tissueIschaemiaInstance
    }

    @Transactional
    def update(TissueIschaemia tissueIschaemiaInstance) {
        if (tissueIschaemiaInstance == null) {
            notFound()
            return
        }

        if (tissueIschaemiaInstance.hasErrors()) {
            respond tissueIschaemiaInstance.errors, view: 'edit'
            return
        }

        tissueIschaemiaInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TissueIschaemia.label', default: 'TissueIschaemia'), tissueIschaemiaInstance.id])
                redirect tissueIschaemiaInstance
            }
            '*' { respond tissueIschaemiaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(TissueIschaemia tissueIschaemiaInstance) {

        if (tissueIschaemiaInstance == null) {
            notFound()
            return
        }

        tissueIschaemiaInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TissueIschaemia.label', default: 'TissueIschaemia'), tissueIschaemiaInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tissueIschaemiaInstance.label', default: 'TissueIschaemia'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
