package geldb

import grails.converters.*
import org.hibernate.SessionFactory
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.MultipartRequest

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
/**
 * AliquotController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class AliquotController {

    def exportService
    def filterPaneService
    def exportAliquotService
    def exportListOfMaterialSuppliedService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Aliquot.findAllByExhausted(false, params), model: [aliquotInstanceCount: Aliquot.count()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [aliquotInstanceList: Aliquot.findAllByExhausted(false, params), aliquotInstanceTotal: Aliquot.count()]
    }

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ aliquotInstanceList: filterPaneService.filter( params, Aliquot ),
                                     aliquotInstanceTotal: filterPaneService.count( params, Aliquot ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def findSpecimenByGeLId() {
        def gelId= params.search
        if (gelId) {
            def participantByGeLId = Participant.createCriteria().get {
                studySubject {
                    eq('studySubjectIdentifier', gelId, [ignoreCase: true])
                }
            }
            if(participantByGeLId){
                participantByGeLId = participantByGeLId.id
                def listSpecimenByGeLId = Specimen.findAll {
                    participant.id == participantByGeLId
                }
                listSpecimenByGeLId = listSpecimenByGeLId.findAll { a ->
                    !a.exhausted
                }
                if (!listSpecimenByGeLId.empty) {
                    render(template: "specimenList", model: [listSpecimenByGeLId: listSpecimenByGeLId])
                }
            }
        }
    }

    def exhaustSpecimen() {
        def fluidSpecimen = FluidSpecimen.get(params.long('selectedSpecimen'))
        if (fluidSpecimen?.fluidSampleType?.value == 'Blood whole BLD'){
            render(template: "exhaustSpecimen")
        }
    }

    def preFillCreatedOn() {
        def createdOn = FluidSpecimen.get(params.long('specimenId'))?.collectionDate
        if (createdOn){
            render createdOn as XML
        }
    }

    def preFillCreatedOnFFAliquot() {
        def aliquotType = AliquotType.get(params.long('aliquotType'))
        if (aliquotType?.aliquotTypeName == "Punch Biopsy Frozen"){
            def createdOn = SolidSpecimen.get(params.long('specimenId'))?.collectionDate
            if (createdOn){
                render createdOn as XML
            }
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportAliquots(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported All Aliquots.${params.extension}")
            def exportAliquotsData = Aliquot.list().sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
            exportService.export(params.format, response.outputStream, exportAliquotsData, exportAliquotService.fields, exportAliquotService.labels, exportAliquotService.formatters, exportAliquotService.parameters )
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportListOfMaterialSupplied(){
        def paramsStartDate = params.startDate
        def paramsEndDate = params.endDate
        def aliquotType = params.long('aliquotType')
        def startDate = new Date()
        def endDate =new Date()
        if (paramsStartDate){
            startDate = startDate.parse("yyyy-MM-dd", paramsStartDate.toString())
        }
        if (paramsEndDate){
            endDate = endDate.parse("yyyy-MM-dd", paramsEndDate.toString())
        }
        if (paramsEndDate && paramsStartDate && aliquotType) {
            if (params?.format && params.format != "html") {
                response.contentType = grailsApplication.config.grails.mime.types[params.format]
                response.setHeader("Content-disposition", "attachment; filename= Exported Material Supplied.${params.extension}")
                def exportListOfMaterialSuppliedData = Aliquot.createCriteria().list {
                    and {
                        le("createdOn", endDate)
                        ge("createdOn", startDate)
                        eq("aliquotType", AliquotType.findById(aliquotType))
                    }
                }?.sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
                exportService.export(params.format, response.outputStream, exportListOfMaterialSuppliedData, exportListOfMaterialSuppliedService.fields, exportListOfMaterialSuppliedService.labels, exportListOfMaterialSuppliedService.formatters, exportListOfMaterialSuppliedService.parameters)
            }
        }else {
            flash.message = "Enter start date, end date and aliquotType"
            redirect(uri: "/participant/summaryReport")
        }
    }

    def awaitingFFaliquots(){
        def results = SolidSpecimen.list()
        results = results.findAll{specimen -> !Aliquot.findByAliquotTypeAndSpecimen(AliquotType.findByAliquotTypeName("Fresh Frozen Tissue"), specimen)}
        [solidSpecimenInstanceList: results.sort {it.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    def awaitingFFPEaliquots(){
        def results = SolidSpecimen.list()
        results = results.findAll{specimen -> !Aliquot.findByAliquotTypeAndSpecimen(AliquotType.findByAliquotTypeName("Punch Biopsy FFPE, NBF"), specimen)}
        results = results.findAll{specimen -> !Aliquot.findByAliquotTypeAndSpecimen(AliquotType.findByAliquotTypeName("Punch Biopsy FFPE"), specimen)}
        [solidSpecimenInstanceList: results.sort {it.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
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

        aliquotInstance.save flush: true

        def exhaustBlood = params.exhaustBlood
        if (exhaustBlood == 'True'){
            aliquotInstance.specimen.exhausted = true
            aliquotInstance.specimen.save flush: true
        }
        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'Aliquot.label', default: 'Aliquot'), aliquotInstance.id])

            }
            '*' { respond aliquotInstance, [status: CREATED] }
        }
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

        if (aliquotInstance?.derivedFrom?.id != null){
            def derivationInstance = Derivation.get(aliquotInstance?.derivedFrom?.id)
            def getStaffMember = StaffMember.get(params.long('derivedBy.id'))

            derivationInstance.aliquot.id           = params.long('aliquot.id')
            derivationInstance.derivationProcess    = params.derivationProcess
            derivationInstance.derivationDate       = new Date().parse("yyyy-MM-dd", params.derivationDate)
            derivationInstance.derivationTime       = params.derivationTime
            derivationInstance.derivedBy            = getStaffMember

            derivationInstance.addToDerivedAliquots(aliquotInstance).save(flush: true)
            request.withFormat {
                form {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'derivationInstance.label', default: 'Derivation'), derivationInstance.id])
                redirect aliquotInstance
                }
                '*' { respond derivationInstance, [status: CREATED] }
            }
        } else {
            aliquotInstance.save flush: true
            def exhaustBlood = params.exhaustBlood
            if (exhaustBlood == 'True'){
                aliquotInstance.specimen.exhausted = true
                aliquotInstance.specimen.save flush: true
            }

            request.withFormat {
                form {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'Aliquot.label', default: 'Aliquot'), aliquotInstance.id])
                    redirect aliquotInstance
                }
                '*' { respond aliquotInstance, [status: OK] }
            }
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
