package geldb.DispatchRecord

import geldb.Aliquot
import geldb.FluidSpecimen
import geldb.StaffMember
import org.springframework.transaction.annotation.Transactional

/**
 * SampleMetadataExportService
 * A service class encapsulates the core business logic of a Grails application
 */

@Transactional
class SampleMetadataExportService {

    def cleanString (String s){
        s = s?.replace('[','')?.replace(']','')?.replace('null','')?.replace(',','')?.trim()
        return s
    }

    def getFormatters() {
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
            return value?.toString()
        }

        def dispatchDate  = { domain, value ->
            def date = value?.toString()
            if(date){
                return date?.substring(0,10)
            }else{
                return ""
            }
        }

        def tumourContent  = { domain, value ->
            def content = value?.toString()?.replace('[','')?.replace(']','')?.replace('%','')?.trim()
            if (content){
                if (content?.toInteger() < 30){
                    return "Low"
                }else if (content?.toInteger() > 50){
                    return "High"
                }else if (content?.toInteger() > 29 && content?.toInteger() < 51){
                    return "Medium"
                }
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

        def nonInvasiveElements  = { domain, value ->
            def elements = value?.toString()?.replace('[','')?.replace(']','')
            if (elements){
                if (elements == 'true'){
                    return "yes"
                }else {
                    return "no"
                }
            }else{
                return ""
            }
        }

        def topology = { domain, value ->
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

        def pathologistsComments = { domain, value ->
            def comments = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
            if (comments){
                return comments
            }else{
                return ""
            }
        }

        def sectionCutBy = { domain, value ->
            if(domain?.identifiedSample?.aliquot?.derivation?.derivedAliquots?.aliquotType?.aliquotTypeName?.toString()?.contains('Section')) {
                def parentAliquot = Aliquot.findByIdInList(domain?.identifiedSample?.aliquot?.id)
                def aliquots = Aliquot.findAll {derivedFrom.aliquot == parentAliquot}
                aliquots = aliquots.findAll {c -> c.aliquotType.aliquotTypeName == 'Section'}
                return aliquots.derivedFrom.derivedBy.staffName?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
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

        def sectionCutOn = { domain, value ->
            if(domain?.identifiedSample?.aliquot?.derivation?.derivedAliquots?.aliquotType?.aliquotTypeName?.toString()?.contains('Section')) {
                def parentAliquot = Aliquot.findByIdInList(domain?.identifiedSample?.aliquot?.id)
                def aliquots = Aliquot.findAll {derivedFrom.aliquot == parentAliquot}
                aliquots = aliquots.findAll {c -> c.aliquotType.aliquotTypeName == 'Section'}
                def date = aliquots.derivedFrom.derivationDate?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                if (date) {
                    return date?.substring(0, 10)
                } else {
                    return ""
                }
            }else {
                return ""
            }
        }

        def sectionAssessedDate = { domain, value ->
            if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy Frozen')) {
                def date = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                if (date) {
                    return date?.substring(0, 10)
                } else {
                    return ""
                }
            }else{
                return ""
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

        def sectionAssessedBy = { domain, value ->
            if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy Frozen')) {
                value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
            }else{
                return ""
            }
        }

        def slideMarkedBy = { domain, value ->
            if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                def markedBy = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                if (markedBy){
                    if (markedBy?.isNumber()){
                        def staffMember = StaffMember?.get(markedBy?.toInteger())?.staffName
                        return staffMember
                    }else{
                        markedBy
                    }
                }
            }else{
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

        def sideMarkedDate = { domain, value ->
            if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                def markedDate = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                if (markedDate) {
                    return markedDate?.substring(0, 10)
                } else {
                    return ""
                }
            }else{
                return ""
            }
        }

        def fixationType = { domain, value ->
            if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                return ''
            } else {
                if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                    def type = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                    if (type) {
                        return type
                    } else {
                        return ""
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
            def fluidSpecimen = FluidSpecimen?.findById(domain?.identifiedSample?.aliquot?.specimen?.id)
            if (fluidSpecimen){
                return value
            }else{
                return ""
            }
        }


        def laboratoryRemainingVolumeBanked  = { domain, value ->
            def fluidSpecimen = FluidSpecimen?.findById(domain?.identifiedSample?.aliquot?.specimen?.id)
            if (fluidSpecimen){
                return "0"
            }else{
                return ""
            }
        }

        Map formatters = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : gelId,'clinicID':clinicID,"identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourStatus":tumourType,
                          "identifiedSample.extractionDate":extractionDate,"identifiedSample.aliquot.aliquotType": clinicSampleType, "identifiedSample.barcode":aliquotBarcode, "laboratoryID":laboratoryID,
                          "identifiedSample.extractionType":laboratoryMethod, "laboratoryRemainingVolumeBanked":laboratoryRemainingVolumeBanked, "dispatchedBox.dispatchRecord.sentOn":dispatchDate,
                          "identifiedSample.aliquot.gelSuitabilityReport.percentageTumourContent":tumourContent,"identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed.snomedCode" :morphology,
                          "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.sampleType":provenance, "identifiedSample.aliquot.gelSuitabilityReport.dysplasticNonInvasiveElements":nonInvasiveElements,
                          "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed" :topology, "identifiedSample.aliquot.gelSuitabilityReport.comments":pathologistsComments,
                          "identifiedSample.aliquot.derivation.derivedBy.staffName":sectionCutBy,"identifiedSample.aliquot.gelSuitabilityReport.microdissectionDetails":macrodissectionDetails,
                          "identifiedSample.aliquot.derivation.derivationDate":sectionCutOn, "identifiedSample.aliquot.gelSuitabilityReport.reportDate":sectionAssessedDate, "identifiedSample.aliquot.gelSuitabilityReport.microdissection":macrodissection,
                          "identifiedSample.aliquot.gelSuitabilityReport.reportStaff.staffName":sectionAssessedBy, "identifiedSample.aliquot.gelSuitabilityReport.slideMarkedBy":slideMarkedBy, "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot":fixationStartDate,
                          "identifiedSample.aliquot.gelSuitabilityReport.sideMarkedDate":sideMarkedDate, "identifiedSample.aliquot.fixationReport.fixationTypeAliquot":fixationType, "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot":fixationEndDate,
                          "identifiedSample.aliquot.fixationReport.fixationCommentsAliquot":fixationComments, "identifiedSample.aliquot.fixationReport.processingScheduleAliquot":processingSchedule,
                          "volume_ul":volumeUl, "laboratorySampleID":laboratorySampleID, "Excision Margin":excisionMargin
        ]

        return formatters
    }

    def getFields(){
        List fields = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier","clinicID","identifiedSample.barcode",
                       "identifiedSample.aliquot.aliquotType", "identifiedSample.extractionDate","laboratoryID", "laboratorySampleID", "identifiedSample.extractionType",
                       "volume_ul", "laboratoryRemainingVolumeBanked","dispatchedBox.dispatchRecord.sentOn", "dispatchedBox.dispatchRecord.consignmentNumber",
                       "positionIfPlated", "dispatchedBox.barcode","identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourStatus", "Excision Margin", "Tumour Size",
                       "identifiedSample.aliquot.gelSuitabilityReport.percentageTumourContent", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed.snomedCode",
                       "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.sampleType","identifiedSample.aliquot.gelSuitabilityReport.dysplasticNonInvasiveElements",
                       "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed", "identifiedSample.aliquot.gelSuitabilityReport.comments",
                       "identifiedSample.aliquot.derivation.derivedBy.staffName", "identifiedSample.aliquot.gelSuitabilityReport.microdissectionDetails",
                       "identifiedSample.aliquot.derivation.derivationDate", "identifiedSample.aliquot.gelSuitabilityReport.reportDate","Snap Freezing Start DateTime",
                       "identifiedSample.aliquot.gelSuitabilityReport.microdissection","identifiedSample.aliquot.gelSuitabilityReport.reportStaff.staffName",
                       "Snap Freezing End DateTime","identifiedSample.aliquot.gelSuitabilityReport.slideMarkedBy","identifiedSample.aliquot.fixationReport.fixationEndDateAliquot",
                       "identifiedSample.aliquot.gelSuitabilityReport.sideMarkedDate","Microdissection Details", "identifiedSample.aliquot.fixationReport.fixationTypeAliquot",
                       "Microdissection", "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot", "identifiedSample.aliquot.fixationReport.fixationCommentsAliquot",
                       "identifiedSample.aliquot.fixationReport.processingScheduleAliquot"
                      ]

        return fields
    }

    def getLabels(){
        Map labels= ["identifiedSample.barcode" : "Sample ID","identifiedSample.aliquot.aliquotType":"Clinic Sample Type","testResultTypeSummaryQC" : "Test Result Type",
                     "identifiedSample.extractionDate":"Clinic Sample DateTime", "identifiedSample.passFail":"Test Result Value","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : "Participant ID",
                     "clinicID" : "Clinic ID", "laboratoryID":"Laboratory ID", "laboratorySampleID":"Laboratory Sample ID", "identifiedSample.extractionType":"Laboratory Method",
                     "volume_ul":"Laboratory Sample Volume", "laboratoryRemainingVolumeBanked":"Laboratory Remaining Volume Banked", "dispatchedBox.dispatchRecord.sentOn":"GMC Sample Dispatch Date",
                     "dispatchedBox.dispatchRecord.consignmentNumber":"GMC Sample Consignment Number","positionIfPlated":"GMC Rack Well", "dispatchedBox.barcode":"GMC Rack ID",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourStatus":"Tumour Type", "identifiedSample.aliquot.gelSuitabilityReport.percentageTumourContent":"Tumour content",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed.snomedCode":"Morphology", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.sampleType":"Provenance",
                     "identifiedSample.aliquot.gelSuitabilityReport.dysplasticNonInvasiveElements":"Non Invasive Elements", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed":"Topography",
                     "identifiedSample.aliquot.gelSuitabilityReport.comments":"Pathologists Comments", "identifiedSample.aliquot.derivation.derivedBy.staffName":"Section Cut By",
                     "identifiedSample.aliquot.gelSuitabilityReport.microdissectionDetails":"Macrodissection Details", "identifiedSample.aliquot.derivation.derivationDate":"Section Cut Date",
                     "identifiedSample.aliquot.gelSuitabilityReport.reportDate":"Section Assessed Date", "identifiedSample.aliquot.gelSuitabilityReport.microdissection":"Macrodissected",
                     "identifiedSample.aliquot.gelSuitabilityReport.reportStaff.staffName":"Section Assessed By", "identifiedSample.aliquot.gelSuitabilityReport.slideMarkedBy":"Slide Marked By",
                     "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot":"Fixation End DateTime","identifiedSample.aliquot.gelSuitabilityReport.sideMarkedDate":"Slide Marked Date",
                     "identifiedSample.aliquot.fixationReport.fixationTypeAliquot":"Type of Fixative", "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot":"Fixation Start DateTime",
                     "identifiedSample.aliquot.fixationReport.fixationCommentsAliquot":"Fixation Comments","identifiedSample.aliquot.fixationReport.processingScheduleAliquot":"Processing Schedule"
                    ]

        return labels
    }

    def getParameters(){
        Map parameters = [title: "GMC GEL Sample Metadata Cancer", "column.widths": [0.2, 0.3, 0.5]]
        return parameters
    }
}
