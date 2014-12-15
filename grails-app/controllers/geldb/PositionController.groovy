package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * PositionController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class PositionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Position.list(params), model: [positionInstanceCount: Position.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Position.list(params), model: [positionInstanceCount: Position.count()]
    }

    def show(Position positionInstance) {
        respond positionInstance
    }

    def create() {
        respond new Position(params)
    }

    def findSampleByGeLId() {
        def gelId = params.search
        def sampleType = params.selectType
        if (sampleType == "Fluid Specimen"){
            def listSampleByGeLId = FluidSpecimen.where{
                participant.studySubject.studySubjectIdentifier == gelId
            }.findAll()
            if (!listSampleByGeLId.empty){
                render(template: "samples",  model: [listSampleByGeLId: listSampleByGeLId])
            }
        } else if (sampleType == "Solid Specimen"){
            def listSampleByGeLId = SolidSpecimen.where{
                participant.studySubject.studySubjectIdentifier == gelId
            }.findAll()
            if (!listSampleByGeLId.empty){
                render(template: "samples",  model: [listSampleByGeLId: listSampleByGeLId])
            }
        }else if (sampleType == "Aliquot"){
            def listSampleByGeLId = Aliquot.where{
                specimen.participant.studySubject.studySubjectIdentifier == gelId
            }.findAll()
            if (!listSampleByGeLId.empty){
                render(template: "samples",  model: [listSampleByGeLId: listSampleByGeLId])
            }
        }else if (sampleType == "DNA Extract"){
            def listSampleByGeLId = DNA_Extract.where{
                aliquot.specimen.participant.studySubject.studySubjectIdentifier == gelId
            }.findAll()
            if (!listSampleByGeLId.empty){
                render(template: "samples",  model: [listSampleByGeLId: listSampleByGeLId])
            }
        }else if (sampleType == "DNA Library"){
            def listSampleByGeLId = DNA_Library.where{
                na_extract.aliquot.specimen.participant.studySubject.studySubjectIdentifier == gelId
            }.findAll()
            if (!listSampleByGeLId.empty){
                render(template: "samples",  model: [listSampleByGeLId: listSampleByGeLId])
            }
        }
    }

    @Transactional
    def save(Position positionInstance) {
        if (positionInstance == null) {
            notFound()
            return
        }


        if (positionInstance.hasErrors()) {
            respond positionInstance.errors, view: 'create'
            return
        }
        Integer paramValue = params.int('identifiedSample.id')
        print(paramValue)
        def sample =IdentifiedSample.findById(paramValue)
        //positionInstance.save flush: true

        positionInstance.addToContainedSamples(sample).save flush: true




        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'positionInstance.label', default: 'Position'), positionInstance.id])
                redirect positionInstance
            }
            '*' { respond positionInstance, [status: CREATED] }
        }
    }

    def edit(Position positionInstance) {
        respond positionInstance
    }

    @Transactional
    def update(Position positionInstance) {
        if (positionInstance == null) {
            notFound()
            return
        }

        if (positionInstance.hasErrors()) {
            respond positionInstance.errors, view: 'edit'
            return
        }

        positionInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Position.label', default: 'Position'), positionInstance.id])
                redirect positionInstance
            }
            '*' { respond positionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Position positionInstance) {

        if (positionInstance == null) {
            notFound()
            return
        }

        positionInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Position.label', default: 'Position'), positionInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'positionInstance.label', default: 'Position'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
