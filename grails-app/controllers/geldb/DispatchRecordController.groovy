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

    def cleanString (String s){
        s = s?.replace('[','')?.replace(']','')?.replace('null','')?.replace(',','')?.trim()
        return s
    }

    def test(){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=GMC_GEL_Sample_Metadata_Cancer.${params.extension}")
            def allDispatchedItems = DispatchItem.list()

                def gelId = { domain, value ->
                    return cleanString(value?.toString())
                }

                def tumourType = { domain, value ->
                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                        return ''
                    } else return cleanString(value?.toString())
                }

                def laboratoryID  = { domain, value ->
                    return "698D0"
                }

                def clinicSampleType  = { domain, value ->
                    if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy Frozen')) {
                        return "DNA " + "FF Tumour"
                    }else  if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')){
                        return "DNA " + "FFPE Tumour"
                    }else{
                        return "DNA "+ value?.toString()?.replace('[','')?.replace(']','')
                    }
                }

                def clinicID  = { domain, value ->
                    return "RTH"
                }

                def extractionDate  = { domain, value ->
                    return value?.toString()?.replace(' ', 'T')?.replace(']', '')?.replace('[', '')
                }

                def aliquotBarcode  = { domain, value ->
                    return value?.toString()?.replace(']', '')?.replace('[', '')
                }

                def laboratorySampleID  = { domain, value ->
                    def barcode = domain?.identifiedSample?.barcode
                    return barcode?.toString()?.replace(']', '')?.replace('[', '')
                }

                def laboratoryMethod  = { domain, value ->
                    return "v2"
                }

                def dispatchDate  = { domain, value ->
                    def date = value?.toString()
                    if(date){
                        return date?.substring(0,10) + "T00:00:00"
                    }else{
                        return ""
                    }
                }

                def morphology = { domain, value ->
                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                        return ''
                    } else {
                        def code = value?.findResult {it?.size() ? it : null}
                        if(code){
                            code = code?.toString()?.replace('[','')?.replace(']','')?.replace(' ','')
                            def list = code?.toString()?.split(',')
                            list = list?.findAll {s -> s?.startsWith('M')}
                            return list?.toString()?.replace('[','')?.replace(']','')?.replace('M','')
                        }
                        return ''
                    }
                }

                def provenance = { domain, value ->
                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                        return ''
                    }else if (value?.toString()?.contains('Resection')) {
                        return 'surgical resection'
                    } else {
                        return cleanString(value?.toString())
                    }
                }

                def topography = { domain, value ->
                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                        return ''
                    } else {
                        def code = value?.findResult {it?.size() ? it : null}
                        if(code){
                            code = code?.toString()?.replace('[','')?.replace(']','')?.replace(' ','')
                            def list = code?.toString()?.split(',')
                            list = list?.findAll{s -> s?.startsWith('T')}
                            return list?.toString()?.replace('[','')?.replace(']','')?.replace('T','')
                        }
                        return ''
                    }
                }

                def macrodissection = { domain, value ->
                    if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                        def macro = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                        if (macro) {
                            if (macro == 'true') {
                                return "yes"
                            } else {
                                return "no"
                            }
                        } else {
                            return ""
                        }
                    }else {
                        return ""
                    }
                }

                def macrodissectionDetails = { domain, value ->
                    if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                        def details = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                        if (details) {
                            return details
                        } else {
                            return ""
                        }
                    }else {
                        return ""
                    }
                }

                def fixationStartDate = { domain, value ->
                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                        return ''
                    } else {
                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                            def fixationStartTime = domain?.identifiedSample?.aliquot?.fixationReport?.fixationStartTimeAliquot
                            fixationStartTime = fixationStartTime?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                            def startDate = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                            if (startDate && fixationStartTime) {
                                return startDate?.substring(0, 10) + "T" + fixationStartTime + ":00"
                            } else if (startDate && !fixationStartTime){
                                return startDate?.substring(0, 10) + "T00:00:00"
                            } else {
                                return ""
                            }
                        }else{
                            return ""
                        }
                    }
                }

                def fixationEndDate = { domain, value ->
                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                        return ''
                    } else {
                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                            def fixationEndTime = domain?.identifiedSample?.aliquot?.fixationReport?.fixationEndTimeAliquot
                            fixationEndTime = fixationEndTime?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                            def endDate = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                            if (endDate && fixationEndTime) {
                                return endDate?.substring(0, 10) + "T" + fixationEndTime+ ":00"
                            } else if (endDate && !fixationEndTime) {
                                return endDate?.substring(0, 10) + "T00:00:00"
                            }else {
                                return ""
                            }
                        }else{
                            return ""
                        }
                    }
                }

                def fixationType = { domain, value ->
                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                        return ''
                    } else {
                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                            def type = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                            if (type == 'Nonbuffered formalin FOR') {
                                return "Formal saline"
                            } else if (type == 'Neutral buffered formalin NBF') {
                                return "Neutral buffered Formalin"
                            }else if (type == 'Other ZZZ') {
                                return "Other"
                            }
                        }else{
                            return ""
                        }
                    }
                }

                def fixationComments = { domain, value ->
                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                        return ''
                    } else {
                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                            def comments = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                            if (comments) {
                                return comments
                            } else {
                                return ""
                            }
                        }else{
                            return ""
                        }
                    }
                }

                def excisionMargin = { domain, value ->
                    if(domain?.identifiedSample?.aliquot?.specimen?.toString()?.contains('[Fluid Specimen-')){
                        return ''
                    } else {
                        return '99'
                    }
                }

                def processingSchedule = { domain, value ->
                    if (value.toString()?.startsWith('[Fluid Specimen-')) {
                        return ''
                    } else {
                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')){
                            def schedule = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
                            if (schedule){
                                return schedule?.toLowerCase()?.replace(' ','_')
                            }else{
                                return ""
                            }
                        }else{
                            return ""
                        }
                    }
                }

                def volumeUl = { domain, value ->
                    return value
                }

                def laboratoryRemainingVolumeBanked  = { domain, value ->
                    if (domain?.identifiedSample?.aliquot?.specimen?.toString()?.startsWith('[Fluid Specimen-')) {
                        return "0"
                    }else{
                        def elution = DNA_Extract?.findById(domain?.identifiedSample?.id)?.sapphireIdentifier
                        if (elution){
                            elution = elution?.toString() + '_Remaining'
                            def remainingVolume = DNA_Extract?.findBySapphireIdentifier(elution)?.dNAAmount
                            if (remainingVolume){
                                return remainingVolume
                            }else{
                                return "0"
                            }
                        }
                    }
                }

                def numberOfBiopsies = { domain, value ->
                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                        return ""
                    } else if(domain?.identifiedSample?.aliquot?.specimen?.collectionMethod?.toString()?.contains('Biopsy')){
                        def number = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                        if (number) {
                            return number
                        } else {
                            return ""
                        }
                    }else {
                        return ""
                    }
                 }

                def gaugeOfBiopsies = { domain, value ->
                    if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                        return ""
                    } else if(domain?.identifiedSample?.aliquot?.specimen?.collectionMethod?.toString()?.contains('Biopsy')) {
                        def number = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                        if (number) {
                            return number
                        } else {
                            return ""
                        }
                    } else {
                        return ""
                    }
                }

                def timeInProcessor = { domain, value ->
                    if (value.toString()?.startsWith('[Fluid Specimen-')) {
                        return ""
                    } else {
                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')){
                            def time = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
                            if (time){
                                return time
                            }else{
                                return ""
                            }
                        }else{
                            return ""
                        }
                    }
                }

                def coreDiameter = { domain, value ->
                    if (value.toString()?.startsWith('[Fluid Specimen-')) {
                        return ""
                    } else {
                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')){
                            def diameter = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
                            if (diameter){
                                def diameterValue = diameter.substring(0,1)
                                if(diameterValue.isNumber()){
                                    return diameterValue
                                }else{
                                    return ""
                                }
                            }else{
                                return ""
                            }
                        }else{
                            return ""
                        }
                    }
                }

                def coresNumber = { domain, value ->
                    if (value.toString()?.startsWith('[Fluid Specimen-')) {
                        return ""
                    } else {
                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')){
                            def number = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
                            if (number){
                                return number
                            }else{
                                return ""
                            }
                        }else{
                            return ""
                        }
                    }
                }

                def extractionProtocol = { domain, value ->
                    if (domain?.identifiedSample?.aliquot?.specimen?.toString()?.startsWith('[Fluid Specimen-')) {
                        return ""
                    }else if(domain?.identifiedSample?.extractionKit?.toString()?.contains('QIAmp DNA FFPE Tissue Kit, Qiagen')){
                        return "Qiagen_80"
                    }else if(domain?.identifiedSample?.extractionKit?.toString()?.contains('truXTRAC FFPE DNA Kit, Covaris')){
                        return "Covaris"
                    }else if(domain?.identifiedSample?.extractionKit?.toString()?.contains('All Prep DNA/RNA Mini Kit, Qiagen')){
                        return "Fresh_Frozen"
                    }
                }

                def tumourSampleType = { domain, value ->
                    if (value.toString()?.startsWith('[Fluid Specimen-')) {
                        return ''
                    } else {
                        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy')) {
                            return 'cores'
                        }else if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Section')) {
                            return 'sections'
                        }
                        else if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Scroll')) {
                            return 'scrolls'
                        }else {
                            return ""
                        }
                    }
                }

                Map formatters = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : gelId,'clinicID':clinicID,"identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourStatus":tumourType,
                                  "identifiedSample.extractionDate":extractionDate,"identifiedSample.aliquot.aliquotType": clinicSampleType, "identifiedSample.barcode":aliquotBarcode, "laboratoryID":laboratoryID,
                                  "Laboratory Method":laboratoryMethod, "laboratoryRemainingVolumeBanked":laboratoryRemainingVolumeBanked, "dispatchedBox.dispatchRecord.sentOn":dispatchDate,
                                  "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed.snomedCode" :morphology, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.sampleType":provenance,
                                  "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed" :topography, "identifiedSample.aliquot.gelSuitabilityReport.microdissectionDetails":macrodissectionDetails,
                                  "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot":fixationStartDate, "identifiedSample.aliquot.fixationReport.fixationTypeAliquot":fixationType,
                                  "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot":fixationEndDate, "identifiedSample.aliquot.fixationReport.fixationCommentsAliquot":fixationComments,
                                  "identifiedSample.aliquot.fixationReport.processingScheduleAliquot":processingSchedule, "volume_ul":volumeUl, "laboratorySampleID":laboratorySampleID, "Excision Margin":excisionMargin,
                                  "identifiedSample.aliquot.specimen.numberOfBiopsies":numberOfBiopsies, "identifiedSample.aliquot.fixationReport.timeInProcessor": timeInProcessor, "identifiedSample.aliquot.unit":coreDiameter,
                                  "identifiedSample.aliquot.aliquotVolumeMass":coresNumber, "identifiedSample.extractionKit":extractionProtocol, "Tumour Sample Type":tumourSampleType,
                                  "identifiedSample.aliquot.gelSuitabilityReport.microdissection":macrodissection, "identifiedSample.aliquot.specimen.specimenWeight":gaugeOfBiopsies
                ]

                List fields = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier","clinicID","identifiedSample.barcode",
                               "identifiedSample.aliquot.aliquotType", "identifiedSample.extractionDate","laboratoryID", "laboratorySampleID", "Laboratory Method",
                               "volume_ul", "laboratoryRemainingVolumeBanked","dispatchedBox.dispatchRecord.sentOn", "dispatchedBox.dispatchRecord.consignmentNumber",
                               "positionIfPlated", "dispatchedBox.barcode","identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourStatus", "Excision Margin", "Tumour Size",
                               "Morphology (ICD)", "Morphology (Snomed RT)", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed.snomedCode",
                               "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.sampleType","Pre-invasive Elements", "Topography (ICD)", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed",
                               "Topography (SnomedRT)", "identifiedSample.aliquot.gelSuitabilityReport.microdissection", "identifiedSample.aliquot.gelSuitabilityReport.microdissectionDetails",
                               "Snap Freezing Start DateTime", "identifiedSample.aliquot.fixationReport.fixationTypeAliquot", "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot",
                               "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot", "identifiedSample.aliquot.fixationReport.fixationCommentsAliquot", "identifiedSample.aliquot.fixationReport.processingScheduleAliquot",
                               "identifiedSample.aliquot.fixationReport.timeInProcessor", "identifiedSample.aliquot.specimen.numberOfBiopsies", "identifiedSample.aliquot.specimen.specimenWeight", "identifiedSample.extractionKit",
                               "Prolonged Sample Storage", "Reason Sample Not Sent", "Tumour Sample Type", "Scroll Thickness", "Number of Scrolls", "Number of Sections", "Section Thickness", "Number of Blocks",
                               "identifiedSample.aliquot.unit", "identifiedSample.aliquot.aliquotVolumeMass"
                ]

                Map labels= ["identifiedSample.barcode" : "Sample ID","identifiedSample.aliquot.aliquotType":"Clinic Sample Type","testResultTypeSummaryQC" : "Test Result Type",
                             "identifiedSample.extractionDate":"Clinic Sample DateTime", "identifiedSample.passFail":"Test Result Value","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : "Participant ID",
                             "clinicID" : "Clinic ID", "laboratoryID":"Laboratory ID", "laboratorySampleID":"Laboratory Sample ID", "volume_ul":"Laboratory Sample Volume", "laboratoryRemainingVolumeBanked":"Laboratory Remaining Volume Banked",
                             "dispatchedBox.dispatchRecord.sentOn":"GMC Sample Dispatch Date", "dispatchedBox.dispatchRecord.consignmentNumber":"GMC Sample Consignment Number","positionIfPlated":"GMC Rack Well", "dispatchedBox.barcode":"GMC Rack ID",
                             "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourStatus":"Tumour Type", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed.snomedCode":"Morphology (SnomedCT)",
                             "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.sampleType":"Tissue Source", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed":"Topography (SnomedCT)",
                             "identifiedSample.aliquot.gelSuitabilityReport.microdissectionDetails":"Macrodissection Details", "identifiedSample.aliquot.gelSuitabilityReport.microdissection":"Macrodissected",
                             "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot":"Fixation End DateTime", "identifiedSample.aliquot.fixationReport.fixationTypeAliquot":"Type of Fixative",
                             "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot":"Fixation Start DateTime", "identifiedSample.aliquot.fixationReport.fixationCommentsAliquot":"Fixation Comments",
                             "identifiedSample.aliquot.fixationReport.processingScheduleAliquot":"Processing Schedule", "identifiedSample.aliquot.specimen.numberOfBiopsies":"Number of Biopsies",
                             "identifiedSample.aliquot.fixationReport.timeInProcessor":"Time in formalin on processor", "identifiedSample.aliquot.unit":"Core Diameter", "identifiedSample.aliquot.aliquotVolumeMass":"Number of Cores",
                             "identifiedSample.extractionKit":"DNA Extraction Protocol", "identifiedSample.aliquot.specimen.specimenWeight":"Gauge of Biopsies"
                ]

                Map parameters = [title: "GMC GEL Sample Metadata Cancer", "column.widths": [0.2, 0.2, 0.2]]

            exportService.export(params.format, response.outputStream, allDispatchedItems, fields, labels, formatters, parameters)
        }
    }

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
