package geldb.DispatchRecord

import grails.transaction.Transactional

/**
 * QcTestExportService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class QcTestExportService {

    def cleanString (String s){
        s = s?.replace('[','')?.replace(']','')?.replace('null','')?.replace(',','')?.trim()
        return s
    }

    def gelId = { domain, value ->
        return cleanString(value?.toString())
    }

    def passFail = { domain, value ->
        if (value?.toString() == "true") {
            return 'Pass'
        } else
            return 'Fail'
    }

    def testResultTypeTrineanOD260  = { domain, value ->
        return "Trinean OD 260/280"
    }

    def testResultTypeSummaryQC  = { domain, value ->
        return "Summary QC"
    }

    def testResultTypeNanodropConcentration  = { domain, value ->
        return "Nanodrop concentration"
    }

    def laboratoryID  = { domain, value ->
        return "698D0"
    }

    def extractionDate  = { domain, value ->
        return value?.toString()?.replace(' ', 'T')
    }

    def testResultTypeQubit = { domain, value ->
        return "Qubit"
    }

    def testResultTypeDeltaCq = { domain, value ->
        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
            return "delta Cq"
        }
    }

    def gelIdDeltaCq = { domain, value ->
        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
            return cleanString(value?.toString())
        }
    }

    def laboratoryIDDeltaCq  = { domain, value ->
        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
            return "698D0"
        }
    }

    def sampleIDDeltaCq  = { domain, value ->
        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
            return value
        }
    }

    def extractionDateDeltaCq  = { domain, value ->
        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
            return value?.toString()?.replace(' ', 'T')
        }
    }

    def deltaQC  = { domain, value ->
        if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
            return value
        }
    }

    def testResultTypeTumourContent = { domain, value ->
        return "Tumour Content"
    }

    def gelIdTumourContent = { domain, value ->
        return cleanString(value?.toString())
    }

    def laboratoryIDTumourContent  = { domain, value ->
        return "698D0"
    }

    def sampleIDTumourContent  = { domain, value ->
        return value
    }

    def dateTumourContent  = { domain, value ->
        def tumourDate
        if(domain?.identifiedSample?.aliquot?.first()?.derivedFrom?.id != null){
            tumourDate = domain?.identifiedSample?.aliquot?.derivedFrom?.aliquot?.gelSuitabilityReport?.reportDate
            tumourDate = tumourDate?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
        }else {
            tumourDate = domain?.identifiedSample?.aliquot?.gelSuitabilityReport?.reportDate
            tumourDate = tumourDate?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
        }
        if (tumourDate){
            return tumourDate?.replace(' ', 'T')
        } else{
            return ""
        }
    }

    def percentageTumourContent = { domain, value ->
        def tumour
        if(domain?.identifiedSample?.aliquot?.first()?.derivedFrom?.id != null){
            tumour = domain?.identifiedSample?.aliquot?.derivedFrom?.aliquot?.gelSuitabilityReport?.percentageTumourContent
            tumour = tumour?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
        }else {
            tumour = domain?.identifiedSample?.aliquot?.first()?.gelSuitabilityReport?.percentageTumourContent
            tumour = tumour?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
        }
        if (tumour){
            tumour = tumour?.toInteger()
            if(tumour < 40){
                return "Low"
            }else if(tumour >= 40 && tumour <= 60 ){
                return "Medium"
            }else if(tumour > 60 ){
                return "High"
            }else {
                return ""
            }
        }else {
            return ""
        }
    }

    def getSummaryQCFields(){
        List SummaryQCFields = ["identifiedSample.barcode","testResultTypeSummaryQC","identifiedSample.extractionDate","identifiedSample.passFail","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier",
                                "laboratoryID"]
        return SummaryQCFields
    }

    def getSummaryQCLabels(){
        Map summaryQCLabels = ["identifiedSample.barcode" : "Sample ID","testResultTypeSummaryQC" : "Test Result Type","identifiedSample.extractionDate":"Test Result DateTime", "identifiedSample.passFail":"Test Result Value","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : "Participant ID",
                               "laboratoryID" : "Laboratory ID"]
        return summaryQCLabels
    }

    def getSummaryQCParameters(){
        Map summaryQCParameters= [title: "GMC_to_GEL_QC_test_csv_format", "column.widths": [0.2, 0.3, 0.5], "lineEnd":"\r\n", "quoteCharacter": "\u0000"]
        return summaryQCParameters
    }

    def getSummaryQCFormatters(){
        Map summaryQCFormatters = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : gelId,'testResultTypeSummaryQC':testResultTypeSummaryQC,'laboratoryID':laboratoryID, "identifiedSample.passFail": passFail,
                                   "identifiedSample.extractionDate":extractionDate]
        return summaryQCFormatters
    }

    def getTrineanOD260Fields(){
        List trineanOD260Fields = ["identifiedSample.barcode","testResultTypeTrineanOD260","identifiedSample.extractionDate","identifiedSample.a260A280","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier",
                                   "laboratoryID"]
        return trineanOD260Fields
    }

    def getTrineanOD260Labels(){
        Map trineanOD260Labels = ["identifiedSample.barcode" : "Sample ID","testResultTypeTrineanOD260" : "Test Result Type","identifiedSample.a260A280":"Test Result Value","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : "Participant ID",
                                  "laboratoryID" : "Laboratory ID"]
        return trineanOD260Labels
    }

    def getTrineanOD260Parameters(){
        Map trineanOD260Parameters = [title: "Dispatched Samples to Oxford Biorepository","header.enabled":false, "column.widths": [0.2, 0.3, 0.5], "lineEnd":"\r\n", "quoteCharacter": "\u0000"]
        return trineanOD260Parameters
    }

    def getTrineanOD260Formatters(){
        Map trineanOD260Formatters = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : gelId,'testResultTypeTrineanOD260':testResultTypeTrineanOD260,'laboratoryID':laboratoryID, "identifiedSample.extractionDate":extractionDate]
        return trineanOD260Formatters
    }

    def getNanodropConcentrationFields(){
        List nanodropConcentrationFields = ["identifiedSample.barcode","testResultNanodropConcentration","identifiedSample.extractionDate","identifiedSample.dNAConcentrationNanodrop","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier",
                                            "laboratoryID"]
        return nanodropConcentrationFields
    }

    def getNanodropConcentrationLabels(){
        Map nanodropConcentrationLabels = ["identifiedSample.barcode" : "Sample ID","testResultNanodropConcentration" : "Test Result Type","identifiedSample.dNAConcentrationNanodrop":"Test Result Value","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : "Participant ID",
                                           "laboratoryID" : "Laboratory ID"]
        return nanodropConcentrationLabels
    }

    def getNanodropConcentrationParameters(){
        Map nanodropConcentrationParameters = [title: "Dispatched Samples to Oxford Biorepository","header.enabled":false, "column.widths": [0.2, 0.3, 0.5], "lineEnd":"\r\n", "quoteCharacter": "\u0000"]
        return nanodropConcentrationParameters
    }

    def getNanodropConcentrationformatters(){
        Map nanodropConcentrationformatters = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : gelId,'testResultNanodropConcentration':testResultTypeNanodropConcentration,'laboratoryID':laboratoryID, "identifiedSample.extractionDate":extractionDate]
        return nanodropConcentrationformatters
    }

    def getQubitFields(){
        List qubitFields = ["identifiedSample.barcode","dNAConcentrationQubit","identifiedSample.extractionDate","identifiedSample.dNAConcentrationQubit","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier",
                                            "laboratoryID"]
        return qubitFields
    }

    def getQubitLabels(){
        Map nanodropConcentrationLabels = ["identifiedSample.barcode" : "Sample ID","dNAConcentrationQubit" : "Test Result Type","identifiedSample.dNAConcentrationQubit":"Test Result Value","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : "Participant ID",
                                           "laboratoryID" : "Laboratory ID"]
        return nanodropConcentrationLabels
    }

    def getQubitParameters(){
        Map nanodropConcentrationParameters = [title: "Dispatched Samples to Oxford Biorepository","header.enabled":false, "column.widths": [0.2, 0.3, 0.5], "lineEnd":"\r\n", "quoteCharacter": "\u0000"]
        return nanodropConcentrationParameters
    }

    def getQubitFormatters(){
        Map nanodropConcentrationformatters = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : gelId,'dNAConcentrationQubit':testResultTypeQubit,'laboratoryID':laboratoryID, "identifiedSample.extractionDate":extractionDate]
        return nanodropConcentrationformatters
    }
    def getDeltaCqFields(){
        List deltaCqFields = ["identifiedSample.barcode","dNADeltaCq","identifiedSample.extractionDate","identifiedSample.delatQC","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier",
                              "laboratoryID"]
        return deltaCqFields
    }

    def getDeltaCqLabels(){
        Map deltaCqLabels = ["identifiedSample.barcode" : "Sample ID","dNADeltaCq" : "Test Result Type","identifiedSample.delatQC":"Test Result Value","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : "Participant ID",
                             "laboratoryID" : "Laboratory ID"]
        return deltaCqLabels
    }

    def getDeltaCqParameters(){
        Map deltaCqParameters = [title: "Dispatched Samples to Oxford Biorepository","header.enabled":false, "column.widths": [0.2, 0.3, 0.5], "lineEnd":"\r\n", "quoteCharacter": "\u0000"]
        return deltaCqParameters
    }

    def getDeltaCqFormatters(){
        Map deltaCqFormatters = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : gelIdDeltaCq,'dNADeltaCq':testResultTypeDeltaCq,'laboratoryID':laboratoryIDDeltaCq, "identifiedSample.extractionDate":extractionDateDeltaCq,
                                 "identifiedSample.barcode":sampleIDDeltaCq, "identifiedSample.delatQC":deltaQC]
        return deltaCqFormatters
    }

    def getTumourContentFields(){
        List tumourContentFields = ["identifiedSample.barcode","testResultTypeTumourContent", "tumourContentDate", "percentageTumourContent","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier",
                              "laboratoryID"]
        return tumourContentFields
    }

    def getTumourContentLabels(){
        Map tumourContentLabels = [:]
        return tumourContentLabels
    }

    def getTumourContentParameters(){
        Map tumourContentParameters = [title: "Dispatched Samples to Oxford Biorepository","header.enabled":false, "column.widths": [0.2, 0.3, 0.5], "lineEnd":"\r\n", "quoteCharacter": "\u0000"]
        return tumourContentParameters
    }

    def getTumourContentFormatters(){
        Map tumourContentFormatters = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : gelIdTumourContent,'testResultTypeTumourContent':testResultTypeTumourContent,'laboratoryID':laboratoryIDTumourContent, "tumourContentDate":dateTumourContent,
                                 "identifiedSample.barcode":sampleIDTumourContent, "percentageTumourContent":percentageTumourContent]
        return tumourContentFormatters
    }
}
