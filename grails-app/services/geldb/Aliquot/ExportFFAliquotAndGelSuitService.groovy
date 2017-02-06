package geldb.Aliquot

import geldb.Aliquot
import geldb.AliquotType
import geldb.Specimen
import grails.transaction.Transactional

/**
 * ExportFFAliquotAndGelSuitService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportFFAliquotAndGelSuitService {

    def getFormatters(){
        def gelID = { domain, value ->
            return value?.toString()?.replace('[','')?.replace(']','')?.replace(' ','')?.replace(',','')?.replace('null','')
        }

        def clean = { domain, value ->
            return value?.toString()?.replace('[','')?.replace(']','')?.replace(',','')?.replace('null','')
        }

        Map formatters = ["specimen.participant.studySubject.studySubjectIdentifier": gelID, "gelSuitabilityReport.percentageTumourContent":clean,
                          "gelSuitabilityReport.percentageNecrosis":clean, "gelSuitabilityReport.cellularity":clean]
        return formatters
    }

    def getFields(){
        List fields = ["specimen.participant.studySubject.studySubjectIdentifier", "barcode", "specimen.anatomicalSite", "gelSuitabilityReport.percentageTumourContent",
                       "gelSuitabilityReport.percentageNecrosis", "gelSuitabilityReport.cellularity"]
        return fields
    }

    def getLabels(){
        Map labels = ["specimen.participant.studySubject.studySubjectIdentifier": "Gel/Participant Id ", "specimen.anatomicalSite": "Cancer Type",
                      "barcode":"Barcode", "gelSuitabilityReport.percentageTumourContent":"Percentage Tumour Content", "gelSuitabilityReport.percentageNecrosis":"Percentage Necrosis",
                      "gelSuitabilityReport.cellularity":"Cellularity"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "FF Aliquots List", "column.widths": [0.2, 0.2, 0.25, 0.2, 0.2, 0.1]]
        return parameters
    }
}
