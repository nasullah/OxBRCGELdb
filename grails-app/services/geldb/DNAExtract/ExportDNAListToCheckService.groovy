package geldb.DNAExtract

import geldb.DispatchItem
import geldb.FFPE_Tissue_Report
import grails.transaction.Transactional

/**
 * ExportDNAListToCheckService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportDNAListToCheckService {

    def getFormatters(){
        def gelID = { domain, value ->
            return value?.toString()?.replace('[','')?.replace(']','')?.replace(' ','')?.replace(',','')?.replace('null','')
        }

        def clean = { domain, value ->
            return value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
        }

        def dateFormat = { domain, value ->
            if (value.toString().size() > 10){
                return value?.toString()?.substring(0, 10)
            }else {
                return value
            }
        }

        def tumourStatus = { domain, value ->
            if (value.toString()?.startsWith('[Fluid Specimen-')) {
                return ""
            } else {
               return value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
            }
        }

        Map formatters = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier": gelID, "aliquot.aliquotType": clean, "aliquot.barcode": clean,
                          "extractionDate": dateFormat, "aliquot.specimen.fFPE_Tissue_Report.tumourStatus":tumourStatus]
        return formatters
    }

    def getFields(){
        List fields = ["Checked By", "aliquot.specimen.participant.studySubject.studySubjectIdentifier", "aliquot.aliquotType", "aliquot.barcode", "barcode",
                       "dNAConcentrationQubit", "aliquot.specimen.fFPE_Tissue_Report.tumourStatus", "extractionDate", "extractedBy.staffName"]
        return fields
    }

    def getLabels(){
        Map labels = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier": "Participant Id ", "aliquot.aliquotType": "Sample Type",
                      "aliquot.barcode": "Original Aliquot Barcode", "barcode":"DNA Extract Barcode", "dNAConcentrationQubit":"Qubit Concentration",
                      "extractionDate":"Extraction Date", "extractedBy.staffName":"Extracted By", "aliquot.specimen.fFPE_Tissue_Report.tumourStatus":"Tumour Status"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "DNA Extract Check List", "column.widths": [0.3, 0.3, 0.3, 0.3, 0.3, 0.25, 0.2, 0.2, 0.25]]
        return parameters
    }
}
