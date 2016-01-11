package geldb.DispatchRecord


import grails.transaction.Transactional

/**
 * AllDispatchedItemsService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class AllDispatchedItemsService {

    def getFormatters() {
        def formatParticipantID = { domain, value ->
            return value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')?.replace(',','')?.trim()
        }

        def aliquotType = { domain, value ->
            return value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
        }

        def dNAConcentrationQubit = { domain, value ->
            return value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
        }

        def dispatchDate  = { domain, value ->
            def date = value?.toString()
            if(date){
                return date?.substring(0,10)
            }else{
                return ""
            }
        }

        Map formatters = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier": formatParticipantID,
                          "identifiedSample.aliquot.aliquotType.aliquotTypeName":aliquotType, "dispatchedBox.dispatchRecord.sentOn": dispatchDate,
                          "identifiedSample.dNAConcentrationQubit": dNAConcentrationQubit]
        return formatters
    }

    def getFields(){
        List fields = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier", "identifiedSample.barcode", "dispatchedBox.dispatchRecord.consignmentNumber",
                       "identifiedSample.aliquot.aliquotType.aliquotTypeName", "dispatchedBox.dispatchRecord.sentOn", "identifiedSample.dNAConcentrationQubit"]
        return fields
    }

    def getLabels(){
        Map labels = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier": "Participant ID", "identifiedSample.barcode": "Sample ID",
                      "dispatchedBox.dispatchRecord.consignmentNumber": "Consignment Number", "identifiedSample.dNAConcentrationQubit": "DNA Concentration (Qubit)",
                      "dispatchedBox.dispatchRecord.sentOn": "Date Dispatched", "identifiedSample.aliquot.aliquotType.aliquotTypeName": "Aliquot Type"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "Dispatched Item", "column.widths": [0.2, 0.3, 0.3, 0.2, 0.2, 0.25]]
        return parameters
    }
}
