package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * DiseaseTypeController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class DiseaseTypeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DiseaseType.list(params), model: [diseaseTypeInstanceCount: DiseaseType.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DiseaseType.list(params), model: [diseaseTypeInstanceCount: DiseaseType.count()]
    }

    def show(DiseaseType diseaseTypeInstance) {
        respond diseaseTypeInstance
    }

    def create() {
        respond new DiseaseType(params)
    }

    @Transactional
    def save(DiseaseType diseaseTypeInstance) {
        if (diseaseTypeInstance == null) {
            notFound()
            return
        }

        if (diseaseTypeInstance.hasErrors()) {
            respond diseaseTypeInstance.errors, view: 'create'
            return
        }

        diseaseTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'diseaseTypeInstance.label', default: 'DiseaseType'), diseaseTypeInstance.id])
                //redirect diseaseTypeInstance
                redirect(controller:'participant',action: 'show', params: [id:diseaseTypeInstance.participant.id])
            }
            '*' { respond diseaseTypeInstance, [status: CREATED] }
        }
    }

    def edit(DiseaseType diseaseTypeInstance) {
        respond diseaseTypeInstance
    }

    @Transactional
    def update(DiseaseType diseaseTypeInstance) {
        if (diseaseTypeInstance == null) {
            notFound()
            return
        }

        if (diseaseTypeInstance.hasErrors()) {
            respond diseaseTypeInstance.errors, view: 'edit'
            return
        }

        diseaseTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DiseaseType.label', default: 'DiseaseType'), diseaseTypeInstance.id])
                //redirect diseaseTypeInstance
                redirect(controller:'participant',action: 'show', params: [id:diseaseTypeInstance.participant.id])
            }
            '*' { respond diseaseTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(DiseaseType diseaseTypeInstance) {

        if (diseaseTypeInstance == null) {
            notFound()
            return
        }

        diseaseTypeInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DiseaseType.label', default: 'DiseaseType'), diseaseTypeInstance.id])
               // redirect action: "index", method: "GET"
                redirect(controller:'participant',action: 'show', params: [id:diseaseTypeInstance.participant.id])
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'diseaseTypeInstance.label', default: 'DiseaseType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
