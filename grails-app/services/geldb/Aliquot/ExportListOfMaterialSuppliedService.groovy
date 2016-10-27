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

        def suitableForGel = { domain, value ->
            value = value.toString().replace('[', '').replace(']', '').replace('null', '')
            print(value)
            if (value.toString().startsWith('Fluid Specimen-')) {
                return ''
            }else if (value == 'true') {
                return 'Yes'
            }else if (value == 'false') {
                return 'No'
            }
            else return ''
        }

        def createdOnFormat = { domain, value ->
                return value?.format('yyyy-MM-dd')
        }

        Map formatters = ["specimen.participant.studySubject.studySubjectIdentifier": gelId, "specimen.anatomicalSite": anatomicalSite, "exhausted":exhausted,
                          "gelSuitabilityReport.suitableForGel":suitableForGel, "createdOn":createdOnFormat]
        return formatters
    }

    def getFields(){
        List fields = ["specimen.participant.studySubject.studySubjectIdentifier", "specimen.anatomicalSite", "aliquotType", "blockNumber", "aliquotRanking",
                       "aliquotVolumeMass", "unit", "exhausted", "createdOn", "gelSuitabilityReport.suitableForGel"]
        return fields
    }

    def getLabels(){
        Map labels = ["specimen.participant.studySubject.studySubjectIdentifier": "GEL Study ID", "specimen.anatomicalSite": "Anatomical Site", "aliquotType": "Aliquot Type", "blockNumber": "Block Number",
                      "aliquotRanking": "Aliquot Ranking", "aliquotVolumeMass": "Mass", "unit": "Unit","exhausted":"Exhausted", "gelSuitabilityReport.suitableForGel":"Suitable for GEL",
                      "createdOn":"Created on"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "Exported Material Supplied", "column.widths": [0.2, 0.15, 0.25, 0.15, 0.15, 0.1, 0.1, 0.1, 0.1, 0.2]]
        return parameters
    }
}
