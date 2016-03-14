package geldb.DNAExtract

import geldb.DispatchItem
import geldb.SolidSpecimen
import org.springframework.transaction.annotation.Transactional

/**
 * ExportCheckedDNAListService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportCheckedDNAListService {

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

        Map formatters = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier": gelID, "aliquot.aliquotType": clean, "aliquot.barcode": clean,
                          "extractionDate": dateFormat]
        return formatters
    }

    def getFields(){
        List fields = ["Checked By", "aliquot.specimen.participant.studySubject.studySubjectIdentifier", "aliquot.aliquotType", "aliquot.barcode", "barcode",
                       "dNAConcentrationQubit", "extractionDate", "extractedBy.staffName"]
        return fields
    }

    def getLabels(){
        Map labels = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier": "Participant Id ", "aliquot.aliquotType": "Sample Type",
                      "aliquot.barcode": "Original Aliquot Barcode", "barcode":"DNA Extract Barcode", "dNAConcentrationQubit":"Qubit Concentration",
                      "extractionDate":"Extraction Date", "extractedBy.staffName":"Extracted By"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "DNA Extract Check List", "column.widths": [0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3]]
        return parameters
    }
}
