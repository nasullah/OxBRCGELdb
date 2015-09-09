package geldb.Participant

import grails.transaction.Transactional

/**
 * ListAuditLogDataService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ListAuditLogDataService {

    def getFields() {
        List fields = ["actor", "eventName", "dateCreated", "className", "persistedObjectId", "oldValue", "newValue"]
        return fields
    }

    def getLabels(){
        Map labels = ["actor":"Username", "eventName":"Event Name", "dateCreated":"Date & Time", "className":"Table", "persistedObjectId":"Record ID", "oldValue":"Old Value", "newValue":"New Value"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "Exported User Activity Log", "column.widths": [0.2, 0.3, 0.5]]
        return parameters
    }
}
