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

        def exhausted = { domain, value ->
            if (value.toString() == "true") {
                return 'Yes'
            } else return "No"
        }

        def tumourStatus = { domain, value ->
            if (value.toString()?.startsWith('[Fluid Specimen-')) {
                return ""
            } else {
               return value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
            }
        }

        Map formatters = ["aliquot.aliquotType": clean, "aliquot.barcode": clean,
                          "extractionDate": dateFormat, "aliquot.specimen.fFPE_Tissue_Report.tumourStatus":tumourStatus, "exhausted":exhausted]
        return formatters
    }

    def getFields(){
        List fields = ["Checked By", "sapphireIdentifier", "aliquot.aliquotType", "aliquot.barcode", "barcode",
                       "dNAConcentrationQubit", "exhausted", "aliquot.specimen.fFPE_Tissue_Report.tumourStatus", "extractionDate", "extractedBy.staffName"]
        return fields
    }

    def getLabels(){
        Map labels = ["aliquot.aliquotType": "Sample Type", "exhausted": "Exhausted", "aliquot.barcode": "Original Aliquot Barcode", "barcode":"DNA Extract Barcode",
                      "dNAConcentrationQubit":"Qubit Concentration", "sapphireIdentifier": "Elution", "extractionDate":"Extraction Date", "extractedBy.staffName":"Extracted By",
                      "aliquot.specimen.fFPE_Tissue_Report.tumourStatus":"Tumour Status"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "DNA Extract Check List", "column.widths": [0.12, 0.5, 0.32, 0.2, 0.2, 0.2, 0.15, 0.2, 0.2, 0.26]]
        return parameters
    }
}
