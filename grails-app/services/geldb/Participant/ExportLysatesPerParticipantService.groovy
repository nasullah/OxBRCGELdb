package geldb.Participant

import geldb.Aliquot
import geldb.AliquotType
import geldb.FluidSpecimen
import geldb.SolidSpecimen
import grails.transaction.Transactional

/**
 * ExportParticipantService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportLysatesPerParticipantService {

    def cleanString (String s){
        s = s?.replace('[','')?.replace(']','')?.replace('null','')?.replace(',','')?.trim()
        return s
    }

    def getFormatters(){
        def gelId = { domain, value ->
            return cleanString(value?.toString())
        }

        def anatomicalSite = { domain, value ->
            def solidSpecimenList = SolidSpecimen.findAllByParticipant(domain)
            if(!solidSpecimenList?.empty){
                return solidSpecimenList?.anatomicalSite?.toString()?.replace('[','')?.replace(']','')
            }else {
                return ""
            }
        }

        def totalLysate= { domain, value ->
            def aliquots = Aliquot.findAllByAliquotTypeAndSpecimenInList(AliquotType.findByAliquotTypeName('All Prep Lysate'), domain.specimen)
            return aliquots?.size()
        }

        def noneExhaustedLysate= { domain, value ->
            def aliquots = Aliquot.findAllByAliquotTypeAndSpecimenInListAndExhausted(AliquotType.findByAliquotTypeName('All Prep Lysate'), domain.specimen, false)
            return aliquots?.size()
        }

        Map formatters = ["studySubject.studySubjectIdentifier":gelId, "Anatomical Site":anatomicalSite, "Total Lysate":totalLysate,
                          "None-exhausted Lysate":noneExhaustedLysate]
        return formatters
    }

    def getFields(){
        List fields = ["studySubject.studySubjectIdentifier", "hospitalNumber", "Anatomical Site", "Total Lysate", "None-exhausted Lysate"]
        return fields
    }

    def getLabels(){
        Map labels = ["hospitalNumber":"Hospital Number", "studySubject.studySubjectIdentifier":"GEL Study ID"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "Lysates Per Participant", "column.widths": [0.2, 0.2, 0.2, 0.15, 0.2]]
        return parameters
    }
}
