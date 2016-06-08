package geldb

import grails.plugins.springsecurity.Secured
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * StaffMemberController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class StaffMemberController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StaffMember.list(params), model: [staffMemberInstanceCount: StaffMember.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StaffMember.list(params), model: [staffMemberInstanceCount: StaffMember.count()]
    }

    def show(StaffMember staffMemberInstance) {
        def listStaffMemberAuditLogData = AuditLogEvent.findAllByPersistedObjectId(staffMemberInstance?.id)
        respond staffMemberInstance, model: [listAuditLogData: listStaffMemberAuditLogData]
    }

    def create() {
        respond new StaffMember(params)
    }

    @Transactional
    def save(StaffMember staffMemberInstance) {
        if (staffMemberInstance == null) {
            notFound()
            return
        }

        if (staffMemberInstance.hasErrors()) {
            respond staffMemberInstance.errors, view: 'create'
            return
        }

        staffMemberInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'staffMemberInstance.label', default: 'StaffMember'), staffMemberInstance.id])
                redirect staffMemberInstance
            }
            '*' { respond staffMemberInstance, [status: CREATED] }
        }
    }

    def edit(StaffMember staffMemberInstance) {
        respond staffMemberInstance
    }

    @Transactional
    def update(StaffMember staffMemberInstance) {
        if (staffMemberInstance == null) {
            notFound()
            return
        }

        if (staffMemberInstance.hasErrors()) {
            respond staffMemberInstance.errors, view: 'edit'
            return
        }

        staffMemberInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'StaffMember.label', default: 'StaffMember'), staffMemberInstance.id])
                redirect staffMemberInstance
            }
            '*' { respond staffMemberInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(StaffMember staffMemberInstance) {

        if (staffMemberInstance == null) {
            notFound()
            return
        }

        staffMemberInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'StaffMember.label', default: 'StaffMember'), staffMemberInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'staffMemberInstance.label', default: 'StaffMember'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
