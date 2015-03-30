package geldb

import org.hibernate.SessionFactory
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.MultipartRequest

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
/**
 * AliquotController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class AliquotController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Aliquot.findAllByExhausted(false, params), model: [aliquotInstanceCount: Aliquot.count()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [aliquotInstanceList: Aliquot.findAllByExhausted(false, params), aliquotInstanceTotal: Aliquot.count()]
    }
    def filterPaneService

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ aliquotInstanceList: filterPaneService.filter( params, Aliquot ),
                                     aliquotInstanceTotal: filterPaneService.count( params, Aliquot ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def findSpecimenByGeLId() {
        def gelId= params.search
        if (gelId) {
            def participantByGeLId = Participant.createCriteria().get {
                studySubject {
                    eq('studySubjectIdentifier', gelId)
                }
            }
            if(participantByGeLId){
                participantByGeLId = participantByGeLId.id
                def listSpecimenByGeLId = Specimen.findAll {
                    participant.id == participantByGeLId
                }
                listSpecimenByGeLId = listSpecimenByGeLId.findAll { a ->
                    !a.exhausted
                }
                if (!listSpecimenByGeLId.empty) {
                    render(template: "specimenList", model: [listSpecimenByGeLId: listSpecimenByGeLId])
                }
            }
        }
    }

    def exhaustSpecimen() {
        def fluidSpecimen = FluidSpecimen.get(params.long('selectedSpecimen'))
        if (fluidSpecimen?.fluidSampleType?.value == 'Blood whole BLD'){
            render(template: "exhaustSpecimen")
        }
    }

    def show(Aliquot aliquotInstance) {
        respond aliquotInstance
    }

    def create() {
        respond new Aliquot(params)
    }

//    def download(long id) {
//        Aliquot aliquotInstance = Aliquot.get(id)
//        if ( aliquotInstance == null) {
//            flash.message = "Aliquot not found."
//            redirect (action:'index')
//        } else {
//            response.setContentType("APPLICATION/OCTET-STREAM")
//            response.setHeader("Content-Disposition", "Attachment;Filename=\"${aliquotInstance.aliquotPhotograph}\"")
//
//            def file = new File(aliquotInstance.aliquotPhotograph)
//            def fileInputStream = new FileInputStream(file)
//            def outputStream = response.getOutputStream()
//
//            byte[] buffer = new byte[4096];
//            int len;
//            while ((len = fileInputStream.read(buffer)) > 0) {
//                outputStream.write(buffer, 0, len);
//            }
//
//            outputStream.flush()
//            outputStream.close()
//            fileInputStream.close()
//        }
//    }

    @Transactional
    def save(Aliquot aliquotInstance) {

        if (aliquotInstance == null) {
            notFound()
            return
        }

        if (aliquotInstance.hasErrors()) {
            respond aliquotInstance.errors, view: 'create'
            return
        }

        aliquotInstance.save flush: true

//        def file = request.getFile('photographFile')
//        if (file.originalFilename){
//            if (file?.empty) {
//                flash.message = "File cannot be empty"
//                respond aliquotInstance, view: 'create'
//                return
//            }
//            aliquotInstance.aliquotPhotograph = grailsApplication.config.uploadFolder +
//                    aliquotInstance.specimen.participant.studySubject.studySubjectIdentifier.findResult {it.size() ? it : null}.toString() +
//                    '.Aliquot ID.' + aliquotInstance.id.toString()
//            file.transferTo(new File(aliquotInstance.aliquotPhotograph))
//            aliquotInstance.save flush: true
//        }

        def exhaustBlood = params.exhaustBlood
        if (exhaustBlood == 'True'){
            aliquotInstance.specimen.exhausted = true
            aliquotInstance.specimen.save flush: true
        }
        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'Aliquot.label', default: 'Aliquot'), aliquotInstance.id])

            }
            '*' { respond aliquotInstance, [status: CREATED] }
        }
        redirect aliquotInstance
    }

    @Transactional
    def saveDuplicates() {
        def aliquotInstance = new Aliquot(params)
        if (aliquotInstance == null) {
            notFound()
            return
        }

        if (aliquotInstance.hasErrors()) {
            respond aliquotInstance.errors, view: 'create'
            return
        }
        aliquotInstance.save(flush: true)
        flash.message = "This is the newly created duplicate Aliquot with id ${aliquotInstance.id}"
        redirect aliquotInstance
    }

    def edit(Aliquot aliquotInstance) {
        respond aliquotInstance
    }

    @Transactional
    def update(Aliquot aliquotInstance) {
        if (aliquotInstance == null) {
            notFound()
            return
        }

        if (aliquotInstance.hasErrors()) {
            respond aliquotInstance.errors, view: 'edit'
            return
        }

        if (aliquotInstance?.derivedFrom?.id != null){
            def derivationInstance = Derivation.get(aliquotInstance?.derivedFrom?.id)
            def getStaffMember = StaffMember.get(params.long('derivedBy.id'))

            derivationInstance.aliquot.id           = params.long('aliquot.id')
            derivationInstance.derivationProcess    = params.derivationProcess
            derivationInstance.derivationDate       = new Date().parse("yyyy-MM-dd", params.derivationDate)
            derivationInstance.derivationTime       = params.derivationTime
            derivationInstance.derivedBy            = getStaffMember

            derivationInstance.addToDerivedAliquots(aliquotInstance).save(flush: true)
            request.withFormat {
                form {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'derivationInstance.label', default: 'Derivation'), derivationInstance.id])
                redirect aliquotInstance
                }
                '*' { respond derivationInstance, [status: CREATED] }
            }
        } else {
            aliquotInstance.save flush: true
            def exhaustBlood = params.exhaustBlood
            if (exhaustBlood == 'True'){
                aliquotInstance.specimen.exhausted = true
                aliquotInstance.specimen.save flush: true
            }

            request.withFormat {
                form {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'Aliquot.label', default: 'Aliquot'), aliquotInstance.id])
                    redirect aliquotInstance
                }
                '*' { respond aliquotInstance, [status: OK] }
            }
        }
    }

    @Transactional
    def delete(Aliquot aliquotInstance) {

        if (aliquotInstance == null) {
            notFound()
            return
        }

        aliquotInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Aliquot.label', default: 'Aliquot'), aliquotInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'aliquotInstance.label', default: 'Aliquot'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
