package geldb

import org.hibernate.SessionFactory

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
/**
 * AliquotController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class AliquotController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Aliquot.findAllByExhausted(false, params.max ), model: [aliquotInstanceCount: Aliquot.count()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [aliquotInstanceList: Aliquot.findAllByExhausted(false, params.max ), aliquotInstanceTotal: Aliquot.count()]
    }
    def filterPaneService

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ aliquotInstanceList: filterPaneService.filter( params, Aliquot ),
                                     aliquotInstanceTotal: filterPaneService.count( params, Aliquot ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def findSpecimenByGeLId() {
        def gelId= params.search

        def listSpecimenByGeLId = Specimen.where{
            participant.studySubject.studySubjectIdentifier == gelId
        }.findAllByExhausted(false)
        if (!listSpecimenByGeLId.empty){
            render(template: "specimenList",  model: [listSpecimenByGeLId: listSpecimenByGeLId])
        }
    }

    def show(Aliquot aliquotInstance) {
        respond aliquotInstance
    }

    def create() {
        respond new Aliquot(params)
    }

    @Transactional
    def save(Aliquot aliquotInstance) {

        if (aliquotInstance == null) {
            notFound()
            return
        }

        if (aliquotInstance.hasErrors()) {
            respond aliquotInstance.errors, view: 'create'
            return
        }

        aliquotInstance.save(flush: true)
        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'Aliquot.label', default: 'Aliquot'), aliquotInstance.id])

            }
            '*' { respond aliquotInstance, [status: CREATED] }
        }
        redirect aliquotInstance
    }

    @Transactional
    def saveDuplicates() {
        def aliquotInstance = new Aliquot(params)
        if (aliquotInstance == null) {
            notFound()
            return
        }

        if (aliquotInstance.hasErrors()) {
            respond aliquotInstance.errors, view: 'create'
            return
        }
        aliquotInstance.save(flush: true)
        flash.message = "This is the newly created duplicate Aliquot with id ${aliquotInstance.id}"
        redirect aliquotInstance
    }

    def edit(Aliquot aliquotInstance) {
        respond aliquotInstance
    }

    @Transactional
    def update(Aliquot aliquotInstance) {
        if (aliquotInstance == null) {
            notFound()
            return
        }

        if (aliquotInstance.hasErrors()) {
            respond aliquotInstance.errors, view: 'edit'
            return
        }

        aliquotInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Aliquot.label', default: 'Aliquot'), aliquotInstance.id])
                redirect aliquotInstance
            }
            '*' { respond aliquotInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Aliquot aliquotInstance) {

        if (aliquotInstance == null) {
            notFound()
            return
        }

        aliquotInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Aliquot.label', default: 'Aliquot'), aliquotInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'aliquotInstance.label', default: 'Aliquot'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
