package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
/**
 * DNA_LibraryController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class DNA_LibraryController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DNA_Library.findAllByExhausted(false, params), model: [DNA_LibraryInstanceCount: DNA_Library.count()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [DNA_LibraryInstanceList: DNA_Library.findAllByExhausted(false, params), DNA_LibraryInstanceTotal: DNA_Library.count()]
    }
    def filterPaneService

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ DNA_LibraryInstanceList: filterPaneService.filter( params, DNA_Library ),
                                     DNA_LibraryInstanceTotal: filterPaneService.count( params, DNA_Library ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def findDNAExtractByGeLId() {
        def gelId= params.search
        if (gelId) {
            def participantByGeLId = Participant.createCriteria().get {
                studySubject {
                    eq('studySubjectIdentifier', gelId, [ignoreCase: true])
                }
            }
            if(participantByGeLId){

                participantByGeLId = participantByGeLId.id
                def listDNAExtractByGeLId = DNA_Extract.findAll{
                    aliquot.specimen.participant.id == participantByGeLId
                }
                listDNAExtractByGeLId = listDNAExtractByGeLId.findAll { a ->
                    !a.exhausted
                }
                listDNAExtractByGeLId = listDNAExtractByGeLId.findAll { a ->
                    a.aliquot.specimen.participant.id.first() == participantByGeLId
                }
                if (!listDNAExtractByGeLId.empty) {
                    render(template: "dnaExtractList", model: [listDNAExtractByGeLId: listDNAExtractByGeLId])
                }
            }
        }
    }

    def show(DNA_Library DNA_LibraryInstance) {
        respond DNA_LibraryInstance
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def create() {
        respond new DNA_Library(params)
    }

    @Transactional
    def save(DNA_Library DNA_LibraryInstance) {
        if (DNA_LibraryInstance == null) {
            notFound()
            return
        }

        if (DNA_LibraryInstance.hasErrors()) {
            respond DNA_LibraryInstance.errors, view: 'create'
            return
        }

        if (params.na_extract){
            DNA_LibraryInstance.save flush: true
            request.withFormat {
                form {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'DNA_LibraryInstance.label', default: 'DNA_Library'), DNA_LibraryInstance.id])
                    redirect DNA_LibraryInstance
                }
                '*' { respond DNA_LibraryInstance, [status: CREATED] }
            }
        }else {
            flash.message = "Please enter participant GeL ID, click Find DNA Extract button then select DNA Extract/DNA Extracts from the list."
            respond DNA_LibraryInstance, view: 'create'
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def edit(DNA_Library DNA_LibraryInstance) {
        respond DNA_LibraryInstance
    }

    @Transactional
    def update(DNA_Library DNA_LibraryInstance) {
        if (DNA_LibraryInstance == null) {
            notFound()
            return
        }

        if (DNA_LibraryInstance.hasErrors()) {
            respond DNA_LibraryInstance.errors, view: 'edit'
            return
        }

        if (params.na_extract) {
            DNA_LibraryInstance.save flush: true
            request.withFormat {
                form {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'DNA_Library.label', default: 'DNA_Library'), DNA_LibraryInstance.id])
                    redirect DNA_LibraryInstance
                }
                '*' { respond DNA_LibraryInstance, [status: OK] }
            }
        }else{
            flash.message = "Please enter participant GeL ID, click Find DNA Extract button then select DNA Extract/DNA Extracts from the list."
            respond DNA_LibraryInstance, view: 'create'
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    @Transactional
    def delete(DNA_Library DNA_LibraryInstance) {

        if (DNA_LibraryInstance == null) {
            notFound()
            return
        }

        DNA_LibraryInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DNA_Library.label', default: 'DNA_Library'), DNA_LibraryInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'DNA_LibraryInstance.label', default: 'DNA_Library'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
