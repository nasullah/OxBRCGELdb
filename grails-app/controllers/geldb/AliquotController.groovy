package geldb

import grails.converters.*
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

    def exportService

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
                    eq('studySubjectIdentifier', gelId, [ignoreCase: true])
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

    def preFillCreatedOn() {
        def createdOn = FluidSpecimen.get(params.long('specimenId'))?.collectionDate
        if (createdOn){
            render createdOn as XML
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportAliquots(){

        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported All Aliquots.${params.extension}")

            def exportAliquotsData = Aliquot.list().sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}

            def cleanGelID = { domain, value ->
                return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
            }

            def clean = { domain, value ->
                return value.toString().replace('[','').replace(']','').trim()
            }

            List fields = ["specimen.participant.studySubject.studySubjectIdentifier", "specimen", "derivedFrom.aliquot", "derivedFrom.derivationDate", "derivedFrom.derivedBy", "derivedFrom.derivationProcess", "sapphireIdentifier",
                           "blockNumber", "aliquotType", "barcode", "exhausted", "notes","aliquotRanking","createdOn","frozenBy","aliquotVolumeMass","unit", "position",
                           "gelSuitabilityReport.reportDate", "gelSuitabilityReport.reportStaff", "gelSuitabilityReport.comments", "gelSuitabilityReport.handE_pathreview",
                           "gelSuitabilityReport.slideMarkedBy", "gelSuitabilityReport.sideMarkedDate", "gelSuitabilityReport.percentageTumourContent",
                           "gelSuitabilityReport.tumourContentVerifiedBy", "gelSuitabilityReport.tumourContentVerificationOther", "gelSuitabilityReport.microdissection",
                           "gelSuitabilityReport.microdissectionDetails", "gelSuitabilityReport.cellularity", "gelSuitabilityReport.percentageNecrosis",
                           "gelSuitabilityReport.dysplasticNonInvasiveElements", "gelSuitabilityReport.dysplasticNonInvasiveNotes", "gelSuitabilityReport.pathologistComments",
                           "gelSuitabilityReport.suitableForGel", "gelSuitabilityReport.failureReason", "gelSuitabilityReport.slideScannedOn", "gelSuitabilityReport.slideScannedBy",
                           "gelSuitabilityReport.handEcarriedOutOn", "gelSuitabilityReport.handEcarriedOutBy"]

            Map labels = ["specimen":"Specimen", "derivedFrom.aliquot":"Parent Aliquot", "derivedFrom.derivationDate":"Derivation Date", "derivedFrom.derivedBy":"Derived By", "derivedFrom.derivationProcess":"Derivation Process", "sapphireIdentifier":"Biobanking Identifier",
                          "blockNumber":"Block Number", "barcode":"Barcode", "aliquotType":"Aliquot Type", "exhausted":"Exhausted", "notes":"Notes", "aliquotRanking":"Aliquot Ranking", "createdOn":"Created on",
                          "frozenBy":"Frozen By", "aliquotVolumeMass":"Aliquot Volume Mass", "unit":"Unit", "position":"Position","gelSuitabilityReport.reportDate":"Report Date",
                          "gelSuitabilityReport.reportStaff":"Report Staff", "gelSuitabilityReport.comments":"Comments", "gelSuitabilityReport.handE_pathreview":"H & E path review",
                          "gelSuitabilityReport.slideMarkedBy":"Slide Marked By", "gelSuitabilityReport.sideMarkedDate":"Slide Marked Date", "gelSuitabilityReport.percentageTumourContent":"Percentage Tumour Content",
                          "gelSuitabilityReport.tumourContentVerifiedBy":"Tumour Content Verified By", "gelSuitabilityReport.tumourContentVerificationOther":"Tumour Content Verification Other",
                          "gelSuitabilityReport.microdissection":"Micro dissection", "gelSuitabilityReport.microdissectionDetails":"Micro dissection Details", "gelSuitabilityReport.cellularity":"Cellularity",
                          "gelSuitabilityReport.percentageNecrosis":"Percentage Necrosis", "gelSuitabilityReport.dysplasticNonInvasiveElements":"Dysplastic Non Invasive Elements",
                          "gelSuitabilityReport.dysplasticNonInvasiveNotes":"Dysplastic Non Invasive Notes", "gelSuitabilityReport.pathologistComments":"Pathologist Comments",
                          "gelSuitabilityReport.suitableForGel":"Suitable For Gel", "gelSuitabilityReport.failureReason":"Failure Reason", "gelSuitabilityReport.slideScannedOn":"Slide Scanned On",
                          "gelSuitabilityReport.slideScannedBy":"Slide Scanned By", "gelSuitabilityReport.handEcarriedOutOn":"H & E Carried Out On", "gelSuitabilityReport.handEcarriedOutBy":"H & E carried Out By",
                          "specimen.participant.studySubject.studySubjectIdentifier":"GeL Study ID"]

            Map parameters = [title: "Aliquots", "column.widths": [0.2, 0.3, 0.5]]

            Map formatters = ["gelSuitabilityReport.reportDate":clean, "gelSuitabilityReport.reportStaff":clean, "gelSuitabilityReport.comments":clean, "gelSuitabilityReport.handE_pathreview":clean,
                              "gelSuitabilityReport.slideMarkedBy":clean, "gelSuitabilityReport.sideMarkedDate":clean, "gelSuitabilityReport.percentageTumourContent":clean,
                              "gelSuitabilityReport.tumourContentVerifiedBy":clean, "gelSuitabilityReport.tumourContentVerificationOther":clean,
                              "gelSuitabilityReport.microdissection":clean, "gelSuitabilityReport.microdissectionDetails":clean, "gelSuitabilityReport.cellularity":clean,
                              "gelSuitabilityReport.percentageNecrosis":clean, "gelSuitabilityReport.dysplasticNonInvasiveElements":clean,
                              "gelSuitabilityReport.dysplasticNonInvasiveNotes":clean, "gelSuitabilityReport.pathologistComments":clean,
                              "gelSuitabilityReport.suitableForGel":clean, "gelSuitabilityReport.failureReason":clean, "gelSuitabilityReport.slideScannedOn":clean,
                              "gelSuitabilityReport.slideScannedBy":clean, "gelSuitabilityReport.handEcarriedOutOn":clean, "gelSuitabilityReport.handEcarriedOutBy":clean,
                              "specimen.participant.studySubject.studySubjectIdentifier":cleanGelID]

            exportService.export(params.format, response.outputStream, exportAliquotsData, fields, labels, formatters, parameters )
        }
    }


    @Secured(['ROLE_ADMIN'])
    def exportListOfMaterialSupplied(){
        def listOfGelIDs = params.gelIdList
        if (listOfGelIDs) {
            if (params?.format && params.format != "html") {
                response.contentType = grailsApplication.config.grails.mime.types[params.format]
                response.setHeader("Content-disposition", "attachment; filename= Exported Material Supplied.${params.extension}")
                listOfGelIDs = listOfGelIDs.replaceAll("\\s+", "")
                List list = listOfGelIDs.toString().split(',')
                def exportListOfMaterialSuppliedData = Aliquot.list().sort {
                    it.specimen.participant.studySubject.studySubjectIdentifier.findResult { it?.size() ? it : null }
                }
                exportListOfMaterialSuppliedData = exportListOfMaterialSuppliedData.findAll { a ->
                    a.specimen.participant.studySubject.studySubjectIdentifier.findResult {
                        it?.size() ? it : null
                    } in list
                }

                def gelId = { domain, value ->
                    return value.toString().replace('[', '').replace(']', '').replace('null', '').replace(',', '')
                }

                def anatomicalSite = { domain, value ->
                    if (value.toString().startsWith('Fluid Specimen-')) {
                        return ''
                    } else return value
                }

                List fields = ["specimen.participant.studySubject.studySubjectIdentifier", "specimen.anatomicalSite", "aliquotType", "blockNumber",
                               "aliquotRanking", "aliquotVolumeMass", "unit"]
                Map labels = ["specimen.participant.studySubject.studySubjectIdentifier": "GEL Study ID", "specimen.anatomicalSite": "Anatomical Site",
                              "aliquotType"                                             : "Aliquot Type", "blockNumber": "Block Number", "aliquotRanking": "Aliquot Ranking", "aliquotVolumeMass": "Mass",
                              "unit"                                                    : "Unit"]
                Map parameters = [title: "Exported Material Supplied", "column.widths": [0.2, 0.3, 0.5]]
                Map formatters = ["specimen.participant.studySubject.studySubjectIdentifier": gelId, "specimen.anatomicalSite": anatomicalSite]

                exportService.export(params.format, response.outputStream, exportListOfMaterialSuppliedData, fields, labels, formatters, parameters)
            }
        }else {
            flash.message = "Enter one or more GeL IDs separated by comma."
            redirect(uri: "/participant/summaryReport")
        }

    }

    def show(Aliquot aliquotInstance) {
        respond aliquotInstance
    }

    def create() {
        respond new Aliquot(params)
    }

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

//    @Transactional
//    def saveDuplicates() {
//        def aliquotInstance = new Aliquot(params)
//        if (aliquotInstance == null) {
//            notFound()
//            return
//        }
//
//        if (aliquotInstance.hasErrors()) {
//            respond aliquotInstance.errors, view: 'create'
//            return
//        }
//        aliquotInstance.save(flush: true)
//        flash.message = "This is the newly created duplicate Aliquot with id ${aliquotInstance.id}"
//        redirect aliquotInstance
//    }

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
