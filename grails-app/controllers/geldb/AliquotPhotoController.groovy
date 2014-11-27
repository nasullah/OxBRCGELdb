package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * AliquotPhotoController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Transactional(readOnly = true)
class AliquotPhotoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AliquotPhoto.list(params), model: [aliquotPhotoInstanceCount: AliquotPhoto.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AliquotPhoto.list(params), model: [aliquotPhotoInstanceCount: AliquotPhoto.count()]
    }

    def show(AliquotPhoto aliquotPhotoInstance) {
        respond aliquotPhotoInstance
    }

    def create() {
        respond new AliquotPhoto(params)
    }

    @Transactional
    def save(AliquotPhoto aliquotPhotoInstance) {
        if (aliquotPhotoInstance == null) {
            notFound()
            return
        }

        if (aliquotPhotoInstance.hasErrors()) {
            respond aliquotPhotoInstance.errors, view: 'create'
            return
        }

        aliquotPhotoInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'aliquotPhotoInstance.label', default: 'AliquotPhoto'), aliquotPhotoInstance.id])
                redirect aliquotPhotoInstance
            }
            '*' { respond aliquotPhotoInstance, [status: CREATED] }
        }
    }

    def edit(AliquotPhoto aliquotPhotoInstance) {
        respond aliquotPhotoInstance
    }

    @Transactional
    def update(AliquotPhoto aliquotPhotoInstance) {
        if (aliquotPhotoInstance == null) {
            notFound()
            return
        }

        if (aliquotPhotoInstance.hasErrors()) {
            respond aliquotPhotoInstance.errors, view: 'edit'
            return
        }

        aliquotPhotoInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'AliquotPhoto.label', default: 'AliquotPhoto'), aliquotPhotoInstance.id])
                redirect aliquotPhotoInstance
            }
            '*' { respond aliquotPhotoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(AliquotPhoto aliquotPhotoInstance) {

        if (aliquotPhotoInstance == null) {
            notFound()
            return
        }

        aliquotPhotoInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'AliquotPhoto.label', default: 'AliquotPhoto'), aliquotPhotoInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'aliquotPhotoInstance.label', default: 'AliquotPhoto'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
