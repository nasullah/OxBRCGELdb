package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * SamplePhotoController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Transactional(readOnly = true)
class SamplePhotoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SamplePhoto.list(params), model: [samplePhotoInstanceCount: SamplePhoto.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SamplePhoto.list(params), model: [samplePhotoInstanceCount: SamplePhoto.count()]
    }

    def show(SamplePhoto samplePhotoInstance) {
        respond samplePhotoInstance
    }

    def create() {
        respond new SamplePhoto(params)
    }

    @Transactional
    def save(SamplePhoto samplePhotoInstance) {
        if (samplePhotoInstance == null) {
            notFound()
            return
        }

        if (samplePhotoInstance.hasErrors()) {
            respond samplePhotoInstance.errors, view: 'create'
            return
        }

        samplePhotoInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'samplePhotoInstance.label', default: 'SamplePhoto'), samplePhotoInstance.id])
                redirect samplePhotoInstance
            }
            '*' { respond samplePhotoInstance, [status: CREATED] }
        }
    }

    def edit(SamplePhoto samplePhotoInstance) {
        respond samplePhotoInstance
    }

    @Transactional
    def update(SamplePhoto samplePhotoInstance) {
        if (samplePhotoInstance == null) {
            notFound()
            return
        }

        if (samplePhotoInstance.hasErrors()) {
            respond samplePhotoInstance.errors, view: 'edit'
            return
        }

        samplePhotoInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SamplePhoto.label', default: 'SamplePhoto'), samplePhotoInstance.id])
                redirect samplePhotoInstance
            }
            '*' { respond samplePhotoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SamplePhoto samplePhotoInstance) {

        if (samplePhotoInstance == null) {
            notFound()
            return
        }

        samplePhotoInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SamplePhoto.label', default: 'SamplePhoto'), samplePhotoInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'samplePhotoInstance.label', default: 'SamplePhoto'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
