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

        def formatDate = { domain, value ->
            value = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
            if (value.size() > 10){
                return value?.toString()?.substring(0, 10)
            }else {
                return value
            }
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

        Map formatters = ["specimen.participant.studySubject.studySubjectIdentifier": gelID, "fixationReport.fixationPeriodAliquot": clean, "FF DNA Pass/Fail QC": ffDNA,
                          "fixationReport.fixationStartDateAliquot":formatDate, "fixationReport.fixationStartTimeAliquot":clean, "fixationReport.fixationEndDateAliquot":formatDate,
                          "fixationReport.fixationEndTimeAliquot":clean, "fixationReport.timeInProcessor":clean]
        return formatters
    }

    def getFields(){
        List fields = ["specimen.participant.studySubject.studySubjectIdentifier", "aliquotType", "fixationReport.fixationPeriodAliquot", "fixationReport.fixationStartDateAliquot",
                       "fixationReport.fixationStartTimeAliquot", "fixationReport.fixationEndDateAliquot", "fixationReport.fixationEndTimeAliquot", "fixationReport.timeInProcessor",
                       "FF DNA Pass/Fail QC"]
        return fields
    }

    def getLabels(){
        Map labels = ["specimen.participant.studySubject.studySubjectIdentifier": "Gel Id ", "aliquotType": "Aliquot Type", "fixationReport.fixationPeriodAliquot": "Fixation Period",
                      "fixationReport.fixationStartDateAliquot":"Fixation Start Date", "fixationReport.fixationStartTimeAliquot":"Fixation Start Time", "fixationReport.fixationEndDateAliquot":"Fixation End Date",
                      "fixationReport.fixationEndTimeAliquot":"Fixation End Time", "fixationReport.timeInProcessor":"Time in Formalin"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "FFPE List", "column.widths": [0.2, 0.25, 0.25, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2]]
        return parameters
    }
}
