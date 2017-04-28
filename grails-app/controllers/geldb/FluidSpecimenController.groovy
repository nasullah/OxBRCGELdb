package geldb

import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
/**
 * FluidSpecimenController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class FluidSpecimenController {

    def exportService
    def exportFluidSpecimenService
    def filterPaneService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond FluidSpecimen.findAllByExhausted(false, params), model: [fluidSpecimenInstanceCount: FluidSpecimen.findAllByExhausted(false).size()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [fluidSpecimenInstanceList: FluidSpecimen.findAllByExhausted(false, params), fluidSpecimenInstanceTotal: FluidSpecimen.findAllByExhausted(false).size()]
    }

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ fluidSpecimenInstanceList: filterPaneService.filter( params, FluidSpecimen ),
                                     fluidSpecimenInstanceTotal: filterPaneService.count( params, FluidSpecimen ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def findParticipantByGeLId() {
        def gelId= params.search
        if (gelId) {
            def participantByGeLId = Participant.createCriteria().get {
                studySubject {
                    eq('studySubjectIdentifier', gelId, [ignoreCase: true])
                }
            }
            if (participantByGeLId && gelId) {
                render(template: "participantList", model: [listParticipantByGeLId: participantByGeLId])
            }
        }
    }

    def listBloodFollowUp() {
        def results = Participant.createCriteria().listDistinct{
            specimen {
                and {
                    ge("fluidSpecimenVolume", Float.parseFloat("10"))
                    aliquot {
                        eq('aliquotType',AliquotType.findByAliquotTypeName('Plasma'))
                    }
                }
            }
        }
        [participantList: results.sort {it.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    @Secured(['ROLE_ADMIN'])
    def exportSpecimen(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= exportSpecimen.${params.extension}")

            List fields = ["id", "participant.studySubject.studySubjectIdentifier", "participant.studySubject.study", "participant.studySubject.consentFormNumber",
                           "participant.studySubject.consentStatus","participant.studySubject.recruitmentDate","participant.studySubject.recruitedBy",
                           "participant.studySubject.consentFormVersion", "participant.familyName", "participant.givenName", "participant.dateOfBirth",
                           "participant.gender", "participant.nHSNumber", "participant.hospitalNumber", "participant.diagnosis", "participant.centre",
                           "participant.solidSpecimenExpected", "primaryContainer", "fluidSpecimenVolume", "volumeUnit", "fluidSampleType", "timePoint",
                           "anatomicalSite", "collectionMethod", "methodOfTransportToPathologist", "surgeon", "pathologist", "specimenWeight", "massUnit",
                           "histologyNumber", "noFFSampleExpected", "numberOfBiopsies", "exhausted", "notes", "collectionDate", "collectionTime",
                           "collectionLocation", "collectedBy", "reference", "barcode", "fFPE_Tissue_Report.reportDate", "fFPE_Tissue_Report.reportStaff"
                           , "fFPE_Tissue_Report.comments", "fFPE_Tissue_Report.sampleType", "fFPE_Tissue_Report.stage", "fFPE_Tissue_Report.stagingSystem"
                           , "fFPE_Tissue_Report.tumourStatus", "fFPE_Tissue_Report.tumourType", "fFPE_Tissue_Report.cold_ischaemia", "fFPE_Tissue_Report.warm_ischaemia"
                           , "fFPE_Tissue_Report.cellPathReport", "fFPE_Tissue_Report.tissueWorksheet", "fFPE_Tissue_Report.cellPathMacroscopicReport",
                           "fFPE_Tissue_Report.cellPathMicroscopicReport", "fFPE_Tissue_Report.cellPathSummaryReport", "fFPE_Tissue_Report.cellPathSupplementaryReport",
                           "fFPE_Tissue_Report.snomed"]


            Map labels = ["primaryContainer":"specimen.primaryContainer", "fluidSpecimenVolume":"specimen.fluidSpecimenVolume", "volumeUnit":"specimen.volumeUnit",
                          "fluidSampleType":"specimen.fluidSampleType","timePoint":"specimen.timePoint","anatomicalSite":"specimen.anatomicalSite",
                          "collectionMethod":"specimen.collectionMethod", "methodOfTransportToPathologist":"specimen.methodOfTransportToPathologist",
                          "surgeon":"specimen.surgeon", "pathologist":"specimen.pathologist", "specimenWeight":"specimen.specimenWeight", "massUnit":"specimen.massUnit",
                          "histologyNumber":"specimen.histologyNumber", "noFFSampleExpected":"specimen.noFFSampleExpected", "numberOfBiopsies":"specimen.numberOfBiopsies",
                          "exhausted":"specimen.exhausted", "notes":"specimen.notes","collectionDate":"specimen.collectionDate", "collectionTime":"specimen.collectionTime",
                          "collectionLocation":"specimen.collectionLocation", "collectedBy":"specimen.collectionLocation", "reference":"specimen.reference",
                          "barcode":"specimen.barcode", "id":"specimen.id"]

            def specimenList = Specimen.list()
            // Formatter closure
            def gelID = { domain, value ->
                return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
            }

            def clean = { domain, value ->
                return value.toString().replace('[','').replace(']','').trim()
            }

            Map formatters = ["participant.studySubject.studySubjectIdentifier": gelID, "fFPE_Tissue_Report.reportDate": clean, "fFPE_Tissue_Report.reportStaff": clean
                              , "fFPE_Tissue_Report.comments": clean, "fFPE_Tissue_Report.sampleType": clean, "fFPE_Tissue_Report.stage": clean, "fFPE_Tissue_Report.stagingSystem": clean
                              , "fFPE_Tissue_Report.tumourStatus": clean, "fFPE_Tissue_Report.tumourType": clean, "fFPE_Tissue_Report.cold_ischaemia": clean, "fFPE_Tissue_Report.warm_ischaemia": clean
                              , "fFPE_Tissue_Report.cellPathReport": clean, "fFPE_Tissue_Report.tissueWorksheet": clean, "fFPE_Tissue_Report.cellPathMacroscopicReport": clean,
                              "fFPE_Tissue_Report.cellPathMicroscopicReport": clean, "fFPE_Tissue_Report.cellPathSummaryReport": clean, "fFPE_Tissue_Report.cellPathSupplementaryReport": clean,
                              "fFPE_Tissue_Report.snomed": clean, "participant.studySubject.study": clean, "participant.studySubject.consentFormNumber": clean,
                              "participant.studySubject.consentStatus": clean,"participant.studySubject.recruitmentDate": clean,"participant.studySubject.recruitedBy": clean,
                              "participant.studySubject.consentFormVersion": clean,]

            Map parameters = [title: "Participants", "column.widths": [0.2, 0.2, 0.2, 0.1]]
            exportService.export(params.format, response.outputStream, specimenList, fields, labels, formatters, parameters )
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportAliquot(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= exportAliquot.${params.extension}")

            List fields = ["id", "specimen.id", "exhausted", "notes", "blockNumber", "aliquotType", "barcode", "position","aliquotVolumeMass",
                           "unit", "sapphireIdentifier", "aliquotRanking", "createdOn", "frozenBy", "createdTime", "gelSuitabilityReport.reportDate"
                           , "gelSuitabilityReport.reportStaff", "gelSuitabilityReport.comments", "gelSuitabilityReport.handE_pathreview",
                           "gelSuitabilityReport.slideMarkedBy", "gelSuitabilityReport.sideMarkedDate"
                           , "gelSuitabilityReport.percentageTumourContent", "gelSuitabilityReport.tumourContentVerifiedBy",
                           "gelSuitabilityReport.tumourContentVerificationOther", "gelSuitabilityReport.microdissection", "gelSuitabilityReport.microdissectionDetails"
                           , "gelSuitabilityReport.cellularity", "gelSuitabilityReport.percentageNecrosis", "gelSuitabilityReport.dysplasticNonInvasiveElements"
                           , "gelSuitabilityReport.dysplasticNonInvasiveNotes", "gelSuitabilityReport.pathologistComments"
                           , "gelSuitabilityReport.suitableForGel", "gelSuitabilityReport.failureReason", "gelSuitabilityReport.slideScannedOn", "gelSuitabilityReport.slideScannedBy",
                           "gelSuitabilityReport.handEcarriedOutOn", "gelSuitabilityReport.handEcarriedOutBy", "fixationReport.reportDate", "fixationReport.reportStaff"
                           , "fixationReport.comments", "fixationReport.fixationTypeAliquot", "fixationReport.processingScheduleAliquot", "fixationReport.fixationStartDateAliquot",
                           "fixationReport.fixationStartTimeAliquot", "fixationReport.fixationEndDateAliquot", "fixationReport.fixationEndTimeAliquot", "fixationReport.fixationPeriodAliquot",
                           "fixationReport.fixationTimeUnknownAliquot", "fixationReport.fixationCommentsAliquot" , "fixationReport.tissueProcessorUsed", "fixationReport.timeInProcessor",
                           "sampleTrackingEvent", "dispatched"]


            Map labels = ["exhausted":"aliquot.exhausted", "notes":"aliquot.notes", "blockNumber":"aliquot.blockNumber", "aliquotType":"aliquot.aliquotType",
                          "barcode":"aliquot.barcode", "position":"aliquot.position","aliquotVolumeMass":"aliquot.aliquotVolumeMass", "id":"aliquot.id",
                          "unit":"aliquot.unit", "sapphireIdentifier":"aliquot.sapphireIdentifier", "aliquotRanking":"aliquot.aliquotRanking",
                          "createdOn":"aliquot.createdOn", "frozenBy":"aliquot.frozenBy", "createdTime":"aliquot.createdTime",
                          "fixationReport.fixationTypeAliquot":"fixationReport.fixationType", "fixationReport.processingScheduleAliquot":"fixationReport.processingSchedule",
                          "fixationReport.fixationStartDateAliquot":"fixationReport.fixationStartDate", "fixationReport.fixationStartTimeAliquot":"fixationReport.fixationStartTime",
                          "fixationReport.fixationEndDateAliquot":"fixationReport.fixationEndDate", "fixationReport.fixationEndTimeAliquot":"fixationReport.fixationEndTime",
                          "fixationReport.fixationPeriodAliquot":"fixationReport.fixationPeriod", "fixationReport.fixationTimeUnknownAliquot":"fixationReport.fixationTimeUnknown",
                          "fixationReport.fixationCommentsAliquot":"fixationReport.fixationComments"]

            def aliquotList = Aliquot.list()
            // Formatter closure
            def gelID = { domain, value ->
                return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
            }

            def clean = { domain, value ->
                return value.toString().replace('[','').replace(']','').trim()
            }

            def dispatched = { domain, value ->
                def dispatchItem = DispatchItem.findByIdentifiedSample(IdentifiedSample.findById(domain.id))
                if (dispatchItem){
                    return dispatchItem.dispatchedBox.dispatchRecord.consignmentNumber
                }else {
                    return  ""
                }
            }

            Map formatters = ["gelSuitabilityReport.reportDate":clean
                              , "gelSuitabilityReport.reportStaff":clean, "gelSuitabilityReport.comments":clean, "gelSuitabilityReport.handE_pathreview":clean,
                              "gelSuitabilityReport.slideMarkedBy":clean, "gelSuitabilityReport.sideMarkedDate":clean
                              , "gelSuitabilityReport.percentageTumourContent":clean, "gelSuitabilityReport.tumourContentVerifiedBy":clean,
                              "gelSuitabilityReport.tumourContentVerificationOther":clean, "gelSuitabilityReport.microdissection":clean, "gelSuitabilityReport.microdissectionDetails":clean
                              , "gelSuitabilityReport.cellularity":clean, "gelSuitabilityReport.percentageNecrosis":clean, "gelSuitabilityReport.dysplasticNonInvasiveElements":clean
                              , "gelSuitabilityReport.dysplasticNonInvasiveNotes":clean, "gelSuitabilityReport.pathologistComments":clean
                              , "gelSuitabilityReport.suitableForGel":clean, "gelSuitabilityReport.failureReason":clean, "gelSuitabilityReport.slideScannedOn":clean, "gelSuitabilityReport.slideScannedBy":clean,
                              "gelSuitabilityReport.handEcarriedOutOn":clean, "gelSuitabilityReport.handEcarriedOutBy":clean,
                              "fixationReport.fixationTypeAliquot":clean, "fixationReport.processingScheduleAliquot":clean,
                              "fixationReport.fixationStartDateAliquot":clean, "fixationReport.fixationStartTimeAliquot":clean,
                              "fixationReport.fixationEndDateAliquot":clean, "fixationReport.fixationEndTimeAliquot":clean,
                              "fixationReport.fixationPeriodAliquot":clean, "fixationReport.fixationTimeUnknownAliquot":clean,
                              "fixationReport.fixationCommentsAliquot":clean, "fixationReport.tissueProcessorUsed":clean, "fixationReport.timeInProcessor":clean,
                              "fixationReport.reportDate":clean, "fixationReport.reportStaff":clean, "fixationReport.comments":clean, "dispatched":dispatched,
                              "sampleTrackingEvent":clean]

            Map parameters = [title: "Participants", "column.widths": [0.2, 0.2, 0.2, 0.1]]
            exportService.export(params.format, response.outputStream, aliquotList, fields, labels, formatters, parameters )
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportDNA(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= exportDNA.${params.extension}")

            List fields = ["id", "aliquot.id", "exhausted", "passFail", "passFailReason", "notes", "barcode", "position",
                           "dNAConcentrationNanodrop", "dNAConcentrationQubit", "extractionDate", "extractedBy", "geLSampleIdentifier",
                           "sapphireIdentifier", "dNAAmount", "delatQC", "a260A280", "a260A230", "experimentName", "extractionKit",
                           "extractionType", "rin", "checked", "dispatched"]


            Map labels = ["id": "DNA_Extract.id", "exhausted":"DNA_Extract.exhausted", "passFail":"DNA_Extract.passFail", "passFailReason":"DNA_Extract.passFailReason",
                          "notes":"DNA_Extract.notes", "barcode": "DNA_Extract.barcode", "position":"DNA_Extract.position",
                          "dNAConcentrationNanodrop":"DNA_Extract.dNAConcentrationNanodrop", "dNAConcentrationQubit":"DNA_Extract.dNAConcentrationQubit",
                          "extractionDate":"DNA_Extract.extractionDate", "extractedBy":"DNA_Extract.extractedBy", "geLSampleIdentifier":"DNA_Extract.geLSampleIdentifier",
                          "sapphireIdentifier":"DNA_Extract.sapphireIdentifier", "dNAAmount":"DNA_Extract.dNAAmount", "delatQC":"DNA_Extract.deltaQC", "a260A280":"DNA_Extract.a260A280",
                          "a260A230":"DNA_Extract.a260A230", "experimentName": "DNA_Extract.experimentName", "extractionKit":"DNA_Extract.extractionKit",
                          "extractionType":"DNA_Extract.extractionType", "rin":"DNA_Extract.rin", "checked":"DNA_Extract.checked"]

            def dnaList = DNA_Extract.list()

            def clean = { domain, value ->
                return value.toString().replace('[','').replace(']','').trim()
            }

            def dispatched = { domain, value ->
                def dispatchItem = DispatchItem.findByIdentifiedSample(IdentifiedSample.findById(domain.id))
                if (dispatchItem){
                    return dispatchItem.dispatchedBox.dispatchRecord.consignmentNumber
                }else {
                    return  ""
                }
            }

            Map formatters = ["aliquot.id":clean, "dispatched":dispatched]

            Map parameters = [title: "Participants", "column.widths": [0.2, 0.2, 0.2, 0.1]]
            exportService.export(params.format, response.outputStream, dnaList, fields, labels, formatters, parameters )
        }
    }

    def awaitingBlood(){
        def results = Participant.list()
        results = results.findAll {participantInstance -> !FluidSpecimen.findByParticipant(participantInstance)}
        [participantList: results.sort {it.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def createMultiple(){
        List primaryContainerTypes = ["EDTA_GL", "EDTA_cfDNA", "Strek_cfDNA", "Strek_cfDNA", "Strek_cfDNA", "Oragene_kit_SALIVA_GL", "Vacutainer_potassium_EDTA_or_equivalent_PED"]
        respond new FluidSpecimen(params), model: [primaryContainerTypes: primaryContainerTypes]
    }

    @Transactional
    def saveMultiple() {
        def counter = 0
        for (int i = 0; i < PrimaryContainerType?.values()?.size(); i++){
            if (params.find{it.key.equals('primaryContainer_'+ i)}?.value && params.find{it.key.equals('fluidSpecimenVolume_'+ i)}?.value
                    && params.participant && params.collectionDate && params.collectedBy && params.collectionLocation && params.volumeUnit
                    && params.fluidSampleType){
                def fluidSpecimenVolume = params.find{it.key.equals('fluidSpecimenVolume_'+ i)}?.value
                def primaryContainer = params.find{it.key.equals('primaryContainer_'+ i)}?.value?.toString()
                def barcode = params.find{it.key.equals('barcode_'+ i)}?.value
                new FluidSpecimen(participant: params.participant, collectionDate: params.collectionDate, collectionTime: params.collectionTime,
                        collectionLocation: params.collectionLocation, collectedBy: params.collectedBy, primaryContainer: primaryContainer,
                        fluidSampleType: params.fluidSampleType, fluidSpecimenVolume: fluidSpecimenVolume , volumeUnit: params.volumeUnit,
                        barcode: barcode, timePoint: params.timePoint).save flush: true
                counter ++
            }
        }
        if (counter != 0){
            flash.message = "${counter} fluid specimen are created"
            redirect action: "index", method: "GET"
        } else {
            flash.message = "Fluid specimen could not be created"
            redirect action: "index", method: "GET"
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportFluidSpecimens(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported All FluidSpecimens.${params.extension}")
            def exportFluidSpecimensData = FluidSpecimen.list().sort {it.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
            exportService.export(params.format, response.outputStream, exportFluidSpecimensData, exportFluidSpecimenService.fields, exportFluidSpecimenService.labels, exportFluidSpecimenService.formatters, exportFluidSpecimenService.parameters)
        }
    }

    def show(FluidSpecimen fluidSpecimenInstance) {
        def listFluidSpecimenAuditLogData = AuditLogEvent.findAllByPersistedObjectId(fluidSpecimenInstance?.id)
        respond fluidSpecimenInstance, model: [listAuditLogData: listFluidSpecimenAuditLogData]
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def create() {
        respond new FluidSpecimen(params)
    }

    def fluidSpecimenSummary(){
        def summary = Participant.createCriteria().list {
            studySubject {
                eq("study", Study?.findByStudyName("100K Genomes Main Project"))
            }
        }
        summary = summary.sort {it.id}
        [summary: summary.reverse()]
    }

    @Transactional
    def save(FluidSpecimen fluidSpecimenInstance) {
        if (fluidSpecimenInstance == null) {
            notFound()
            return
        }

        if (fluidSpecimenInstance.hasErrors()) {
            respond fluidSpecimenInstance.errors, view: 'create'
            return
        }

        fluidSpecimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'fluidSpecimenInstance.label', default: 'FluidSpecimen'), fluidSpecimenInstance.id])
                redirect fluidSpecimenInstance
            }
            '*' { respond fluidSpecimenInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def edit(FluidSpecimen fluidSpecimenInstance) {
        respond fluidSpecimenInstance
    }

    @Transactional
    def update(FluidSpecimen fluidSpecimenInstance) {
        if (fluidSpecimenInstance == null) {
            notFound()
            return
        }

        if (fluidSpecimenInstance.hasErrors()) {
            respond fluidSpecimenInstance.errors, view: 'edit'
            return
        }

        fluidSpecimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FluidSpecimen.label', default: 'FluidSpecimen'), fluidSpecimenInstance.id])
                redirect fluidSpecimenInstance
            }
            '*' { respond fluidSpecimenInstance, [status: OK] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    @Transactional
    def delete(FluidSpecimen fluidSpecimenInstance) {

        if (fluidSpecimenInstance == null) {
            notFound()
            return
        }

        fluidSpecimenInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FluidSpecimen.label', default: 'FluidSpecimen'), fluidSpecimenInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'fluidSpecimenInstance.label', default: 'FluidSpecimen'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
