package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * AnatomicalSiteController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class AnatomicalSiteController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AnatomicalSite.list(params), model: [anatomicalSiteInstanceCount: AnatomicalSite.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AnatomicalSite.list(params), model: [anatomicalSiteInstanceCount: AnatomicalSite.count()]
    }

    def show(AnatomicalSite anatomicalSiteInstance) {
        respond anatomicalSiteInstance
    }

    def create() {
        respond new AnatomicalSite(params)
    }

    @Transactional
    def save(AnatomicalSite anatomicalSiteInstance) {
        if (anatomicalSiteInstance == null) {
            notFound()
            return
        }

        if (anatomicalSiteInstance.hasErrors()) {
            respond anatomicalSiteInstance.errors, view: 'create'
            return
        }

        anatomicalSiteInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'anatomicalSiteInstance.label', default: 'AnatomicalSite'), anatomicalSiteInstance.id])
                redirect anatomicalSiteInstance
            }
            '*' { respond anatomicalSiteInstance, [status: CREATED] }
        }
    }

    def edit(AnatomicalSite anatomicalSiteInstance) {
        respond anatomicalSiteInstance
    }

    @Transactional
    def update(AnatomicalSite anatomicalSiteInstance) {
        if (anatomicalSiteInstance == null) {
            notFound()
            return
        }

        if (anatomicalSiteInstance.hasErrors()) {
            respond anatomicalSiteInstance.errors, view: 'edit'
            return
        }

        anatomicalSiteInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'AnatomicalSite.label', default: 'AnatomicalSite'), anatomicalSiteInstance.id])
                redirect anatomicalSiteInstance
            }
            '*' { respond anatomicalSiteInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(AnatomicalSite anatomicalSiteInstance) {

        if (anatomicalSiteInstance == null) {
            notFound()
            return
        }

        anatomicalSiteInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'AnatomicalSite.label', default: 'AnatomicalSite'), anatomicalSiteInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'anatomicalSiteInstance.label', default: 'AnatomicalSite'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
