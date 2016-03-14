package geldb.DNAExtract

import geldb.AliquotType
import geldb.DNA_Extract
import geldb.DispatchItem
import geldb.ExtractionType
import geldb.FFPE_Tissue_Report
import geldb.SolidSpecimen
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
        def clean = { domain, value ->
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

        def dispatchItemList = DispatchItem.list()
        def dispatched = { domain, value ->
            def dispatchItem = dispatchItemList.find {item -> item.identifiedSample.id == value}
            if (dispatchItem) {
                return 'Yes'
            } else return "No"
        }

        def tumourType = { domain, value ->
            if (value.toString()?.startsWith('[Fluid Specimen-')) {
                def patient = domain?.aliquot?.first()?.specimen?.participant
                if (patient){
                    def tumour = SolidSpecimen?.findByParticipant(patient)?.fFPE_Tissue_Report
                    if (!tumour?.empty){
                        return tumour?.first()?.tumourType?.tumourLocation
                    }else{
                        return ""
                    }
                }
               else{
                    return ""
                }
            } else {
                def tumour = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
                if (tumour){
                    return tumour
                }else{
                    return ""
                }
            }
        }

        Map formatters = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier":gelId, "passFail": passFail, "aliquot.gelSuitabilityReport.percentageTumourContent": clean, "aliquot.aliquotType": clean,
                          "aliquot.gelSuitabilityReport.percentageNecrosis":clean, "aliquot.gelSuitabilityReport.cellularity": clean, "aliquot.gelSuitabilityReport.dysplasticNonInvasiveElements":dysplasticNonInvasiveElements,
                          "id":dispatched, "aliquot.specimen.fFPE_Tissue_Report.tumourType.tumourLocation":tumourType]
        return formatters
    }

    def getFields(){
        List fields = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier","aliquot.specimen.fFPE_Tissue_Report.tumourType.tumourLocation", "aliquot.aliquotType", "id", "passFail",
                       "dNAConcentrationQubit", "dNAAmount", "delatQC", "aliquot.gelSuitabilityReport.percentageTumourContent", "aliquot.gelSuitabilityReport.percentageNecrosis",
                       "aliquot.gelSuitabilityReport.cellularity", "aliquot.gelSuitabilityReport.dysplasticNonInvasiveElements"]
        return fields
    }

    def getLabels(){
        Map labels = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier":"GEL Study/Participant ID", "passFail": "Pass/Fail", "dNAConcentrationQubit": "DNA/RNA Concentration (Qubit)",
                      "dNAAmount": "DNA/RNA Volume", "delatQC":"Delta QC", "aliquot.gelSuitabilityReport.percentageTumourContent":"Percentage Tumour Content", "aliquot.gelSuitabilityReport.percentageNecrosis":
                      "Percentage Necrosis", "aliquot.gelSuitabilityReport.cellularity": "Cellularity", "aliquot.gelSuitabilityReport.dysplasticNonInvasiveElements": "Dysplastic Non Invasive Elements",
                      "aliquot.aliquotType":"Aliquot Type", "id": "Dispatched", "aliquot.specimen.fFPE_Tissue_Report.tumourType.tumourLocation":"Cancer Type"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "All DNA Extracts", "column.widths": [0.2, 0.2, 0.25, 0.1, 0.1, 0.1, 0.2, 0.1, 0.15, 0.15, 0.1, 0.1]]
        return parameters
    }
}
