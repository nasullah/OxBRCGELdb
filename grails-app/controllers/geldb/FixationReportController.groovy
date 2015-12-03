package geldb

import grails.plugins.springsecurity.Secured
import org.grails.plugin.filterpane.FilterPaneUtils

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * FixationReportController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class FixationReportController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond FixationReport.list(params), model: [fixationReportInstanceCount: FixationReport.count()]
    }

//    def list(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond FixationReport.list(params), model: [fixationReportInstanceCount: FixationReport.count()]
//    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [fixationReportInstanceList: FixationReport.list(params), fixationReportInstanceTotal: FixationReport.count()]
    }

    def filterPaneService
    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ fixationReportInstanceList: filterPaneService.filter( params, FixationReport ),
                                     fixationReportInstanceTotal: filterPaneService.count( params, FixationReport ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def show(FixationReport fixationReportInstance) {
        respond fixationReportInstance
    }

    def create() {
        respond new FixationReport(params)
    }

    @Transactional
    def save(FixationReport fixationReportInstance) {
        if (fixationReportInstance == null) {
            notFound()
            return
        }

        if (fixationReportInstance.hasErrors()) {
            respond fixationReportInstance.errors, view: 'create'
            return
        }

        fixationReportInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'fixationReportInstance.label', default: 'FixationReport'), fixationReportInstance.id])
//                redirect fixationReportInstance
                redirect(controller:'aliquot',action: 'show', params: [id: fixationReportInstance.aliquot.id])
            }
            '*' { respond fixationReportInstance, [status: CREATED] }
        }
    }

    def edit(FixationReport fixationReportInstance) {
        respond fixationReportInstance
    }

    @Transactional
    def update(FixationReport fixationReportInstance) {
        if (fixationReportInstance == null) {
            notFound()
            return
        }

        if (fixationReportInstance.hasErrors()) {
            respond fixationReportInstance.errors, view: 'edit'
            return
        }

        fixationReportInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FixationReport.label', default: 'FixationReport'), fixationReportInstance.id])
//                redirect fixationReportInstance
                redirect(controller:'aliquot',action: 'show', params: [id: fixationReportInstance.aliquot.id])
            }
            '*' { respond fixationReportInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(FixationReport fixationReportInstance) {

        if (fixationReportInstance == null) {
            notFound()
            return
        }

        fixationReportInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FixationReport.label', default: 'FixationReport'), fixationReportInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'fixationReportInstance.label', default: 'FixationReport'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
