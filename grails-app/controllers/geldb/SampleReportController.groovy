package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * SampleReportController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class SampleReportController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SampleReport.list(params), model: [sampleReportInstanceCount: SampleReport.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SampleReport.list(params), model: [sampleReportInstanceCount: SampleReport.count()]
    }

    def show(SampleReport sampleReportInstance) {
        respond sampleReportInstance
    }

    def create() {
        respond new SampleReport(params)
    }

    @Transactional
    def save(SampleReport sampleReportInstance) {
        if (sampleReportInstance == null) {
            notFound()
            return
        }

        if (sampleReportInstance.hasErrors()) {
            respond sampleReportInstance.errors, view: 'create'
            return
        }

        sampleReportInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sampleReportInstance.label', default: 'SampleReport'), sampleReportInstance.id])
                redirect sampleReportInstance
            }
            '*' { respond sampleReportInstance, [status: CREATED] }
        }
    }

    def edit(SampleReport sampleReportInstance) {
        respond sampleReportInstance
    }

    @Transactional
    def update(SampleReport sampleReportInstance) {
        if (sampleReportInstance == null) {
            notFound()
            return
        }

        if (sampleReportInstance.hasErrors()) {
            respond sampleReportInstance.errors, view: 'edit'
            return
        }

        sampleReportInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SampleReport.label', default: 'SampleReport'), sampleReportInstance.id])
                redirect sampleReportInstance
            }
            '*' { respond sampleReportInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SampleReport sampleReportInstance) {

        if (sampleReportInstance == null) {
            notFound()
            return
        }

        sampleReportInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SampleReport.label', default: 'SampleReport'), sampleReportInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sampleReportInstance.label', default: 'SampleReport'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
