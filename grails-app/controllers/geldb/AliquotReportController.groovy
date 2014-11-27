package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * AliquotReportController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class AliquotReportController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AliquotReport.list(params), model: [aliquotReportInstanceCount: AliquotReport.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AliquotReport.list(params), model: [aliquotReportInstanceCount: AliquotReport.count()]
    }
//    def listMemberOfStaff() {
//
//        List <StaffMember> results = StaffMember.findAllByStaffRoleNotEqualOrStaffRoleNotEqual(StaffRole.findByRole('Pathologist'),StaffRole.findByRole('Surgeon'))
//        [memberList: results]
//    }

    def show(AliquotReport aliquotReportInstance) {
        respond aliquotReportInstance
    }

    def create() {
        respond new AliquotReport(params)
    }

    @Transactional
    def save(AliquotReport aliquotReportInstance) {
        if (aliquotReportInstance == null) {
            notFound()
            return
        }

        if (aliquotReportInstance.hasErrors()) {
            respond aliquotReportInstance.errors, view: 'create'
            return
        }

        aliquotReportInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'aliquotReportInstance.label', default: 'AliquotReport'), aliquotReportInstance.id])
                //redirect aliquotReportInstance
                redirect(controller:'aliquot',action: 'show', params: [id:aliquotReportInstance.aliquot.id])
            }
            '*' { respond aliquotReportInstance, [status: CREATED] }
        }
    }

    def edit(AliquotReport aliquotReportInstance) {
        respond aliquotReportInstance
    }

    @Transactional
    def update(AliquotReport aliquotReportInstance) {
        if (aliquotReportInstance == null) {
            notFound()
            return
        }

        if (aliquotReportInstance.hasErrors()) {
            respond aliquotReportInstance.errors, view: 'edit'
            return
        }

        aliquotReportInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'AliquotReport.label', default: 'AliquotReport'), aliquotReportInstance.id])
                redirect aliquotReportInstance
            }
            '*' { respond aliquotReportInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(AliquotReport aliquotReportInstance) {

        if (aliquotReportInstance == null) {
            notFound()
            return
        }

        aliquotReportInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'AliquotReport.label', default: 'AliquotReport'), aliquotReportInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'aliquotReportInstance.label', default: 'AliquotReport'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
