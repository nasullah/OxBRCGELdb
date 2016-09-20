package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * FlowCellController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class FlowCellController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond FlowCell.list(params), model: [flowCellInstanceCount: FlowCell.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond FlowCell.list(params), model: [flowCellInstanceCount: FlowCell.count()]
    }

    def show(FlowCell flowCellInstance) {
        respond flowCellInstance
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def create() {
        respond new FlowCell(params)
    }

    @Transactional
    def save(FlowCell flowCellInstance) {
        if (flowCellInstance == null) {
            notFound()
            return
        }

        if (flowCellInstance.hasErrors()) {
            respond flowCellInstance.errors, view: 'create'
            return
        }

        flowCellInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'flowCellInstance.label', default: 'FlowCell'), flowCellInstance.id])
                //redirect flowCellInstance
                redirect(controller:'sequencingRun',action: 'show', params: [id:flowCellInstance.sequencingRun.id])
            }
            '*' { respond flowCellInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def edit(FlowCell flowCellInstance) {
        respond flowCellInstance
    }

    @Transactional
    def update(FlowCell flowCellInstance) {
        if (flowCellInstance == null) {
            notFound()
            return
        }

        if (flowCellInstance.hasErrors()) {
            respond flowCellInstance.errors, view: 'edit'
            return
        }

        flowCellInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FlowCell.label', default: 'FlowCell'), flowCellInstance.id])
                redirect flowCellInstance
            }
            '*' { respond flowCellInstance, [status: OK] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    @Transactional
    def delete(FlowCell flowCellInstance) {

        if (flowCellInstance == null) {
            notFound()
            return
        }

        flowCellInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FlowCell.label', default: 'FlowCell'), flowCellInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'flowCellInstance.label', default: 'FlowCell'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
