package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * DispatchItemController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class DispatchItemController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DispatchItem.list(params), model: [dispatchItemInstanceCount: DispatchItem.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DispatchItem.list(params), model: [dispatchItemInstanceCount: DispatchItem.count()]
    }

    def show(DispatchItem dispatchItemInstance) {
        respond dispatchItemInstance
    }

    def create() {
        respond new DispatchItem(params)
    }

    @Transactional
    def save(DispatchItem dispatchItemInstance) {
        def barcode =params.barcode
        def identifiedSample = IdentifiedSample.findByBarcodeAndExhausted(barcode.toString(), false)
        if (identifiedSample){
            dispatchItemInstance.identifiedSample = identifiedSample
            if (DNA_Extract.findById(identifiedSample.id)){
                dispatchItemInstance.volume_ul = identifiedSample.dNAAmount
            }else if (Aliquot.findById(identifiedSample.id)){
                dispatchItemInstance.volume_ul = identifiedSample.aliquotVolumeMass
            }
            if (dispatchItemInstance == null) {
                notFound()
                return
            }

            dispatchItemInstance.save flush: true
            for ( item in IdentifiedSample.listOrderById())
                if(item.id == dispatchItemInstance.identifiedSample.id){
                    item.exhausted = 'true'
                    item.save flush: true
                }

            request.withFormat {
                form {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'dispatchItemInstance.label', default: 'DispatchItem'), dispatchItemInstance.id])
                    redirect dispatchItemInstance.dispatchedBox
                }
                '*' { respond dispatchItemInstance, [status: CREATED] }
            }

        } else{
            flash.message = 'Cannot find sample.'
            redirect(controller:'dispatchItem',action: 'create', params: [dispatchedBox: dispatchItemInstance?.dispatchedBox?.id, positionIfPlated:dispatchItemInstance?.positionIfPlated, volume_ul:dispatchItemInstance?.volume_ul])
        }
    }

    def edit(DispatchItem dispatchItemInstance) {
        respond dispatchItemInstance
    }

    @Transactional
    def update(DispatchItem dispatchItemInstance) {
        if (dispatchItemInstance == null) {
            notFound()
            return
        }

        if (dispatchItemInstance.hasErrors()) {
            respond dispatchItemInstance.errors, view: 'edit'
            return
        }

        dispatchItemInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DispatchItem.label', default: 'DispatchItem'), dispatchItemInstance.id])
                redirect dispatchItemInstance
            }
            '*' { respond dispatchItemInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(DispatchItem dispatchItemInstance) {

        if (dispatchItemInstance == null) {
            notFound()
            return
        }

        def identifiedSample = dispatchItemInstance?.identifiedSample

        if (identifiedSample){
            def aliquot = Aliquot.findById(identifiedSample.id)
            def dnaExtract = DNA_Extract.findById(identifiedSample.id)
            if (aliquot){
                aliquot.exhausted = false
                aliquot.save flush: true
                dispatchItemInstance.delete flush: true
            } else if(dnaExtract){
                dnaExtract.exhausted = false
                dnaExtract.save flush: true
                dispatchItemInstance.delete flush: true
            }
        }else {
            dispatchItemInstance.delete flush: true
        }

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DispatchItem.label', default: 'DispatchItem'), dispatchItemInstance.id])
//                redirect action: "index", method: "GET"
                redirect(controller:'dispatchedBox',action: 'show', params: [id: dispatchItemInstance.dispatchedBox.id])
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'dispatchItemInstance.label', default: 'DispatchItem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
