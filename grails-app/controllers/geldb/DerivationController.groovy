package geldb

import grails.converters.XML

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * DerivationController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class DerivationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Derivation.list(params), model: [derivationInstanceCount: Derivation.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Derivation.list(params), model: [derivationInstanceCount: Derivation.count()]
    }

    def show(Derivation derivationInstance) {
        respond derivationInstance
    }

    def create() {
		respond new Derivation(params), model: [aliquotType: params.aliquotType, aliquotVolumeMass: params.aliquotVolumeMass]
    }

    def getSlideID() {
        def parentAliquot = Aliquot.findById(params.parentAliquot)
        def aliquotType = AliquotType.findById(params.aliquotType)

        if(parentAliquot && aliquotType?.aliquotTypeName == 'Section'){
            if (parentAliquot.sapphireIdentifier){
                def lastSixDigit = parentAliquot.sapphireIdentifier.toString()[-6..-1]
                def gelIdList = parentAliquot.specimen.participant.studySubject.studySubjectIdentifier
                def gelId= ''
                for (int i = 0; i < gelIdList.size(); i ++){
                    if(gelIdList[i]){
                        gelId = gelIdList[i]
                    }
                }
                def slidID = gelId + ' ' + lastSixDigit
                render([slidID: slidID] as XML)
            }else{
                def barcode = parentAliquot?.barcode?.toString()
                def gelIdList = parentAliquot.specimen.participant.studySubject.studySubjectIdentifier
                def gelId= ''
                for (int i = 0; i < gelIdList.size(); i ++){
                    if(gelIdList[i]){
                        gelId = gelIdList[i]
                    }
                }
                if (barcode && gelId?.length() > 4){
                    def slidID = gelId[-4..-1] + ' ' + barcode
                    render([slidID: slidID] as XML)
                }
            }
        }else if ((parentAliquot && aliquotType?.aliquotTypeName == 'All Prep Lysate')) {
            def gelIdList = parentAliquot.specimen.participant.studySubject.studySubjectIdentifier
            def gelId = ''
            for (int i = 0; i < gelIdList.size(); i ++){
                if(gelIdList[i]){
                    gelId = gelIdList[i]
                }
            }
            gelId = gelId + '_'
            render([slidID: gelId] as XML)
        }
    }

    @Transactional
    def save(Derivation derivationInstance) {
        if (derivationInstance == null) {
            notFound()
            return
        }

        if (derivationInstance.hasErrors()) {
            respond derivationInstance.errors, view: 'create'
            return
        }

        def barcode = params.barcode
        def sapphireIdentifier = params.sapphireIdentifier
        if (barcode){
            def identifiedSample = IdentifiedSample.findByBarcode(barcode.toString())
            if (identifiedSample){
                flash.message = 'Barcode must be unique.'
                respond derivationInstance, view: 'create'
                return
            }
        }

        if (sapphireIdentifier){
            def identifiedSample = IdentifiedSample.findBySapphireIdentifier(sapphireIdentifier.toString())
            if (identifiedSample){
                flash.message = 'Slide Id/Identifier must be unique.'
                respond derivationInstance, view: 'create'
                return
            }
        }

        def getSpecimen = Specimen.where {
            aliquot.id == params.long('aliquot.id')
        }

        def derivedAliquot = new Aliquot(specimen: getSpecimen.get().id, exhausted: params.exhausted, barcode: barcode, aliquotVolumeMass: params.aliquotVolumeMass, unit: params.unit,
                aliquotType: params.aliquotType, sapphireIdentifier: sapphireIdentifier)

        derivationInstance.addToDerivedAliquots(derivedAliquot).save(flush: true)
        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'derivationInstance.label', default: 'Derivation'), derivationInstance.id])
                redirect(controller:'aliquot',action: 'show', params: [id: derivedAliquot.id])
            }
            '*' { respond derivationInstance, [status: CREATED] }
        }
    }

    def edit(Derivation derivationInstance) {
        respond derivationInstance
    }

    @Transactional
    def update(Derivation derivationInstance) {
        if (derivationInstance == null) {
            notFound()
            return
        }

        if (derivationInstance.hasErrors()) {
            respond derivationInstance.errors, view: 'edit'
            return
        }

        derivationInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Derivation.label', default: 'Derivation'), derivationInstance.id])
                redirect derivationInstance
            }
            '*' { respond derivationInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Derivation derivationInstance) {

        if (derivationInstance == null) {
            notFound()
            return
        }

        derivationInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Derivation.label', default: 'Derivation'), derivationInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'derivationInstance.label', default: 'Derivation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
