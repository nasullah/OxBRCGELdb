package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * InstrumentsUsedByPathologistController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Transactional(readOnly = true)
class InstrumentsUsedByPathologistController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond InstrumentsUsedByPathologist.list(params), model: [instrumentsUsedByPathologistInstanceCount: InstrumentsUsedByPathologist.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond InstrumentsUsedByPathologist.list(params), model: [instrumentsUsedByPathologistInstanceCount: InstrumentsUsedByPathologist.count()]
    }

    def show(InstrumentsUsedByPathologist instrumentsUsedByPathologistInstance) {
        respond instrumentsUsedByPathologistInstance
    }

    def create() {
        respond new InstrumentsUsedByPathologist(params)
    }

    @Transactional
    def save(InstrumentsUsedByPathologist instrumentsUsedByPathologistInstance) {
        if (instrumentsUsedByPathologistInstance == null) {
            notFound()
            return
        }

        if (instrumentsUsedByPathologistInstance.hasErrors()) {
            respond instrumentsUsedByPathologistInstance.errors, view: 'create'
            return
        }

        instrumentsUsedByPathologistInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'instrumentsUsedByPathologistInstance.label', default: 'InstrumentsUsedByPathologist'), instrumentsUsedByPathologistInstance.id])
                redirect instrumentsUsedByPathologistInstance
            }
            '*' { respond instrumentsUsedByPathologistInstance, [status: CREATED] }
        }
    }

    def edit(InstrumentsUsedByPathologist instrumentsUsedByPathologistInstance) {
        respond instrumentsUsedByPathologistInstance
    }

    @Transactional
    def update(InstrumentsUsedByPathologist instrumentsUsedByPathologistInstance) {
        if (instrumentsUsedByPathologistInstance == null) {
            notFound()
            return
        }

        if (instrumentsUsedByPathologistInstance.hasErrors()) {
            respond instrumentsUsedByPathologistInstance.errors, view: 'edit'
            return
        }

        instrumentsUsedByPathologistInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'InstrumentsUsedByPathologist.label', default: 'InstrumentsUsedByPathologist'), instrumentsUsedByPathologistInstance.id])
                redirect instrumentsUsedByPathologistInstance
            }
            '*' { respond instrumentsUsedByPathologistInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(InstrumentsUsedByPathologist instrumentsUsedByPathologistInstance) {

        if (instrumentsUsedByPathologistInstance == null) {
            notFound()
            return
        }

        instrumentsUsedByPathologistInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'InstrumentsUsedByPathologist.label', default: 'InstrumentsUsedByPathologist'), instrumentsUsedByPathologistInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'instrumentsUsedByPathologistInstance.label', default: 'InstrumentsUsedByPathologist'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
