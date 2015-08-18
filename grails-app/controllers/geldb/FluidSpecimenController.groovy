package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
/**
 * FluidSpecimenController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class FluidSpecimenController {

    def exportService
    def exportFluidSpecimenService
    def filterPaneService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond FluidSpecimen.findAllByExhausted(false, params), model: [fluidSpecimenInstanceCount: FluidSpecimen.count()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [fluidSpecimenInstanceList: FluidSpecimen.findAllByExhausted(false, params), fluidSpecimenInstanceTotal: FluidSpecimen.count()]
    }

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ fluidSpecimenInstanceList: filterPaneService.filter( params, FluidSpecimen ),
                                     fluidSpecimenInstanceTotal: filterPaneService.count( params, FluidSpecimen ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def findParticipantByGeLId() {
        def gelId= params.search
        if (gelId) {
            def participantByGeLId = Participant.createCriteria().get {
                studySubject {
                    eq('studySubjectIdentifier', gelId, [ignoreCase: true])
                }
            }
            if (participantByGeLId && gelId) {
                render(template: "participantList", model: [listParticipantByGeLId: participantByGeLId])
            }
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportFluidSpecimens(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported All FluidSpecimens.${params.extension}")
            def exportFluidSpecimensData = FluidSpecimen.list().sort {it.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
            exportService.export(params.format, response.outputStream, exportFluidSpecimensData, exportFluidSpecimenService.fields, exportFluidSpecimenService.labels, exportFluidSpecimenService.formatters, exportFluidSpecimenService.parameters)
        }
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
