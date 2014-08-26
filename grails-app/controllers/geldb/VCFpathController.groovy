package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * VCFpathController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
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
                redirect VCFpathInstance
            }
            '*' { respond VCFpathInstance, [status: CREATED] }
        }
    }

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
