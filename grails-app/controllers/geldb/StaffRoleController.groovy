package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * StaffRoleController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class StaffRoleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StaffRole.list(params), model: [staffRoleInstanceCount: StaffRole.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StaffRole.list(params), model: [staffRoleInstanceCount: StaffRole.count()]
    }

    def show(StaffRole staffRoleInstance) {
        respond staffRoleInstance
    }

    def create() {
        respond new StaffRole(params)
    }

    @Transactional
    def save(StaffRole staffRoleInstance) {
        if (staffRoleInstance == null) {
            notFound()
            return
        }

        if (staffRoleInstance.hasErrors()) {
            respond staffRoleInstance.errors, view: 'create'
            return
        }

        staffRoleInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'staffRoleInstance.label', default: 'StaffRole'), staffRoleInstance.id])
                redirect staffRoleInstance
            }
            '*' { respond staffRoleInstance, [status: CREATED] }
        }
    }

    def edit(StaffRole staffRoleInstance) {
        respond staffRoleInstance
    }

    @Transactional
    def update(StaffRole staffRoleInstance) {
        if (staffRoleInstance == null) {
            notFound()
            return
        }

        if (staffRoleInstance.hasErrors()) {
            respond staffRoleInstance.errors, view: 'edit'
            return
        }

        staffRoleInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'StaffRole.label', default: 'StaffRole'), staffRoleInstance.id])
                redirect staffRoleInstance
            }
            '*' { respond staffRoleInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(StaffRole staffRoleInstance) {

        if (staffRoleInstance == null) {
            notFound()
            return
        }

        staffRoleInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'StaffRole.label', default: 'StaffRole'), staffRoleInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'staffRoleInstance.label', default: 'StaffRole'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
