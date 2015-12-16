package geldb.DNAExtract

import grails.transaction.Transactional

/**
 * ExportAllDNAExtractService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportAllDNAExtractService {

    def getFormatters(){
        def gelId = { domain, value ->
            return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
        }
        def passFail = { domain, value ->
            if (value.toString() == "true") {
                return 'Pass'
            } else return "Fail"
        }
        def percentageTumourContent = { domain, value ->
            return value.toString().replace('[','').replace(']','').replace('null','')
        }
        def percentageNecrosis = { domain, value ->
            return value.toString().replace('[','').replace(']','').replace('null','')
        }
        def cellularity = { domain, value ->
            return value.toString().replace('[','').replace(']','').replace('null','')
        }
        def dysplasticNonInvasiveElements = { domain, value ->
            def elements = value.toString().replace('[','').replace(']','').replace('null','')
            if (elements == "true") {
                return 'Yes'
            } else if (elements == "false"){
                return "No"
            } else return ""
        }
        Map formatters = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier":gelId, "passFail": passFail, "aliquot.gelSuitabilityReport.percentageTumourContent": percentageTumourContent,
                          "aliquot.gelSuitabilityReport.percentageNecrosis":percentageNecrosis, "aliquot.gelSuitabilityReport.cellularity": cellularity, "aliquot.gelSuitabilityReport.dysplasticNonInvasiveElements":dysplasticNonInvasiveElements]
        return formatters
    }

    def getFields(){
        List fields = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier", "passFail", "dNAConcentrationQubit", "dNAAmount", "delatQC", "aliquot.gelSuitabilityReport.percentageTumourContent",
                       "aliquot.gelSuitabilityReport.percentageNecrosis", "aliquot.gelSuitabilityReport.cellularity", "aliquot.gelSuitabilityReport.dysplasticNonInvasiveElements"]
        return fields
    }

    def getLabels(){
        Map labels = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier":"GEL Study/Participant ID", "passFail": "Pass/Fail", "dNAConcentrationQubit": "DNA/RNA Concentration (Qubit)",
                      "dNAAmount": "DNA/RNA Volume", "delatQC":"Delta QC", "aliquot.gelSuitabilityReport.percentageTumourContent":"Percentage Tumour Content", "aliquot.gelSuitabilityReport.percentageNecrosis":
                      "Percentage Necrosis", "aliquot.gelSuitabilityReport.cellularity": "Cellularity", "aliquot.gelSuitabilityReport.dysplasticNonInvasiveElements": "Dysplastic Non Invasive Elements"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "All DNA Extracts", "column.widths": [0.2, 0.3, 0.5]]
        return parameters
    }
}
