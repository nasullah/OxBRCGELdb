package geldb

import grails.converters.*
import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * DispatchRecordController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
@Transactional(readOnly = true)
class DispatchRecordController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def exportService
    def grailsApplication  //inject GrailsApplication
    def sampleMetadataExportService
    def qcTestExportService
    def omicsSampleMetadataExportService
    def allDispatchedItemsService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DispatchRecord.list(params).sort {it.sentOn}.reverse(), model: [dispatchRecordInstanceCount: DispatchRecord.count()]
    }

    def qcTestExport (){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=GMC_to_GEL_QC_test.${params.extension}")
            def dispatchRecord = DispatchRecord.findById(params.long('dispatchRecord'))
            def dispatchItems = DispatchItem.findAll {dispatchedBox.dispatchRecord == dispatchRecord}
            dispatchItems = dispatchItems.findAll {DNA_Extract.findById(it.identifiedSample.id)}
            exportService.export(params.format, response.outputStream, dispatchItems, qcTestExportService.summaryQCFields, qcTestExportService.summaryQCLabels, qcTestExportService.summaryQCFormatters, qcTestExportService.summaryQCParameters )
            exportService.export(params.format, response.outputStream, dispatchItems, qcTestExportService.trineanOD260Fields, qcTestExportService.trineanOD260Labels, qcTestExportService.trineanOD260Formatters,qcTestExportService.trineanOD260Parameters )
            exportService.export(params.format, response.outputStream, dispatchItems, qcTestExportService.nanodropConcentrationFields, qcTestExportService.nanodropConcentrationLabels, qcTestExportService.nanodropConcentrationformatters,qcTestExportService.nanodropConcentrationParameters )
            exportService.export(params.format, response.outputStream, dispatchItems, qcTestExportService.qubitFields, qcTestExportService.qubitLabels, qcTestExportService.qubitFormatters,qcTestExportService.qubitParameters )
            def ffpeSamples = dispatchItems.findAll {ffpe -> ffpe.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')}
            exportService.export(params.format, response.outputStream, ffpeSamples, qcTestExportService.deltaCqFields, qcTestExportService.deltaCqLabels, qcTestExportService.deltaCqFormatters,qcTestExportService.deltaCqParameters )
        }
    }

    def sampleMetadataExport(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=GMC_GEL_Sample_Metadata_Cancer.${params.extension}")
            def dispatchRecord = DispatchRecord.findById(params.long('dispatchRecord'))
            def dnaSamples = DispatchItem.findAll {dispatchedBox.dispatchRecord == dispatchRecord}
            dnaSamples = dnaSamples.findAll {DNA_Extract.findById(it.identifiedSample.id)}
            def omicsSamples = DispatchItem.findAll {dispatchedBox.dispatchRecord == dispatchRecord}
            omicsSamples = omicsSamples.findAll {Aliquot.findById(it.identifiedSample.id)}
            exportService.export(params.format, response.outputStream, dnaSamples, sampleMetadataExportService.fields, sampleMetadataExportService.labels, sampleMetadataExportService.formatters, sampleMetadataExportService.parameters)
            exportService.export(params.format, response.outputStream, omicsSamples, omicsSampleMetadataExportService.fields, [:], omicsSampleMetadataExportService.formatters, omicsSampleMetadataExportService.parameters)
        }
    }

    def exportAllDispatchedItems(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= All Dispatched Item.${params.extension}")
            def allDispatchedItems = DispatchItem.list()
            exportService.export(params.format, response.outputStream, allDispatchedItems, allDispatchedItemsService.fields, allDispatchedItemsService.labels, allDispatchedItemsService.formatters, allDispatchedItemsService.parameters )
        }
    }

