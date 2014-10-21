package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
/**
 * FluidSpecimenController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class FluidSpecimenController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond FluidSpecimen.list(params), model: [fluidSpecimenInstanceCount: FluidSpecimen.count()]
    }

//    def list(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond FluidSpecimen.list(params), model: [fluidSpecimenInstanceCount: FluidSpecimen.count()]
//    }
    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [fluidSpecimenInstanceList: FluidSpecimen.list(params), fluidSpecimenInstanceTotal: FluidSpecimen.count()]
    }
    def filterPaneService

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ fluidSpecimenInstanceList: filterPaneService.filter( params, FluidSpecimen ),
                                     fluidSpecimenInstanceTotal: filterPaneService.count( params, FluidSpecimen ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def show(FluidSpecimen fluidSpecimenInstance) {
        respond fluidSpecimenInstance
    }

    def create() {
        respond new FluidSpecimen(params)
    }

    @Transactional
    def save(FluidSpecimen fluidSpecimenInstance) {
        if (fluidSpecimenInstance == null) {
            notFound()
            return
        }

        if (fluidSpecimenInstance.hasErrors()) {
            respond fluidSpecimenInstance.errors, view: 'create'
            return
        }

        fluidSpecimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'fluidSpecimenInstance.label', default: 'FluidSpecimen'), fluidSpecimenInstance.id])
                redirect fluidSpecimenInstance
            }
            '*' { respond fluidSpecimenInstance, [status: CREATED] }
        }
    }

    def edit(FluidSpecimen fluidSpecimenInstance) {
        respond fluidSpecimenInstance
    }

    @Transactional
    def update(FluidSpecimen fluidSpecimenInstance) {
        if (fluidSpecimenInstance == null) {
            notFound()
            return
        }

        if (fluidSpecimenInstance.hasErrors()) {
            respond fluidSpecimenInstance.errors, view: 'edit'
            return
        }

        fluidSpecimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FluidSpecimen.label', default: 'FluidSpecimen'), fluidSpecimenInstance.id])
                redirect fluidSpecimenInstance
            }
            '*' { respond fluidSpecimenInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(FluidSpecimen fluidSpecimenInstance) {

        if (fluidSpecimenInstance == null) {
            notFound()
            return
        }

        fluidSpecimenInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FluidSpecimen.label', default: 'FluidSpecimen'), fluidSpecimenInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'fluidSpecimenInstance.label', default: 'FluidSpecimen'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
