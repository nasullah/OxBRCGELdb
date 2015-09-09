package geldb.DNAExtract

import grails.transaction.Transactional

/**
 * ExportKPIReportService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportKPIReportService {

    def getFormatters(){
        def gelId = { domain, value ->
            return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
        }
        def anatomicalSite = { domain, value ->
            if (value.toString().startsWith('Fluid Specimen-')) {
                return ''
            } else return value
        }
        Map formatters = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier":gelId, "aliquot.specimen.anatomicalSite":anatomicalSite]
        return formatters
    }

    def getFields(){
        List fields = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier","aliquot.specimen.anatomicalSite", "aliquot.aliquotType", "aliquot.blockNumber", "aliquot.aliquotRanking", "aliquot.aliquotVolumeMass", "aliquot.unit", "test2", "test3", "test4", "test5","test6","test7", "test8"]
        return fields
    }

    def getLabels(){
        Map labels = ["aliquot.specimen.participant.studySubject.studySubjectIdentifier":"GEL Study ID", "aliquot.specimen.anatomicalSite":"Patients approached", "aliquot.aliquotType":"Patients consented", "aliquot.blockNumber":"FF QC fails diagnosis ineligible for GeL", "aliquot.aliquotRanking":"FF QC fails insufficient tissue", "aliquot.aliquotVolumeMass":"FF QC fails insufficient DNA",
                      "aliquot.unit":"FFPE QC fails diagnosis ineligible for GeL", "test2":"FFPE QC fails insufficient tissue", "test3":"FFPE QC fails insufficient DNA", "test4":"Blood sample fails insufficient DNA", "test5":"Number of blood samples collected awaiting for matched tumou", "test6":"Number of tumour collected awaiting for blood sample", "test7":"Pairs awaiting for dispatch", "test8":" Pairs sent"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "KPI Report", "column.widths": [0.2, 0.3, 0.5]]
        return parameters
    }
}
