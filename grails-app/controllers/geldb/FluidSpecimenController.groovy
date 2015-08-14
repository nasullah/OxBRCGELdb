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

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond FluidSpecimen.findAllByExhausted(false, params), model: [fluidSpecimenInstanceCount: FluidSpecimen.count()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [fluidSpecimenInstanceList: FluidSpecimen.findAllByExhausted(false, params), fluidSpecimenInstanceTotal: FluidSpecimen.count()]
    }
    def filterPaneService

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

            def cleanGelID = { domain, value ->
                return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
            }

            List fields = ["participant.studySubject.studySubjectIdentifier", "fluidSampleType", "primaryContainer", "barcode", "timePoint", "exhausted", "notes","collectionDate","collectionTime","collectionLocation","collectedBy","fluidSpecimenVolume", "volumeUnit"]
            Map labels = ["fluidSampleType":"FluidSample Type", "primaryContainer":"Primary Container", "barcode":"Barcode", "timePoint":"Time Point", "exhausted":"Exhausted", "notes":"Notes", "collectionDate":"Collection Date", "collectionTime":"Collection Time",
                          "collectionLocation":"Collection Location", "collectedBy":"Collected By", "fluidSpecimenVolume":"Fluid Specimen Volume", "volumeUnit":"Volume Unit", "participant.studySubject.studySubjectIdentifier":"GEL Study ID"]
            Map parameters = [title: "FluidSpecimens", "column.widths": [0.2, 0.3, 0.5]]
            Map formatters = ["participant.studySubject.studySubjectIdentifier":cleanGelID]

            exportService.export(params.format, response.outputStream, exportFluidSpecimensData, fields, labels, formatters, parameters )
        }
    }

    def show(FluidSpecimen fluidSpecimenInstance) {
        respond fluidSpecimenInstance
    }

    def create() {
        respond new FluidSpecimen(params)
    }

//    @Transactional
//    def saveDuplicates() {
//        def fluidSpecimenInstance = new FluidSpecimen(params)
//        if (fluidSpecimenInstance == null) {
//            notFound()
//            return
//        }
//
//        if (fluidSpecimenInstance.hasErrors()) {
//            respond fluidSpecimenInstance.errors, view: 'create'
//            return
//        }
//        fluidSpecimenInstance.save(flush: true)
//        flash.message = "This is the newly created duplicate fluid specimen with id ${fluidSpecimenInstance.id}"
//        redirect fluidSpecimenInstance
//    }

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
