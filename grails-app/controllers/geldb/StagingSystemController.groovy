package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * StagingSystemController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Transactional(readOnly = true)
class StagingSystemController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StagingSystem.list(params), model: [stagingSystemInstanceCount: StagingSystem.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StagingSystem.list(params), model: [stagingSystemInstanceCount: StagingSystem.count()]
    }

    def show(StagingSystem stagingSystemInstance) {
        respond stagingSystemInstance
    }

    def create() {
        respond new StagingSystem(params)
    }

    @Transactional
    def save(StagingSystem stagingSystemInstance) {
        if (stagingSystemInstance == null) {
            notFound()
            return
        }

        if (stagingSystemInstance.hasErrors()) {
            respond stagingSystemInstance.errors, view: 'create'
            return
        }

        stagingSystemInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'stagingSystemInstance.label', default: 'StagingSystem'), stagingSystemInstance.id])
                redirect stagingSystemInstance
            }
            '*' { respond stagingSystemInstance, [status: CREATED] }
        }
    }

    def edit(StagingSystem stagingSystemInstance) {
        respond stagingSystemInstance
    }

    @Transactional
    def update(StagingSystem stagingSystemInstance) {
        if (stagingSystemInstance == null) {
            notFound()
            return
        }

        if (stagingSystemInstance.hasErrors()) {
            respond stagingSystemInstance.errors, view: 'edit'
            return
        }

        stagingSystemInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'StagingSystem.label', default: 'StagingSystem'), stagingSystemInstance.id])
                redirect stagingSystemInstance
            }
            '*' { respond stagingSystemInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(StagingSystem stagingSystemInstance) {

        if (stagingSystemInstance == null) {
            notFound()
            return
        }

        stagingSystemInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'StagingSystem.label', default: 'StagingSystem'), stagingSystemInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'stagingSystemInstance.label', default: 'StagingSystem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