//    def cleanString (String s){
//        s = s?.replace('[','')?.replace(']','')?.replace('null','')?.replace(',','')?.trim()
//        return s
//    }
//
//    def test(){
//        if(params?.format && params.format != "html"){
//            response.contentType = grailsApplication.config.grails.mime.types[params.format]
//            response.setHeader("Content-disposition", "attachment; filename=GMC_GEL_Sample_Metadata_Cancer.${params.extension}")
//            def allDispatchedItems = DispatchItem.list()
//
//                def gelId = { domain, value ->
//                    return cleanString(value?.toString())
//                }
//
//                def tumourType = { domain, value ->
//                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
//                        return ''
//                    } else return cleanString(value?.toString())
//                }
//
//                def laboratoryID  = { domain, value ->
//                    return "698D0"
//                }
//
//                def clinicSampleType  = { domain, value ->
//                    if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy Frozen')) {
//                        return "DNA " + "FF Tumour"
//                    }else  if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')){
//                        return "DNA " + "FFPE Tumour"
//                    }else{
//                        return "DNA "+ value?.toString()?.replace('[','')?.replace(']','')
//                    }
//                }
//
//                def clinicID  = { domain, value ->
//                    return "RTH"
//                }
//
//                def extractionDate  = { domain, value ->
//                    return value?.toString()?.replace(' ', 'T')?.replace(']', '')?.replace('[', '')
//                }
//
//                def aliquotBarcode  = { domain, value ->
//                    return value?.toString()?.replace(']', '')?.replace('[', '')
//                }
//
//                def laboratorySampleID  = { domain, value ->
//                    def barcode = domain?.identifiedSample?.barcode
//                    return barcode?.toString()?.replace(']', '')?.replace('[', '')
//                }
//
//                def laboratoryMethod  = { domain, value ->
//                    return value?.toString()
//                }
//
//                def dispatchDate  = { domain, value ->
//                    def date = value?.toString()
//                    if(date){
//                        return date?.substring(0,10)
//                    }else{
//                        return ""
//                    }
//                }
//
////                def tumourContent  = { domain, value ->
////                    def content = value?.toString()?.replace('[','')?.replace(']','')?.replace('%','')?.trim()
////                    if (content){
////                        if (content?.toInteger() < 30){
////                            return "Low"
////                        }else if (content?.toInteger() > 50){
////                            return "High"
////                        }else if (content?.toInteger() > 29 && content?.toInteger() < 51){
////                            return "Medium"
////                        }
////                    }else{
////                        return ""
////                    }
////                }
//
//                def morphology = { domain, value ->
//                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
//                        return ''
//                    } else {
//                        def code = value?.findResult {it?.size() ? it : null}
//                        if(code){
//                            code = code?.toString()?.replace('[','')?.replace(']','')?.replace(' ','')
//                            def list = code?.toString()?.split(',')
//                            list = list?.findAll {s -> s?.startsWith('M')}
//                            return list?.toString()?.replace('[','')?.replace(']','')?.replace('M','')
//                        }
//                        return ''
//                    }
//                }
//
//                def provenance = { domain, value ->
//                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
//                        return ''
//                    }else if (value?.toString()?.contains('Resection')) {
//                        return 'surgical resection'
//                    } else {
//                        return cleanString(value?.toString())
//                    }
//                }
//
//                def nonInvasiveElements  = { domain, value ->
//                    def elements = value?.toString()?.replace('[','')?.replace(']','')
//                    if (elements){
//                        if (elements == 'true'){
//                            return "yes"
//                        }else {
//                            return "no"
//                        }
//                    }else{
//                        return ""
//                    }
//                }
//
//                def topography = { domain, value ->
//                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
//                        return ''
//                    } else {
//                        def code = value?.findResult {it?.size() ? it : null}
//                        if(code){
//                            code = code?.toString()?.replace('[','')?.replace(']','')?.replace(' ','')
//                            def list = code?.toString()?.split(',')
//                            list = list?.findAll{s -> s?.startsWith('T')}
//                            return list?.toString()?.replace('[','')?.replace(']','')?.replace('T','')
//                        }
//                        return ''
//                    }
//                }
//
//                def pathologistsComments = { domain, value ->
//                    def comments = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
//                    if (comments){
//                        return comments
//                    }else{
//                        return ""
//                    }
//                }
//
//                def sectionCutBy = { domain, value ->
//                    if(domain?.identifiedSample?.aliquot?.derivation?.derivedAliquots?.aliquotType?.aliquotTypeName?.toString()?.contains('Section')) {
//                        def parentAliquot = Aliquot.findByIdInList(domain?.identifiedSample?.aliquot?.id)
//                        def aliquots = Aliquot.findAll {derivedFrom.aliquot == parentAliquot}
//                        aliquots = aliquots.findAll {c -> c.aliquotType.aliquotTypeName == 'Section'}
//                        return aliquots.derivedFrom.derivedBy.staffName?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                    }else {
//                        return ""
//                    }
//                }
//
//                def macrodissectionDetails = { domain, value ->
//                    if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
//                        def details = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                        if (details) {
//                            return details
//                        } else {
//                            return ""
//                        }
//                    }else {
//                        return ""
//                    }
//                }
//
//                def sectionCutOn = { domain, value ->
//                    if(domain?.identifiedSample?.aliquot?.derivation?.derivedAliquots?.aliquotType?.aliquotTypeName?.toString()?.contains('Section')) {
//                        def parentAliquot = Aliquot.findByIdInList(domain?.identifiedSample?.aliquot?.id)
//                        def aliquots = Aliquot.findAll {derivedFrom.aliquot == parentAliquot}
//                        aliquots = aliquots.findAll {c -> c.aliquotType.aliquotTypeName == 'Section'}
//                        def date = aliquots.derivedFrom.derivationDate?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                        if (date) {
//                            return date?.substring(0, 10)
//                        } else {
//                            return ""
//                        }
//                    }else {
//                        return ""
//                    }
//                }
//
//                def sectionAssessedDate = { domain, value ->
//                    if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy Frozen')) {
//                        def date = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                        if (date) {
//                            return date?.substring(0, 10)
//                        } else {
//                            return ""
//                        }
//                    }else{
//                        return ""
//                    }
//                }
//
//                def macrodissection = { domain, value ->
//                    if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
//                        def macro = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                        if (macro) {
//                            if (macro == 'true') {
//                                return "yes"
//                            } else {
//                                return "no"
//                            }
//                        } else {
//                            return ""
//                        }
//                    }else {
//                        return ""
//                    }
//                }
//
//                def sectionAssessedBy = { domain, value ->
//                    if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy Frozen')) {
//                        value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                    }else{
//                        return ""
//                    }
//                }
//
//                def slideMarkedBy = { domain, value ->
//                    if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
//                        def markedBy = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                        if (markedBy){
//                            if (markedBy?.isNumber()){
//                                def staffMember = StaffMember?.get(markedBy?.toInteger())?.staffName
//                                return staffMember
//                            }else{
//                                markedBy
//                            }
//                        }
//                    }else{
//                        return ""
//                    }
//                }
//
//                def fixationStartDate = { domain, value ->
//                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
//                        return ''
//                    } else {
//                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
//                            def fixationStartTime = domain?.identifiedSample?.aliquot?.fixationReport?.fixationStartTimeAliquot
//                            fixationStartTime = fixationStartTime?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                            def startDate = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                            if (startDate && fixationStartTime) {
//                                return startDate?.substring(0, 10) + "T" + fixationStartTime + ":00"
//                            } else if (startDate && !fixationStartTime){
//                                return startDate?.substring(0, 10) + "T00:00:00"
//                            } else {
//                                return ""
//                            }
//                        }else{
//                            return ""
//                        }
//                    }
//                }
//
//                def fixationEndDate = { domain, value ->
//                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
//                        return ''
//                    } else {
//                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
//                            def fixationEndTime = domain?.identifiedSample?.aliquot?.fixationReport?.fixationEndTimeAliquot
//                            fixationEndTime = fixationEndTime?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                            def endDate = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                            if (endDate && fixationEndTime) {
//                                return endDate?.substring(0, 10) + "T" + fixationEndTime+ ":00"
//                            } else if (endDate && !fixationEndTime) {
//                                return endDate?.substring(0, 10) + "T00:00:00"
//                            }else {
//                                return ""
//                            }
//                        }else{
//                            return ""
//                        }
//                    }
//                }
//
//                def sideMarkedDate = { domain, value ->
//                    if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
//                        def markedDate = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                        if (markedDate) {
//                            return markedDate?.substring(0, 10)
//                        } else {
//                            return ""
//                        }
//                    }else{
//                        return ""
//                    }
//                }
//
//                def fixationType = { domain, value ->
//                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
//                        return ''
//                    } else {
//                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
//                            def type = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                            if (type) {
//                                return type
//                            } else {
//                                return ""
//                            }
//                        }else{
//                            return ""
//                        }
//                    }
//                }
//
//                def fixationComments = { domain, value ->
//                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
//                        return ''
//                    } else {
//                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
//                            def comments = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
//                            if (comments) {
//                                return comments
//                            } else {
//                                return ""
//                            }
//                        }else{
//                            return ""
//                        }
//                    }
//                }
//
//                def excisionMargin = { domain, value ->
//                    if(domain?.identifiedSample?.aliquot?.specimen?.toString()?.contains('[Fluid Specimen-')){
//                        return ''
//                    } else {
//                        return '99'
//                    }
//                }
//
//                def processingSchedule = { domain, value ->
//                    if (value.toString()?.startsWith('[Fluid Specimen-')) {
//                        return ''
//                    } else {
//                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')){
//                            def schedule = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
//                            if (schedule){
//                                return schedule?.toLowerCase()?.replace(' ','_')
//                            }else{
//                                return ""
//                            }
//                        }else{
//                            return ""
//                        }
//                    }
//                }
//
//                def volumeUl = { domain, value ->
//                    return value
//                }
//
//                def laboratoryRemainingVolumeBanked  = { domain, value ->
//                    if (domain?.identifiedSample?.aliquot?.specimen?.toString()?.startsWith('[Fluid Specimen-')) {
//                        return "0"
//                    }else{
//                        def elution = DNA_Extract?.findById(domain?.identifiedSample?.id)?.sapphireIdentifier
//                        if (elution){
//                            elution = elution?.toString() + '_Remaining'
//                            def remainingVolume = DNA_Extract?.findBySapphireIdentifier(elution)?.dNAAmount
//                            if (remainingVolume){
//                                return remainingVolume
//                            }
//                        }
//                    }
//                }
//
//                Map formatters = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : gelId,'clinicID':clinicID,"identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourStatus":tumourType,
//                                  "identifiedSample.extractionDate":extractionDate,"identifiedSample.aliquot.aliquotType": clinicSampleType, "identifiedSample.barcode":aliquotBarcode, "laboratoryID":laboratoryID,
//                                  "identifiedSample.extractionType":laboratoryMethod, "laboratoryRemainingVolumeBanked":laboratoryRemainingVolumeBanked, "dispatchedBox.dispatchRecord.sentOn":dispatchDate,
//                                  "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed.snomedCode" :morphology, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.sampleType":provenance,
//                                  "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed" :topography, "identifiedSample.aliquot.gelSuitabilityReport.microdissectionDetails":macrodissectionDetails,
//                                  "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot":fixationStartDate, "identifiedSample.aliquot.fixationReport.fixationTypeAliquot":fixationType,
//                                  "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot":fixationEndDate, "identifiedSample.aliquot.fixationReport.fixationCommentsAliquot":fixationComments,
//                                  "identifiedSample.aliquot.fixationReport.processingScheduleAliquot":processingSchedule, "volume_ul":volumeUl, "laboratorySampleID":laboratorySampleID, "Excision Margin":excisionMargin
//                ]
//
//                List fields = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier","clinicID","identifiedSample.barcode",
//                               "identifiedSample.aliquot.aliquotType", "identifiedSample.extractionDate","laboratoryID", "laboratorySampleID", "identifiedSample.extractionType",
//                               "volume_ul", "laboratoryRemainingVolumeBanked","dispatchedBox.dispatchRecord.sentOn", "dispatchedBox.dispatchRecord.consignmentNumber",
//                               "positionIfPlated", "dispatchedBox.barcode","identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourStatus", "Excision Margin", "Tumour Size",
//                               "Morphology (ICD)", "Morphology (Snomed RT)", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed.snomedCode",
//                               "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.sampleType","Pre-invasive Elements", "Topography (ICD)", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed",
//                               "Topography (SnomedRT)", "identifiedSample.aliquot.gelSuitabilityReport.microdissection", "identifiedSample.aliquot.gelSuitabilityReport.microdissectionDetails",
//                               "Snap Freezing Start DateTime", "identifiedSample.aliquot.fixationReport.fixationTypeAliquot", "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot",
//                               "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot", "identifiedSample.aliquot.fixationReport.fixationCommentsAliquot", "identifiedSample.aliquot.fixationReport.processingScheduleAliquot",
//                               "Time in formalin on processor", "Number of Biopsies", "Gauge of Biopsies", "DNA Extraction Protocol", "Prolonged Sample Storage", "Reason Sample Not Sent", "Tumour Sample Type",
//                               "Scroll Thickness", "Number of Scrolls", "Number of Sections", "Section Thickness", "Number of Blocks", "Core Diameter", "Number of Cores"
//                ]
//
//                Map labels= ["identifiedSample.barcode" : "Sample ID","identifiedSample.aliquot.aliquotType":"Clinic Sample Type","testResultTypeSummaryQC" : "Test Result Type",
//                             "identifiedSample.extractionDate":"Clinic Sample DateTime", "identifiedSample.passFail":"Test Result Value","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : "Participant ID",
//                             "clinicID" : "Clinic ID", "laboratoryID":"Laboratory ID", "laboratorySampleID":"Laboratory Sample ID", "identifiedSample.extractionType":"Laboratory Method",
//                             "volume_ul":"Laboratory Sample Volume", "laboratoryRemainingVolumeBanked":"Laboratory Remaining Volume Banked", "dispatchedBox.dispatchRecord.sentOn":"GMC Sample Dispatch Date",
//                             "dispatchedBox.dispatchRecord.consignmentNumber":"GMC Sample Consignment Number","positionIfPlated":"GMC Rack Well", "dispatchedBox.barcode":"GMC Rack ID",
//                             "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourStatus":"Tumour Type", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed.snomedCode":"Morphology (SnomedCT)",
//                             "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.sampleType":"Tissue Source", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed":"Topography (SnomedCT)",
//                             "identifiedSample.aliquot.gelSuitabilityReport.microdissectionDetails":"Macrodissection Details", "identifiedSample.aliquot.gelSuitabilityReport.microdissection":"Macrodissected",
//                             "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot":"Fixation End DateTime", "identifiedSample.aliquot.fixationReport.fixationTypeAliquot":"Type of Fixative",
//                             "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot":"Fixation Start DateTime", "identifiedSample.aliquot.fixationReport.fixationCommentsAliquot":"Fixation Comments",
//                             "identifiedSample.aliquot.fixationReport.processingScheduleAliquot":"Processing Schedule"
//                ]
//
//                Map parameters = [title: "GMC GEL Sample Metadata Cancer", "column.widths": [0.2, 0.2, 0.2]]
//
//            exportService.export(params.format, response.outputStream, allDispatchedItems, fields, labels, formatters, parameters)
//        }
//    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DispatchRecord.list(params).sort {it.sentOn}.reverse(), model: [dispatchRecordInstanceCount: DispatchRecord.count()]

    }

    def show(DispatchRecord dispatchRecordInstance) {
        respond dispatchRecordInstance
    }

    def create() {
        respond new DispatchRecord(params)
    }

    def findDestination() {
        def destination = Destination.findById(params.destinationId)
        if(destination){
            render destination as XML
        }
    }

    @Transactional
    def save(DispatchRecord dispatchRecordInstance) {
        if (dispatchRecordInstance == null) {
            notFound()
            return
        }

        if (dispatchRecordInstance.hasErrors()) {
            respond dispatchRecordInstance.errors, view: 'create'
            return
        }

        dispatchRecordInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'dispatchRecordInstance.label', default: 'DispatchRecord'), dispatchRecordInstance.id])
                redirect dispatchRecordInstance
            }
            '*' { respond dispatchRecordInstance, [status: CREATED] }
        }
    }

    def edit(DispatchRecord dispatchRecordInstance) {
        respond dispatchRecordInstance
    }

    @Transactional
    def update(DispatchRecord dispatchRecordInstance) {
        if (dispatchRecordInstance == null) {
            notFound()
            return
        }

        if (dispatchRecordInstance.hasErrors()) {
            respond dispatchRecordInstance.errors, view: 'edit'
            return
        }

        dispatchRecordInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DispatchRecord.label', default: 'DispatchRecord'), dispatchRecordInstance.id])
                redirect dispatchRecordInstance
            }
            '*' { respond dispatchRecordInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(DispatchRecord dispatchRecordInstance) {

        if (dispatchRecordInstance == null) {
            notFound()
            return
        }

        dispatchRecordInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DispatchRecord.label', default: 'DispatchRecord'), dispatchRecordInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'dispatchRecordInstance.label', default: 'DispatchRecord'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
