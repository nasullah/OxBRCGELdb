package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * ICD10Controller
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class ICD10Controller {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ICD10.list(params), model: [ICD10InstanceCount: ICD10.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ICD10.list(params), model: [ICD10InstanceCount: ICD10.count()]
    }

    def show(ICD10 ICD10Instance) {
        respond ICD10Instance
    }

    def create() {
        respond new ICD10(params)
    }

    @Transactional
    def save(ICD10 ICD10Instance) {
        if (ICD10Instance == null) {
            notFound()
            return
        }

        if (ICD10Instance.hasErrors()) {
            respond ICD10Instance.errors, view: 'create'
            return
        }

        ICD10Instance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'ICD10Instance.label', default: 'ICD10'), ICD10Instance.id])
                redirect ICD10Instance
            }
            '*' { respond ICD10Instance, [status: CREATED] }
        }
    }

    def edit(ICD10 ICD10Instance) {
        respond ICD10Instance
    }

    @Transactional
    def update(ICD10 ICD10Instance) {
        if (ICD10Instance == null) {
            notFound()
            return
        }

        if (ICD10Instance.hasErrors()) {
            respond ICD10Instance.errors, view: 'edit'
            return
        }

        ICD10Instance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ICD10.label', default: 'ICD10'), ICD10Instance.id])
                redirect ICD10Instance
            }
            '*' { respond ICD10Instance, [status: OK] }
        }
    }

    @Transactional
    def delete(ICD10 ICD10Instance) {

        if (ICD10Instance == null) {
            notFound()
            return
        }

        ICD10Instance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ICD10.label', default: 'ICD10'), ICD10Instance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'ICD10Instance.label', default: 'ICD10'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
