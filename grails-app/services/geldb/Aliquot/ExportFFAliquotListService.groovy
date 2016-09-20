package geldb.Aliquot

import geldb.Aliquot
import geldb.AliquotType
import geldb.Participant
import geldb.Specimen
import grails.transaction.Transactional
/**
 * ExportFFAliquotListService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportFFAliquotListService {

    def getFormatters(){

        def gelID = { domain, value ->
            return value?.toString()?.replace('[','')?.replace(']','')?.replace(' ','')?.replace(',','')?.replace('null','')
        }

        def ffAliquotsNumber = { domain, value ->
            def ffAliquots = Aliquot.findAllBySpecimenAndAliquotType(Specimen.findById(domain?.id), AliquotType.findByAliquotTypeName('Punch Biopsy Frozen'))
            return ffAliquots?.size()
        }

        Map formatters = ["participant.studySubject.studySubjectIdentifier": gelID, "aliquot": ffAliquotsNumber]
        return formatters
    }

    def getFields(){
        List fields = ["participant.studySubject.studySubjectIdentifier", "anatomicalSite", "aliquot"]
        return fields
    }

    def getLabels(){
        Map labels = ["participant.studySubject.studySubjectIdentifier": "Gel/Participant Id ", "anatomicalSite": "Cancer Type", "aliquot":"Number of FF Aliquots"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "FF Aliquots List", "column.widths": [0.25, 0.25, 0.25]]
        return parameters
    }
}
