package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * SequencingReportsController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class SequencingReportsController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SequencingReports.list(params), model: [sequencingReportsInstanceCount: SequencingReports.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SequencingReports.list(params), model: [sequencingReportsInstanceCount: SequencingReports.count()]
    }

    def show(SequencingReports sequencingReportsInstance) {
        respond sequencingReportsInstance
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def create() {
        respond new SequencingReports(params)
    }

    @Transactional
    def save(SequencingReports sequencingReportsInstance) {
        if (sequencingReportsInstance == null) {
            notFound()
            return
        }

        if (sequencingReportsInstance.hasErrors()) {
            respond sequencingReportsInstance.errors, view: 'create'
            return
        }

        sequencingReportsInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sequencingReportsInstance.label', default: 'SequencingReports'), sequencingReportsInstance.id])
                redirect sequencingReportsInstance

            }
            '*' { respond sequencingReportsInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def edit(SequencingReports sequencingReportsInstance) {
        respond sequencingReportsInstance
    }

    @Transactional
    def update(SequencingReports sequencingReportsInstance) {
        if (sequencingReportsInstance == null) {
            notFound()
            return
        }

        if (sequencingReportsInstance.hasErrors()) {
            respond sequencingReportsInstance.errors, view: 'edit'
            return
        }

        sequencingReportsInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SequencingReports.label', default: 'SequencingReports'), sequencingReportsInstance.id])
                redirect sequencingReportsInstance
            }
            '*' { respond sequencingReportsInstance, [status: OK] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    @Transactional
    def delete(SequencingReports sequencingReportsInstance) {

        if (sequencingReportsInstance == null) {
            notFound()
            return
        }

        sequencingReportsInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SequencingReports.label', default: 'SequencingReports'), sequencingReportsInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sequencingReportsInstance.label', default: 'SequencingReports'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
