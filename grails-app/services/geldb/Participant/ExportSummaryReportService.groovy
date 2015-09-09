package geldb.Participant

import grails.transaction.Transactional

/**
 * ExportSummaryReportService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportSummaryReportService {

    def getFormatters(){
        def gelId = { domain, value ->
            return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
        }
        def consentType = { domain, value ->
            return value.toString().replace('[','').replace(']','').replace('null','')
        }
        Map formatters = ["studySubject.studySubjectIdentifier":gelId, "studySubject.study":consentType]
        return formatters
    }

    def getFields(){
        List fields = ["studySubject.studySubjectIdentifier","studySubject.study"]
        return fields
    }

    def getLabels(){
        Map labels = ["studySubject.studySubjectIdentifier":"GEL Study ID", "studySubject.study":"Consent Type"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "Exported Summary Report", "column.widths": [0.2, 0.3, 0.5]]
        return parameters
    }
}
