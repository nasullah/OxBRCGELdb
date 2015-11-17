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
        Map formatters = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier": formatParticipantID]
        return formatters
    }

    def getFields(){
        List fields = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier", "identifiedSample.barcode", "dispatchedBox.dispatchRecord.consignmentNumber"]
        return fields
    }

    def getLabels(){
        Map labels = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier": "Participant ID", "identifiedSample.barcode": "Sample ID",
                      "dispatchedBox.dispatchRecord.consignmentNumber": "Consignment Number"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "Dispatched Item", "column.widths": [0.2, 0.3, 0.5]]
        return parameters
    }
}
