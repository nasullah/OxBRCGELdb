package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * DispatchedBoxController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class DispatchedBoxController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DispatchedBox.list(params), model:[dispatchedBoxInstanceCount: DispatchedBox.count()]
    }

	def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DispatchedBox.list(params), model:[dispatchedBoxInstanceCount: DispatchedBox.count()]
    }

    def show(DispatchedBox dispatchedBoxInstance) {
        respond dispatchedBoxInstance
    }

    def create() {
        respond new DispatchedBox(params)
    }

    def uploadFile = {
        def dispatchedBox = DispatchedBox.findById(params.long('dispatchedBox'))
        if (!request.getFile('file').originalFilename) {
            flash.message = "Please choose a file"
            redirect(controller:'dispatchedBox',action: 'show', params: [id: dispatchedBox.id])
        } else{
            request.getFile('file').inputStream.splitEachLine(',')
                    { fields ->
                        def identifiedSample = IdentifiedSample.findByBarcodeAndExhausted(fields[1].trim(), false)
                        if (identifiedSample) {
                            def dispatchItemInstance = new DispatchItem()
                            dispatchItemInstance.identifiedSample = identifiedSample
                            if (DNA_Extract.findById(identifiedSample.id)){
                                dispatchItemInstance.volume_ul = identifiedSample.dNAAmount
                            }else if (Aliquot.findById(identifiedSample.id)){
                                dispatchItemInstance.volume_ul = identifiedSample.aliquotVolumeMass
                            }
                            dispatchItemInstance.positionIfPlated = fields[0].trim()
                            dispatchItemInstance.dispatchedBox = dispatchedBox
                            dispatchItemInstance.save flush: true
                            for (item in IdentifiedSample.listOrderById()) {
                                if (item.id == dispatchItemInstance.identifiedSample.id) {
                                    item.exhausted = 'true'
                                    item.save flush: true
                                }
                            }
                        }
                    }
            redirect(controller:'dispatchedBox',action: 'show', params: [id: dispatchedBox.id])
        }
    }

    @Transactional
    def save(DispatchedBox dispatchedBoxInstance) {
        if (dispatchedBoxInstance == null) {
            notFound()
            return
        }

        if (dispatchedBoxInstance.hasErrors()) {
            respond dispatchedBoxInstance.errors, view:'create'
            return
        }

        dispatchedBoxInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'dispatchedBoxInstance.label', default: 'DispatchedBox'), dispatchedBoxInstance.id])
                redirect dispatchedBoxInstance
            }
            '*' { respond dispatchedBoxInstance, [status: CREATED] }
        }
    }

    def edit(DispatchedBox dispatchedBoxInstance) {
        respond dispatchedBoxInstance
    }

    @Transactional
    def update(DispatchedBox dispatchedBoxInstance) {
        if (dispatchedBoxInstance == null) {
            notFound()
            return
        }

        if (dispatchedBoxInstance.hasErrors()) {
            respond dispatchedBoxInstance.errors, view:'edit'
            return
        }

        dispatchedBoxInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DispatchedBox.label', default: 'DispatchedBox'), dispatchedBoxInstance.id])
                redirect dispatchedBoxInstance
            }
            '*'{ respond dispatchedBoxInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(DispatchedBox dispatchedBoxInstance) {

        if (dispatchedBoxInstance == null) {
            notFound()
            return
        }

        dispatchedBoxInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DispatchedBox.label', default: 'DispatchedBox'), dispatchedBoxInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'dispatchedBoxInstance.label', default: 'DispatchedBox'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
