package geldb.Aliquot

import geldb.AliquotType
import geldb.DNA_Extract
import grails.transaction.Transactional

/**
 * ExportFFPEListService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportFFPEListService {

    def getFormatters(){

        def gelID = { domain, value ->
            return value?.toString()?.replace('[','')?.replace(']','')?.replace(' ','')?.replace(',','')?.replace('null','')
        }

        def clean = { domain, value ->
            return value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
        }

        def ffDNA = { domain, value ->
            def ffDNAExtract = DNA_Extract.createCriteria().list{
                aliquot {
                    eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy Frozen'))
                }
            }
            def passFail = ffDNAExtract.find{d -> d?.aliquot?.specimen?.participant?.first() == domain?.specimen?.participant}?.passFail
            if (passFail) {
                return 'Pass'
            } else if(passFail == null){
                return ''
            } else return 'Fail'
        }

        Map formatters = ["specimen.participant.studySubject.studySubjectIdentifier": gelID, "specimen.fFPE_Tissue_Report.fixationPeriod": clean, "FF DNA Pass/Fail QC": ffDNA]
        return formatters
    }

    def getFields(){
        List fields = ["specimen.participant.studySubject.studySubjectIdentifier", "aliquotType", "specimen.fFPE_Tissue_Report.fixationPeriod", "FF DNA Pass/Fail QC"]
        return fields
    }

    def getLabels(){
        Map labels = ["specimen.participant.studySubject.studySubjectIdentifier": "Gel Id ", "aliquotType": "Aliquot Type", "specimen.fFPE_Tissue_Report.fixationPeriod": "Fixation Period"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "FFPE List", "column.widths": [0.25, 0.25, 0.25, 0.25]]
        return parameters
    }
}
