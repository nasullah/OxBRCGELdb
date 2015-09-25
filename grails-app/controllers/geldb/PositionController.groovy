package geldb

import org.grails.plugin.filterpane.FilterPaneUtils

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * PositionController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class PositionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Position.list(params).sort{it.letter+it.number}, model: [positionInstanceCount: Position.count()]
    }

//    def list(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond Position.list(params), model: [positionInstanceCount: Position.count()]
//    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [positionInstanceList: Position.list(params).sort{it.letter+it.number}, positionInstanceTotal: Position.count()]
    }
    def filterPaneService

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ positionInstanceList: filterPaneService.filter( params, Position ),
                                     positionInstanceTotal: filterPaneService.count( params, Position ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def show(Position positionInstance) {
        respond positionInstance
    }

    def create() {
        respond new Position(params)
    }

    def filterPlateOrBox() {

        def freezer = Freezer.get(params.long('freezer'))
        if (freezer){
            def listPlateOrBox = PlateOrBox.where {
                shelf.freezer == freezer
            }
            render(template: "listPlateOrBox", model: [listPlateOrBox: listPlateOrBox])
        }
    }

    @Transactional
    def save(Position positionInstance) {
        def containedSampleId = params.long('identifiedSample.id')
        def boxId = params.long('plateOrBox.id')
        def letter = params.letter
            letter = letter?.toString()
        def number = params.number
            number = number?.toString()
        if (positionInstance == null) {
            notFound()
            return
        }
        def sample =IdentifiedSample.findById(containedSampleId)
        def existedPosition = Position.findByPlateOrBoxAndLetterAndNumber(PlateOrBox.findById(boxId),letter,number)
        if (existedPosition){
            def nonExhaustedSample = existedPosition.containedSamples.findAll {s -> !s.exhausted}
            if (!nonExhaustedSample.empty){
                flash.message = "Position with letter/number pair ${letter} ${number} has been already created in this Box/Plate and it contains a non exhausted sample. Please enter another pair of letter and number."
                redirect(action: "create", params: ['containedSamples': containedSampleId, 'number':number, 'letter':letter, 'plateOrBox.id': boxId])
            } else if (nonExhaustedSample.empty && sample){
                existedPosition.addToContainedSamples(sample).save flush: true
                flash.message = message(code: 'default.created.message', args: [message(code: 'positionInstance.label', default: 'Position'), existedPosition.id])
                redirect existedPosition
            }
        }else if (!existedPosition && sample){
            positionInstance.addToContainedSamples(sample).save flush: true
            request.withFormat {
                form {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'positionInstance.label', default: 'Position'), positionInstance.id])
                    redirect positionInstance
                }
                '*' { respond positionInstance, [status: CREATED] }
            }
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
//        Integer paramValue = params.int('identifiedSample.id')
//        def sample =IdentifiedSample.findById(paramValue)
//        positionInstance.addToContainedSamples(sample).save flush: true

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

        if (!positionInstance.containedSamples){
            positionInstance.delete flush: true
            flash.message = "Position has been deleted"
            redirect action: "index", method: "GET"
        } else if (positionInstance.containedSamples.size() == 1){
            positionInstance.removeFromContainedSamples(positionInstance.containedSamples[0])
            positionInstance.delete flush: true
            flash.message = "Position has been deleted"
            redirect action: "index", method: "GET"
        } else {
            flash.message = "Position cannot be deleted, deleting the position would remove all previous history."
            redirect positionInstance
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
