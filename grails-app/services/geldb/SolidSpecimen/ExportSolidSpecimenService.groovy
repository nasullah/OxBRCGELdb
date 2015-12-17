package geldb.SolidSpecimen

import grails.transaction.Transactional

/**
 * ExportSolidSpecimenService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportSolidSpecimenService {

    def getFormatters(){
        def clean = { domain, value ->
            return value.toString().replace('[','').replace(']','').replace('null','').trim()
        }
        def cleanIschaemia = { domain, value ->
            return value.toString().replace('[','').replace(']','').trim()
        }
        def cleanGelID = { domain, value ->
            return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
        }
        def exhausted = { domain, value ->
            if (value.toString() == 'true'){
                return 'Yes'
            }else return 'No'
        }
        Map formatters = ["fFPE_Tissue_Report.reportDate":clean, "fFPE_Tissue_Report.reportStaff":clean, "fFPE_Tissue_Report.comments":clean, "fFPE_Tissue_Report.sampleType":clean, "fFPE_Tissue_Report.stage":clean,
                          "fFPE_Tissue_Report.stagingSystem":clean, "fFPE_Tissue_Report.tumourStatus":clean, "fFPE_Tissue_Report.tumourType":clean, "fFPE_Tissue_Report.snomed.snomedCode":clean,
                          "fFPE_Tissue_Report.cold_ischaemia":cleanIschaemia, "fFPE_Tissue_Report.warm_ischaemia":cleanIschaemia, "fFPE_Tissue_Report.cellPathReport":clean, "fFPE_Tissue_Report.fixationType":clean, "fFPE_Tissue_Report.processingSchedule":clean,
                          "fFPE_Tissue_Report.fixationStartDate":clean, "fFPE_Tissue_Report.fixationStartTime":clean, "fFPE_Tissue_Report.fixationEndDate":clean, "fFPE_Tissue_Report.fixationEndTime":clean,
                          "fFPE_Tissue_Report.fixationPeriod":clean, "fFPE_Tissue_Report.fixationTimeUnknown":clean, "fFPE_Tissue_Report.fixationComments":clean,"fFPE_Tissue_Report.tissueWorksheet":clean,
                          "fFPE_Tissue_Report.cellPathMacroscopicReport":clean, "fFPE_Tissue_Report.cellPathMicroscopicReport":clean, "fFPE_Tissue_Report.cellPathSummaryReport":clean,
                          "fFPE_Tissue_Report.cellPathSupplementaryReport":clean, "participant.studySubject.studySubjectIdentifier":cleanGelID, "exhausted":exhausted]
        return formatters
    }

    def getFields(){
        List fields = ["participant.studySubject.studySubjectIdentifier", "histologyNumber", "collectionMethod", "anatomicalSite", "barcode", "exhausted", "notes","collectionDate","collectionTime","collectionLocation","collectedBy","methodOfTransportToPathologist",
                       "surgeon", "pathologist", "specimenWeight", "massUnit", "fFPE_Tissue_Report.reportDate", "fFPE_Tissue_Report.reportStaff", "fFPE_Tissue_Report.comments", "fFPE_Tissue_Report.sampleType", "fFPE_Tissue_Report.stage",
                       "fFPE_Tissue_Report.stagingSystem", "fFPE_Tissue_Report.tumourStatus", "fFPE_Tissue_Report.tumourType", "fFPE_Tissue_Report.snomed.snomedCode", "fFPE_Tissue_Report.cold_ischaemia",
                       "fFPE_Tissue_Report.warm_ischaemia", "fFPE_Tissue_Report.cellPathReport", "fFPE_Tissue_Report.fixationType", "fFPE_Tissue_Report.processingSchedule", "fFPE_Tissue_Report.fixationStartDate", "fFPE_Tissue_Report.fixationStartTime",
                       "fFPE_Tissue_Report.fixationEndDate", "fFPE_Tissue_Report.fixationEndTime", "fFPE_Tissue_Report.fixationPeriod", "fFPE_Tissue_Report.fixationTimeUnknown", "fFPE_Tissue_Report.fixationComments", "fFPE_Tissue_Report.tissueWorksheet",
                       "fFPE_Tissue_Report.cellPathMacroscopicReport", "fFPE_Tissue_Report.cellPathMicroscopicReport", "fFPE_Tissue_Report.cellPathSummaryReport", "fFPE_Tissue_Report.cellPathSupplementaryReport"]
        return fields
    }

    def getLabels(){
        Map labels = ["histologyNumber":"Histology Number", "collectionMethod":"Collection Method", "anatomicalSite":"Anatomical Site", "barcode":"Barcode", "exhausted":"Exhausted", "notes":"Notes", "collectionDate":"Collection Date", "collectionTime":"Collection Time",
                      "collectionLocation":"Collection Location", "collectedBy":"Collected By", "methodOfTransportToPathologist":"Method of Transport to Pathologist", "surgeon":"Surgeon", "pathologist":"Pathologist", "specimenWeight":"Specimen Weight",
                      "massUnit":"Mass Unit", "fFPE_Tissue_Report.reportDate":"Report Date", "fFPE_Tissue_Report.reportStaff":"Report Staff", "fFPE_Tissue_Report.comments":"Comments", "fFPE_Tissue_Report.sampleType":"Sample Type", "fFPE_Tissue_Report.stage":"Stage",
                      "fFPE_Tissue_Report.stagingSystem":"Staging System", "fFPE_Tissue_Report.tumourStatus":"Tumour Status", "fFPE_Tissue_Report.tumourType":"Tumour Type", "fFPE_Tissue_Report.snomed.snomedCode":"Snomed Code",
                      "fFPE_Tissue_Report.cold_ischaemia":"Cold Ischaemia", "fFPE_Tissue_Report.warm_ischaemia":"Warm Ischaemia", "fFPE_Tissue_Report.cellPathReport":"Cell Path Report", "fFPE_Tissue_Report.fixationType":"Fixation Type", "fFPE_Tissue_Report.processingSchedule":"Processing Schedule",
                      "fFPE_Tissue_Report.fixationStartDate":"Fixation Start Date", "fFPE_Tissue_Report.fixationStartTime":"fixationStartTime", "fFPE_Tissue_Report.fixationEndDate":"Fixation End Date", "fFPE_Tissue_Report.fixationEndTime":"Fixation End Time",
                      "fFPE_Tissue_Report.fixationPeriod":"Fixation Period", "fFPE_Tissue_Report.fixationTimeUnknown":"Fixation Time Unknown", "fFPE_Tissue_Report.fixationComments":"Fixation Comments","fFPE_Tissue_Report.tissueWorksheet":"Tissue Worksheet",
                      "fFPE_Tissue_Report.cellPathMacroscopicReport":"Cell Path Macroscopic Report", "fFPE_Tissue_Report.cellPathMicroscopicReport":"Cell Path Microscopic Report", "fFPE_Tissue_Report.cellPathSummaryReport":"Cell Path Summary Report",
                      "fFPE_Tissue_Report.cellPathSupplementaryReport":"Cell Path Supplementary Report", "participant.studySubject.studySubjectIdentifier":"GEL Study ID"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "Main Specimens and Reports", "column.widths": [0.2, 0.2, 0.2, 0.2, 0.2, 0.1, 0.2, 0.15, 0.15, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.3, 0.3, 0.3, 0.3, 0.3]]
        return parameters
    }
}
