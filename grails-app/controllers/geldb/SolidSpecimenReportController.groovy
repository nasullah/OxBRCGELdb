package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * SolidSpecimenReportController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class SolidSpecimenReportController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SolidSpecimenReport.list(params), model: [solidSpecimenReportInstanceCount: SolidSpecimenReport.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SolidSpecimenReport.list(params), model: [solidSpecimenReportInstanceCount: SolidSpecimenReport.count()]
    }

    def show(SolidSpecimenReport solidSpecimenReportInstance) {
        respond solidSpecimenReportInstance
    }

    def create() {
        respond new SolidSpecimenReport(params)
    }

    @Transactional
    def save(SolidSpecimenReport solidSpecimenReportInstance) {
        if (solidSpecimenReportInstance == null) {
            notFound()
            return
        }

        if (solidSpecimenReportInstance.hasErrors()) {
            respond solidSpecimenReportInstance.errors, view: 'create'
            return
        }

        solidSpecimenReportInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'solidSpecimenReportInstance.label', default: 'SolidSpecimenReport'), solidSpecimenReportInstance.id])
                redirect solidSpecimenReportInstance
            }
            '*' { respond solidSpecimenReportInstance, [status: CREATED] }
        }
    }

    def edit(SolidSpecimenReport solidSpecimenReportInstance) {
        respond solidSpecimenReportInstance
    }

    @Transactional
    def update(SolidSpecimenReport solidSpecimenReportInstance) {
        if (solidSpecimenReportInstance == null) {
            notFound()
            return
        }

        if (solidSpecimenReportInstance.hasErrors()) {
            respond solidSpecimenReportInstance.errors, view: 'edit'
            return
        }

        solidSpecimenReportInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SolidSpecimenReport.label', default: 'SolidSpecimenReport'), solidSpecimenReportInstance.id])
                redirect solidSpecimenReportInstance
            }
            '*' { respond solidSpecimenReportInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SolidSpecimenReport solidSpecimenReportInstance) {

        if (solidSpecimenReportInstance == null) {
            notFound()
            return
        }

        solidSpecimenReportInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SolidSpecimenReport.label', default: 'SolidSpecimenReport'), solidSpecimenReportInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'solidSpecimenReportInstance.label', default: 'SolidSpecimenReport'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
