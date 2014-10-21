package geldb

import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * SequencingRunController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class SequencingRunController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SequencingRun.list(params), model: [sequencingRunInstanceCount: SequencingRun.count()]
    }

//    def list(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond SequencingRun.list(params), model: [sequencingRunInstanceCount: SequencingRun.count()]
//    }
    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [sequencingRunInstanceList: SequencingRun.list(params), sequencingRunInstanceTotal: SequencingRun.count()]
    }
    def filterPaneService

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ sequencingRunInstanceList: filterPaneService.filter( params, SequencingRun ),
                                     sequencingRunInstanceTotal: filterPaneService.count( params, SequencingRun ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def show(SequencingRun sequencingRunInstance) {
        respond sequencingRunInstance
    }

    def create() {
        respond new SequencingRun(params)
    }

    @Transactional
    def save(SequencingRun sequencingRunInstance) {
        if (sequencingRunInstance == null) {
            notFound()
            return
        }

        if (sequencingRunInstance.hasErrors()) {
            respond sequencingRunInstance.errors, view: 'create'
            return
        }

        sequencingRunInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sequencingRunInstance.label', default: 'SequencingRun'), sequencingRunInstance.id])
                redirect sequencingRunInstance
            }
            '*' { respond sequencingRunInstance, [status: CREATED] }
        }
    }

    def edit(SequencingRun sequencingRunInstance) {
        respond sequencingRunInstance
    }

    @Transactional
    def update(SequencingRun sequencingRunInstance) {
        if (sequencingRunInstance == null) {
            notFound()
            return
        }

        if (sequencingRunInstance.hasErrors()) {
            respond sequencingRunInstance.errors, view: 'edit'
            return
        }

        sequencingRunInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SequencingRun.label', default: 'SequencingRun'), sequencingRunInstance.id])
                redirect sequencingRunInstance
            }
            '*' { respond sequencingRunInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SequencingRun sequencingRunInstance) {

        if (sequencingRunInstance == null) {
            notFound()
            return
        }

        sequencingRunInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SequencingRun.label', default: 'SequencingRun'), sequencingRunInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sequencingRunInstance.label', default: 'SequencingRun'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
