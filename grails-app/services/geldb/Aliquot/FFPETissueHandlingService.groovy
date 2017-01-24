package geldb.Aliquot

import grails.transaction.Transactional

/**
 * FFPETissueHandlingService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class FFPETissueHandlingService {

    def getFormatters(){
        def tissueBlockSize =  { domain, value ->
            def blockNumber = domain?.blockNumber
            if (blockNumber){
                blockNumber = blockNumber.toString().split(',')
                if(blockNumber.size() > 2){
                    return blockNumber[2]?.trim()
                }else{
                    return ""
                }
            }
        }

        def blockNumber =  { domain, value ->
            def blockNumber = domain?.blockNumber
            if(blockNumber){
                blockNumber = blockNumber.toString().split(',')
                if(blockNumber.size()>0){
                    return blockNumber[0]?.trim()
                }else{
                    return ""
                }
            }
        }

        def gelID = { domain, value ->
            return value?.toString()?.replace('[','')?.replace(']','')?.replace(' ','')?.replace(',','')?.replace('null','')
        }

        def clean = { domain, value ->
            return value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
        }

        Map formatters = ["Tissue Block Size":tissueBlockSize, "blockNumber":blockNumber, "specimen.participant.studySubject.studySubjectIdentifier":gelID,
                          "specimen.fFPE_Tissue_Report.cold_ischaemia.period": clean, "specimen.anatomicalSite":clean,"specimen.fFPE_Tissue_Report.fixationType":clean,
                          "specimen.fFPE_Tissue_Report.fixationPeriod":clean, "specimen.fFPE_Tissue_Report.tumourType.tumourType":clean,"gelSuitabilityReport.cellularity": clean,
                          "gelSuitabilityReport.percentageNecrosis":clean, "fixationReport.fixationTypeAliquot":clean,"fixationReport.fixationPeriodAliquot":clean,
                          "fixationReport.processingScheduleAliquot":clean
        ]
        return formatters
    }

    def getFields(){
        List fields = ["specimen.participant.studySubject.studySubjectIdentifier", "specimen.anatomicalSite", "specimen.fFPE_Tissue_Report.cold_ischaemia.period","Tissue Block Size",
                       "blockNumber", "specimen.fFPE_Tissue_Report.fixationType", "specimen.fFPE_Tissue_Report.fixationPeriod","fixationReport.fixationTypeAliquot","fixationReport.fixationPeriodAliquot",
                       "fixationReport.processingScheduleAliquot", "specimen.fFPE_Tissue_Report.tumourType.tumourType", "gelSuitabilityReport.cellularity", "gelSuitabilityReport.percentageNecrosis"]
        return fields
    }

    def getLabels(){
        Map labels = ["specimen.participant.studySubject.studySubjectIdentifier":"Patient GeL ID", "specimen.anatomicalSite":"Tissue type", "specimen.fFPE_Tissue_Report.cold_ischaemia.period":"Cold Ischaemia time",
                      "blockNumber":"Tissue Block ID", "specimen.fFPE_Tissue_Report.fixationType":"Fixative (Main Specimen)", "specimen.fFPE_Tissue_Report.fixationPeriod":"Fixation time (Main Specimen)",
                      "fixationReport.fixationTypeAliquot": "Fixative (Genomic Block)","fixationReport.fixationPeriodAliquot":"Fixation time (Genomic Block)","specimen.fFPE_Tissue_Report.tumourType.tumourType":"Tumour type e.g NSCLC (if known)", "gelSuitabilityReport.cellularity":"Tumour sample cellularity",
                      "gelSuitabilityReport.percentageNecrosis":"% necrosis", "fixationReport.processingScheduleAliquot":"Processing Schedule"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "FFPE Tissue", "column.widths": [0.15, 0.15, 0.2, 0.2, 0.15, 0.4, 0.2, 0.4, 0.2, 0.2, 0.4, 0.2, 0.1]]
        return parameters
    }
}
