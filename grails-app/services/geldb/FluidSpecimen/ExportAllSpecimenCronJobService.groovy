package geldb.FluidSpecimen

import geldb.Specimen

/**
 * ExportAllSpecimenCronJobService
 * A service class encapsulates the core business logic of a Grails application
 */
class ExportAllSpecimenCronJobService {
    static transactional = false
    def grailsApplication
    def exportService

    def exportAllSpecimen() {
        def os = new File(grailsApplication.config.hizniShare + 'exportSpecimen.csv').newOutputStream()
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
        def type = 'csv'
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

        Map parameters = [title: "exportSpecimen"]
        exportService.export(type, os, specimenList, fields, labels, formatters, parameters )
        os.close()
    }
}
