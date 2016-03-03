package geldb.Participant

import grails.transaction.Transactional

/**
 * ExportParticipantService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportParticipantService {

    def cleanString (String s){
        s = s?.replace('[','')?.replace(']','')?.replace('null','')?.replace(',','')?.trim()
        return s
    }

    def getFormatters(){
        def gelId = { domain, value ->
            return cleanString(value?.toString())
        }
        def consentType = { domain, value ->
            return value.toString().replace('[','').replace(']','').replace('null','').trim()
        }
        def dateOfBirth = { domain, value ->
            if (value.toString().size() > 10){
                return value.toString().substring(0, 10)
            }else {
                return value
            }
        }
        Map formatters = ["studySubject.studySubjectIdentifier":gelId, "studySubject.study":consentType, "dateOfBirth":dateOfBirth]
        return formatters
    }

    def getFields(){
        List fields = ["studySubject.studySubjectIdentifier", "studySubject.study", "familyName", "givenName","dateOfBirth","gender","nHSNumber","hospitalNumber","diagnosis","centre"]
        return fields
    }

    def getLabels(){
        Map labels = ["familyName":"Family Name", "givenName":"Given Name", "dateOfBirth":"Date of Birth", "gender":"Gender", "nHSNumber":"NHS Number", "hospitalNumber":"Hospital Number", "diagnosis":"Diagnosis", "centre":"Centre", "studySubject.studySubjectIdentifier":"GEL Study ID", "studySubject.study":"Consent Type"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "Participants", "column.widths": [0.2, 0.3, 0.2, 0.2, 0.15, 0.15, 0.2, 0.2, 0.5, 0.1]]
        return parameters
    }
}
