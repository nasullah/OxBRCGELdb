package geldb.Aliquot

import grails.transaction.Transactional

/**
 * ExportListOfMaterialSuppliedService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportListOfMaterialSuppliedService {

    def getFormatters(){
        def gelId = { domain, value ->
            return value.toString().replace('[', '').replace(']', '').replace('null', '').replace(',', '').trim()
        }

        def anatomicalSite = { domain, value ->
            if (value.toString().startsWith('Fluid Specimen-')) {
                return ''
            } else return value
        }

        def exhausted = { domain, value ->
            if (value == true) {
                return 'Yes'
            } else return 'No'
        }

        Map formatters = ["specimen.participant.studySubject.studySubjectIdentifier": gelId, "specimen.anatomicalSite": anatomicalSite, "exhausted":exhausted]
        return formatters
    }

    def getFields(){
        List fields = ["specimen.participant.studySubject.studySubjectIdentifier", "specimen.anatomicalSite", "aliquotType", "blockNumber", "aliquotRanking", "aliquotVolumeMass", "unit", "exhausted"]
        return fields
    }

    def getLabels(){
        Map labels = ["specimen.participant.studySubject.studySubjectIdentifier": "GEL Study ID", "specimen.anatomicalSite": "Anatomical Site", "aliquotType": "Aliquot Type", "blockNumber": "Block Number", "aliquotRanking": "Aliquot Ranking", "aliquotVolumeMass": "Mass", "unit": "Unit","exhausted":"Exhausted"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "Exported Material Supplied", "column.widths": [0.2, 0.3, 0.5]]
        return parameters
    }
}
