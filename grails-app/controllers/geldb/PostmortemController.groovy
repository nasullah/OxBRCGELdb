package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * PostmortemController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class PostmortemController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Postmortem.list(params), model: [postmortemInstanceCount: Postmortem.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Postmortem.list(params), model: [postmortemInstanceCount: Postmortem.count()]
    }

    def show(Postmortem postmortemInstance) {
        respond postmortemInstance
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def create() {
        respond new Postmortem(params)
    }

    @Transactional
    def save(Postmortem postmortemInstance) {
        if (postmortemInstance == null) {
            notFound()
            return
        }

        if (postmortemInstance.hasErrors()) {
            respond postmortemInstance.errors, view: 'create'
            return
        }

        postmortemInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'postmortemInstance.label', default: 'Postmortem'), postmortemInstance.id])
                redirect postmortemInstance
            }
            '*' { respond postmortemInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def edit(Postmortem postmortemInstance) {
        respond postmortemInstance
    }

    @Transactional
    def update(Postmortem postmortemInstance) {
        if (postmortemInstance == null) {
            notFound()
            return
        }

        if (postmortemInstance.hasErrors()) {
            respond postmortemInstance.errors, view: 'edit'
            return
        }

        postmortemInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Postmortem.label', default: 'Postmortem'), postmortemInstance.id])
                redirect postmortemInstance
            }
            '*' { respond postmortemInstance, [status: OK] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    @Transactional
    def delete(Postmortem postmortemInstance) {

        if (postmortemInstance == null) {
            notFound()
            return
        }

        postmortemInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Postmortem.label', default: 'Postmortem'), postmortemInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'postmortemInstance.label', default: 'Postmortem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
