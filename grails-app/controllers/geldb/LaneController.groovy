package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * LaneController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class LaneController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Lane.list(params), model: [laneInstanceCount: Lane.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Lane.list(params), model: [laneInstanceCount: Lane.count()]
    }

    def show(Lane laneInstance) {
        respond laneInstance
    }

    def findDNALibraryByGeLId() {
        def gelId= params.search
        if (gelId) {
            def participantByGeLId = Participant.createCriteria().get {
                studySubject {
                    eq('studySubjectIdentifier', gelId)
                }
            }
            if(participantByGeLId){
                participantByGeLId = participantByGeLId.id
                def listDNALibraryByGeLId = DNA_Library.findAll {
                    na_extract.aliquot.specimen.participant.id == participantByGeLId
                }
                listDNALibraryByGeLId = listDNALibraryByGeLId.findAll{ l ->
                    !l.exhausted
                }
                listDNALibraryByGeLId = listDNALibraryByGeLId.findAll{ l ->
                    l.na_extract.aliquot.specimen.participant.id.first().first() == participantByGeLId
                }
                if (!listDNALibraryByGeLId.empty) {
                    render(template: "listDNALibraryList", model: [listDNALibraryByGeLId: listDNALibraryByGeLId])
                }
            }
        }
    }

    def create() {
        respond new Lane(params)
    }

    @Transactional
    def save(Lane laneInstance) {
        if (laneInstance == null) {
            notFound()
            return
        }

        if (laneInstance.hasErrors()) {
            respond laneInstance.errors, view: 'create'
            return
        }

        if (params.loadedLibrary){
            laneInstance.save flush: true
            request.withFormat {
                form {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'laneInstance.label', default: 'Lane'), laneInstance.id])
                    redirect laneInstance
                }
                '*' { respond laneInstance, [status: CREATED] }
            }
        } else {
            flash.message = "Please enter participant GeL ID, click Find DNA Library button then select DNA Library/DNA Libraries from the list."
            respond laneInstance, view: 'create'
        }

    }

    def edit(Lane laneInstance) {
        respond laneInstance
    }

    @Transactional
    def update(Lane laneInstance) {
        if (laneInstance == null) {
            notFound()
            return
        }

        if (laneInstance.hasErrors()) {
            respond laneInstance.errors, view: 'edit'
            return
        }

        if (params.loadedLibrary) {
            laneInstance.save flush: true
            request.withFormat {
                form {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'Lane.label', default: 'Lane'), laneInstance.id])
                    //redirect laneInstance
                    redirect(controller: 'flowCell', action: 'show', params: [id: laneInstance.flowCell.id])
                }
                '*' { respond laneInstance, [status: OK] }
            }
        }else{
            flash.message = "Please enter participant GeL ID, click Find DNA Library button then select DNA Library/DNA Libraries from the list."
            respond laneInstance, view: 'create'
        }
    }

    @Transactional
    def delete(Lane laneInstance) {

        if (laneInstance == null) {
            notFound()
            return
        }

        laneInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Lane.label', default: 'Lane'), laneInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'laneInstance.label', default: 'Lane'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
