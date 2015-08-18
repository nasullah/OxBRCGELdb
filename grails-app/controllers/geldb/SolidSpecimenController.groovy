package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
/**
 * SolidSpecimenController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class SolidSpecimenController {

    def exportService
    def exportSolidSpecimenService
    def filterPaneService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SolidSpecimen.findAllByExhausted(false, params), model: [solidSpecimenInstanceCount: SolidSpecimen.count()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [solidSpecimenInstanceList: SolidSpecimen.findAllByExhausted(false, params), solidSpecimenInstanceTotal: SolidSpecimen.count()]
    }

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ solidSpecimenInstanceList: filterPaneService.filter( params, SolidSpecimen ),
                                     solidSpecimenInstanceTotal: filterPaneService.count( params, SolidSpecimen ),
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
    def exportSolidSpecimens(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported All Main Specimens and Reports.${params.extension}")
            def exportSolidSpecimensData = SolidSpecimen.list().sort {it.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
            exportService.export(params.format, response.outputStream, exportSolidSpecimensData, exportSolidSpecimenService.fields, exportSolidSpecimenService.labels, exportSolidSpecimenService.formatters, exportSolidSpecimenService.parameters )
        }
    }

    def awaitingMainSpecimen() {
        def fluidSpecimen = FluidSpecimen.list()
        fluidSpecimen = fluidSpecimen.findAll {p -> !SolidSpecimen.findById(p.participant.id)}
        def results = fluidSpecimen.participant.unique()
        [participantList: results.sort {it.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    def show(SolidSpecimen solidSpecimenInstance) {
        respond solidSpecimenInstance
    }

    def create() {
        respond new SolidSpecimen(params)
    }

    @Transactional
    def save(SolidSpecimen solidSpecimenInstance) {
        if (solidSpecimenInstance == null) {
            notFound()
            return
        }

        if (solidSpecimenInstance.hasErrors()) {
            respond solidSpecimenInstance.errors, view: 'create'
            return
        }

        solidSpecimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'solidSpecimenInstance.label', default: 'SolidSpecimen'), solidSpecimenInstance.id])
                redirect solidSpecimenInstance
            }
            '*' { respond solidSpecimenInstance, [status: CREATED] }
        }
    }

    def edit(SolidSpecimen solidSpecimenInstance) {
        respond solidSpecimenInstance
    }

    @Transactional
    def update(SolidSpecimen solidSpecimenInstance) {
        if (solidSpecimenInstance == null) {
            notFound()
            return
        }

        if (solidSpecimenInstance.hasErrors()) {
            respond solidSpecimenInstance.errors, view: 'edit'
            return
        }

        solidSpecimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SolidSpecimen.label', default: 'SolidSpecimen'), solidSpecimenInstance.id])
                redirect solidSpecimenInstance
            }
            '*' { respond solidSpecimenInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SolidSpecimen solidSpecimenInstance) {

        if (solidSpecimenInstance == null) {
            notFound()
            return
        }

        solidSpecimenInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SolidSpecimen.label', default: 'SolidSpecimen'), solidSpecimenInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'solidSpecimenInstance.label', default: 'SolidSpecimen'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
