package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * VCFpathController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class VCFpathController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond VCFpath.list(params), model: [VCFpathInstanceCount: VCFpath.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond VCFpath.list(params), model: [VCFpathInstanceCount: VCFpath.count()]
    }

    def show(VCFpath VCFpathInstance) {
        respond VCFpathInstance
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def create() {
        respond new VCFpath(params)
    }

    @Transactional
    def save(VCFpath VCFpathInstance) {
        if (VCFpathInstance == null) {
            notFound()
            return
        }

        if (VCFpathInstance.hasErrors()) {
            respond VCFpathInstance.errors, view: 'create'
            return
        }

        VCFpathInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'VCFpathInstance.label', default: 'VCFpath'), VCFpathInstance.id])
                //redirect VCFpathInstance
                redirect(controller:'sequencingRun',action: 'show', params: [id:VCFpathInstance.sequencingReports.sequencingRun.id])
            }
            '*' { respond VCFpathInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def edit(VCFpath VCFpathInstance) {
        respond VCFpathInstance
    }

    @Transactional
    def update(VCFpath VCFpathInstance) {
        if (VCFpathInstance == null) {
            notFound()
            return
        }

        if (VCFpathInstance.hasErrors()) {
            respond VCFpathInstance.errors, view: 'edit'
            return
        }

        VCFpathInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'VCFpath.label', default: 'VCFpath'), VCFpathInstance.id])
                redirect VCFpathInstance
            }
            '*' { respond VCFpathInstance, [status: OK] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    @Transactional
    def delete(VCFpath VCFpathInstance) {

        if (VCFpathInstance == null) {
            notFound()
            return
        }

        VCFpathInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'VCFpath.label', default: 'VCFpath'), VCFpathInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'VCFpathInstance.label', default: 'VCFpath'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
