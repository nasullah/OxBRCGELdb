package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
/**
 * SolidSpecimenController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class SolidSpecimenController {

    def exportService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SolidSpecimen.findAllByExhausted(false, params), model: [solidSpecimenInstanceCount: SolidSpecimen.count()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [solidSpecimenInstanceList: SolidSpecimen.findAllByExhausted(false, params), solidSpecimenInstanceTotal: SolidSpecimen.count()]
    }
    def filterPaneService

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ solidSpecimenInstanceList: filterPaneService.filter( params, SolidSpecimen ),
                                     solidSpecimenInstanceTotal: filterPaneService.count( params, SolidSpecimen ),
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

    @Secured(['ROLE_ADMIN'])
    def exportSolidSpecimens(){

        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported All Main Specimens and Reports.${params.extension}")

            def exportSolidSpecimensData = SolidSpecimen.list().sort {it.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}

            def clean = { domain, value ->
                return value.toString().replace('[','').replace(']','').trim()
            }

            def cleanGelID = { domain, value ->
                return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
            }

            List fields = ["participant.studySubject.studySubjectIdentifier", "histologyNumber", "collectionMethod", "anatomicalSite", "barcode", "exhausted", "notes","collectionDate","collectionTime","collectionLocation","collectedBy","methodOfTransportToPathologist",
                           "surgeon", "pathologist", "specimenWeight", "massUnit", "fFPE_Tissue_Report.reportDate", "fFPE_Tissue_Report.reportStaff", "fFPE_Tissue_Report.comments", "fFPE_Tissue_Report.sampleType", "fFPE_Tissue_Report.stage",
                           "fFPE_Tissue_Report.stagingSystem", "fFPE_Tissue_Report.tumourStatus", "fFPE_Tissue_Report.tumourType", "fFPE_Tissue_Report.snomed.snomedCode", "fFPE_Tissue_Report.cold_ischaemia",
                           "fFPE_Tissue_Report.warm_ischaemia", "fFPE_Tissue_Report.cellPathReport", "fFPE_Tissue_Report.fixationType", "fFPE_Tissue_Report.processingSchedule", "fFPE_Tissue_Report.fixationStartDate", "fFPE_Tissue_Report.fixationStartTime",
                           "fFPE_Tissue_Report.fixationEndDate", "fFPE_Tissue_Report.fixationEndTime", "fFPE_Tissue_Report.fixationPeriod", "fFPE_Tissue_Report.fixationTimeUnknown", "fFPE_Tissue_Report.fixationComments", "fFPE_Tissue_Report.tissueWorksheet",
                           "fFPE_Tissue_Report.cellPathMacroscopicReport", "fFPE_Tissue_Report.cellPathMicroscopicReport", "fFPE_Tissue_Report.cellPathSummaryReport", "fFPE_Tissue_Report.cellPathSupplementaryReport"]

            Map labels = ["histologyNumber":"Histology Number", "collectionMethod":"Collection Method", "anatomicalSite":"Anatomical Site", "barcode":"Barcode", "exhausted":"Exhausted", "notes":"Notes", "collectionDate":"Collection Date", "collectionTime":"Collection Time",
                          "collectionLocation":"Collection Location", "collectedBy":"Collected By", "methodOfTransportToPathologist":"Method of Transport to Pathologist", "surgeon":"Surgeon", "pathologist":"Pathologist", "specimenWeight":"specimenWeight",
                          "massUnit":"Mass Unit", "fFPE_Tissue_Report.reportDate":"Report Date", "fFPE_Tissue_Report.reportStaff":"Report Staff", "fFPE_Tissue_Report.comments":"Comments", "fFPE_Tissue_Report.sampleType":"Sample Type", "fFPE_Tissue_Report.stage":"Stage",
                          "fFPE_Tissue_Report.stagingSystem":"Staging System", "fFPE_Tissue_Report.tumourStatus":"Tumour Status", "fFPE_Tissue_Report.tumourType":"Tumour Type", "fFPE_Tissue_Report.snomed.snomedCode":"Snomed Code",
                          "fFPE_Tissue_Report.cold_ischaemia":"Cold Ischaemia", "fFPE_Tissue_Report.warm_ischaemia":"Warm Ischaemia", "fFPE_Tissue_Report.cellPathReport":"Cell Path Report", "fFPE_Tissue_Report.fixationType":"Fixation Type", "fFPE_Tissue_Report.processingSchedule":"Processing Schedule",
                          "fFPE_Tissue_Report.fixationStartDate":"Fixation Start Date", "fFPE_Tissue_Report.fixationStartTime":"fixationStartTime", "fFPE_Tissue_Report.fixationEndDate":"Fixation End Date", "fFPE_Tissue_Report.fixationEndTime":"Fixation End Time",
                          "fFPE_Tissue_Report.fixationPeriod":"Fixation Period", "fFPE_Tissue_Report.fixationTimeUnknown":"Fixation Time Unknown", "fFPE_Tissue_Report.fixationComments":"Fixation Comments","fFPE_Tissue_Report.tissueWorksheet":"Tissue Worksheet",
                          "fFPE_Tissue_Report.cellPathMacroscopicReport":"Cell Path Macroscopic Report", "fFPE_Tissue_Report.cellPathMicroscopicReport":"Cell Path Microscopic Report", "fFPE_Tissue_Report.cellPathSummaryReport":"Cell Path Summary Report",
                          "fFPE_Tissue_Report.cellPathSupplementaryReport":"Cell Path Supplementary Report", "participant.studySubject.studySubjectIdentifier":"GEL Study ID"]

            Map parameters = [title: "Main Specimens and Reports", "column.widths": [0.2, 0.3, 0.5]]
            Map formatters = ["fFPE_Tissue_Report.reportDate":clean, "fFPE_Tissue_Report.reportStaff":clean, "fFPE_Tissue_Report.comments":clean, "fFPE_Tissue_Report.sampleType":clean, "fFPE_Tissue_Report.stage":clean,
                              "fFPE_Tissue_Report.stagingSystem":clean, "fFPE_Tissue_Report.tumourStatus":clean, "fFPE_Tissue_Report.tumourType":clean, "fFPE_Tissue_Report.snomed.snomedCode":clean,
                              "fFPE_Tissue_Report.cold_ischaemia":clean, "fFPE_Tissue_Report.warm_ischaemia":clean, "fFPE_Tissue_Report.cellPathReport":clean, "fFPE_Tissue_Report.fixationType":clean, "fFPE_Tissue_Report.processingSchedule":clean,
                              "fFPE_Tissue_Report.fixationStartDate":clean, "fFPE_Tissue_Report.fixationStartTime":clean, "fFPE_Tissue_Report.fixationEndDate":clean, "fFPE_Tissue_Report.fixationEndTime":clean,
                              "fFPE_Tissue_Report.fixationPeriod":clean, "fFPE_Tissue_Report.fixationTimeUnknown":clean, "fFPE_Tissue_Report.fixationComments":clean,"fFPE_Tissue_Report.tissueWorksheet":clean,
                              "fFPE_Tissue_Report.cellPathMacroscopicReport":clean, "fFPE_Tissue_Report.cellPathMicroscopicReport":clean, "fFPE_Tissue_Report.cellPathSummaryReport":clean,
                              "fFPE_Tissue_Report.cellPathSupplementaryReport":clean, "participant.studySubject.studySubjectIdentifier":cleanGelID]

            exportService.export(params.format, response.outputStream, exportSolidSpecimensData, fields, labels, formatters, parameters )
        }
    }

    def show(SolidSpecimen solidSpecimenInstance) {
        respond solidSpecimenInstance
    }

    def create() {
        respond new SolidSpecimen(params)
    }

    @Transactional
    def save(SolidSpecimen solidSpecimenInstance) {
        if (solidSpecimenInstance == null) {
            notFound()
            return
        }

        if (solidSpecimenInstance.hasErrors()) {
            respond solidSpecimenInstance.errors, view: 'create'
            return
        }

        solidSpecimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'solidSpecimenInstance.label', default: 'SolidSpecimen'), solidSpecimenInstance.id])
                redirect solidSpecimenInstance
            }
            '*' { respond solidSpecimenInstance, [status: CREATED] }
        }
    }

    def edit(SolidSpecimen solidSpecimenInstance) {
        respond solidSpecimenInstance
    }

    @Transactional
    def update(SolidSpecimen solidSpecimenInstance) {
        if (solidSpecimenInstance == null) {
            notFound()
            return
        }

        if (solidSpecimenInstance.hasErrors()) {
            respond solidSpecimenInstance.errors, view: 'edit'
            return
        }

        solidSpecimenInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SolidSpecimen.label', default: 'SolidSpecimen'), solidSpecimenInstance.id])
                redirect solidSpecimenInstance
            }
            '*' { respond solidSpecimenInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SolidSpecimen solidSpecimenInstance) {

        if (solidSpecimenInstance == null) {
            notFound()
            return
        }

        solidSpecimenInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SolidSpecimen.label', default: 'SolidSpecimen'), solidSpecimenInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'solidSpecimenInstance.label', default: 'SolidSpecimen'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
