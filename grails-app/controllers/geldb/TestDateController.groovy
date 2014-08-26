package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * TestDateController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Transactional(readOnly = true)
class TestDateController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TestDate.list(params), model: [testDateInstanceCount: TestDate.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TestDate.list(params), model: [testDateInstanceCount: TestDate.count()]
    }

    def show(TestDate testDateInstance) {
        respond testDateInstance
    }

    def create() {
        respond new TestDate(params)
    }

    @Transactional
    def save(TestDate testDateInstance) {
        if (testDateInstance == null) {
            notFound()
            return
        }

        if (testDateInstance.hasErrors()) {
            respond testDateInstance.errors, view: 'create'
            return
        }

        testDateInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'testDateInstance.label', default: 'TestDate'), testDateInstance.id])
                redirect testDateInstance
            }
            '*' { respond testDateInstance, [status: CREATED] }
        }
    }

    def edit(TestDate testDateInstance) {
        respond testDateInstance
    }

    @Transactional
    def update(TestDate testDateInstance) {
        if (testDateInstance == null) {
            notFound()
            return
        }

        if (testDateInstance.hasErrors()) {
            respond testDateInstance.errors, view: 'edit'
            return
        }

        testDateInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TestDate.label', default: 'TestDate'), testDateInstance.id])
                redirect testDateInstance
            }
            '*' { respond testDateInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(TestDate testDateInstance) {

        if (testDateInstance == null) {
            notFound()
            return
        }

        testDateInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TestDate.label', default: 'TestDate'), testDateInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'testDateInstance.label', default: 'TestDate'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
