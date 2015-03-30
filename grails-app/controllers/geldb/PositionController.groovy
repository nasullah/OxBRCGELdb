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
        respond Position.list(params), model: [positionInstanceCount: Position.count()]
    }

//    def list(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond Position.list(params), model: [positionInstanceCount: Position.count()]
//    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [positionInstanceList: Position.list(params), positionInstanceTotal: Position.count()]
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
        Integer containedSample = params.int('identifiedSample.id')
        Integer box = params.int('plateOrBox.id')
        if (positionInstance == null) {
            notFound()
            return
        }

//        if (positionInstance.hasErrors()) {
//            respond positionInstance.errors, view: 'create'
//            return
//        }

        def sample =IdentifiedSample.findById(containedSample)
        def existedPosition = Position.findByPlateOrBoxAndLetterAndNumber(PlateOrBox.get(box),params.letter,params.number)
        if (existedPosition){
            def nonExhaustedSample = existedPosition.containedSamples.findAll {s -> !s.exhausted}
            if (nonExhaustedSample){
                flash.message = "Position with letter/number pair ${params.letter} ${params.number} has been already created in this Box/Plate and it contains a non exhausted sample. Please enter another pair of letter and number."
                redirect(action: "create", params: ['containedSamples': containedSample, 'number':params.number, 'letter':params.letter, 'plateOrBox.id': box])
                return
            } else if (!nonExhaustedSample && sample){
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
