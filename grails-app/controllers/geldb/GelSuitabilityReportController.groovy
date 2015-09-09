package geldb

import grails.plugins.springsecurity.Secured
import org.grails.plugin.filterpane.FilterPaneUtils

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * GelSuitabilityReportController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class GelSuitabilityReportController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond GelSuitabilityReport.list(params), model: [gelSuitabilityReportInstanceCount: GelSuitabilityReport.count()]
    }

//    def list(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond GelSuitabilityReport.list(params), model: [gelSuitabilityReportInstanceCount: GelSuitabilityReport.count()]
//    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [gelSuitabilityReportInstanceList: GelSuitabilityReport.list(params), gelSuitabilityReportInstanceTotal: GelSuitabilityReport.count()]
    }
    def filterPaneService

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ gelSuitabilityReportInstanceList: filterPaneService.filter( params, GelSuitabilityReport ),
                                     gelSuitabilityReportInstanceTotal: filterPaneService.count( params, GelSuitabilityReport ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def show(GelSuitabilityReport gelSuitabilityReportInstance) {
        respond gelSuitabilityReportInstance
    }

    def create() {
        respond new GelSuitabilityReport(params)
    }

    @Transactional
    def save(GelSuitabilityReport gelSuitabilityReportInstance) {
        if (gelSuitabilityReportInstance == null) {
            notFound()
            return
        }

        if (gelSuitabilityReportInstance.hasErrors()) {
            respond gelSuitabilityReportInstance.errors, view: 'create'
            return
        }

        gelSuitabilityReportInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'gelSuitabilityReportInstance.label', default: 'GelSuitabilityReport'), gelSuitabilityReportInstance.id])
                //redirect gelSuitabilityReportInstance
                redirect(controller:'aliquot',action: 'show', params: [id: gelSuitabilityReportInstance.aliquot.id])
            }
            '*' { respond gelSuitabilityReportInstance, [status: CREATED] }
        }
    }

    def edit(GelSuitabilityReport gelSuitabilityReportInstance) {
        respond gelSuitabilityReportInstance
    }

    @Transactional
    def update(GelSuitabilityReport gelSuitabilityReportInstance) {
        if (gelSuitabilityReportInstance == null) {
            notFound()
            return
        }

        if (gelSuitabilityReportInstance.hasErrors()) {
            respond gelSuitabilityReportInstance.errors, view: 'edit'
            return
        }

        gelSuitabilityReportInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'GelSuitabilityReport.label', default: 'GelSuitabilityReport'), gelSuitabilityReportInstance.id])
                redirect gelSuitabilityReportInstance
            }
            '*' { respond gelSuitabilityReportInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(GelSuitabilityReport gelSuitabilityReportInstance) {

        if (gelSuitabilityReportInstance == null) {
            notFound()
            return
        }

        gelSuitabilityReportInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'GelSuitabilityReport.label', default: 'GelSuitabilityReport'), gelSuitabilityReportInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'gelSuitabilityReportInstance.label', default: 'GelSuitabilityReport'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
