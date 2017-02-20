package geldb.DispatchRecord

import geldb.DNA_Extract
import geldb.SolidSpecimen
import grails.transaction.Transactional

/**
 * AllDispatchedDNASamplesService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class AllDispatchedDNASamplesService {

    def getFormatters() {
        def formatParticipantID = { domain, value ->
            return value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')?.replace(',','')?.trim()
        }

        def aliquotType = { domain, value ->
            return value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
        }

        def clean = { domain, value ->
            return value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
        }

        def aliquotBarcode = { domain, value ->
            return value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
        }

        def dNAConcentrationQubit = { domain, value ->
            if (DNA_Extract.findById(domain.identifiedSample.id)){
                return value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
            }else{
                return ''
            }
        }

        def dNAAmount = { domain, value ->
            if (DNA_Extract.findById(domain.identifiedSample.id)){
                return value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
            }else{
                return ''
            }
        }

        def formatDate  = { domain, value ->
            def date = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
            if(date){
                return date?.substring(0,10)
            }else{
                return ""
            }
        }

        def tumourType = { domain, value ->
            if (value.toString()?.startsWith('[Fluid Specimen-')) {
                def patient = domain?.identifiedSample?.aliquot?.first()?.specimen?.participant
                if (patient){
                    def tumour = SolidSpecimen?.findByParticipant(patient)?.fFPE_Tissue_Report
                    if (!tumour?.empty){
                        return tumour?.first()?.tumourType?.tumourLocation
                    }else{
                        return ""
                    }
                }
                else{
                    return ""
                }
            } else if (value.toString()?.startsWith('Fluid Specimen-')) {
                def patient = domain?.identifiedSample?.specimen?.participant
                if (patient){
                    def tumour = SolidSpecimen?.findByParticipant(patient)?.fFPE_Tissue_Report
                    if (!tumour?.empty){
                        return tumour?.first()?.tumourType?.tumourLocation
                    }else{
                        return ""
                    }
                }
                else{
                    return ""
                }
            } else {
                def tumour = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
                if (tumour){
                    return tumour
                }else{
                    return ""
                }
            }
        }

        Map formatters = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier": formatParticipantID,
                          "identifiedSample.aliquot.aliquotType.aliquotTypeName":aliquotType, "dispatchedBox.dispatchRecord.sentOn": formatDate,
                          "identifiedSample.dNAConcentrationQubit": dNAConcentrationQubit, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourType.tumourLocation":tumourType,
                          "identifiedSample.aliquot.barcode":aliquotBarcode, "identifiedSample.dNAAmount": dNAAmount,  "identifiedSample.aliquot.fixationReport.fixationTypeAliquot":clean,
                          "identifiedSample.aliquot.fixationReport.processingScheduleAliquot":clean, "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot":formatDate,
                          "identifiedSample.aliquot.fixationReport.fixationStartTimeAliquot":clean, "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot":formatDate,
                          "identifiedSample.aliquot.fixationReport.fixationEndTimeAliquot":clean, "identifiedSample.aliquot.fixationReport.fixationPeriodAliquot":clean,
                          "identifiedSample.aliquot.fixationReport.fixationTimeUnknownAliquot":clean, "identifiedSample.aliquot.fixationReport.comments":clean,
                          "identifiedSample.aliquot.fixationReport.timeInProcessor":clean]
        return formatters
    }

    def getFields(){
        List fields = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourType.tumourLocation",
                       "identifiedSample.barcode", "dispatchedBox.dispatchRecord.consignmentNumber", "identifiedSample.aliquot.aliquotType.aliquotTypeName", "identifiedSample.aliquot.barcode",
                       "dispatchedBox.dispatchRecord.sentOn", "identifiedSample.dNAConcentrationQubit", "identifiedSample.dNAAmount", "identifiedSample.aliquot.fixationReport.fixationTypeAliquot",
                       "identifiedSample.aliquot.fixationReport.processingScheduleAliquot", "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot", "identifiedSample.aliquot.fixationReport.fixationStartTimeAliquot",
                       "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot", "identifiedSample.aliquot.fixationReport.fixationEndTimeAliquot", "identifiedSample.aliquot.fixationReport.fixationPeriodAliquot",
                       "identifiedSample.aliquot.fixationReport.fixationTimeUnknownAliquot", "identifiedSample.aliquot.fixationReport.comments", "identifiedSample.aliquot.fixationReport.timeInProcessor"]
        return fields
    }

    def getLabels(){
        Map labels = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier": "Participant ID", "identifiedSample.barcode": "Sample ID",
                      "dispatchedBox.dispatchRecord.consignmentNumber": "Consignment Number", "identifiedSample.dNAConcentrationQubit": "DNA Concentration (Qubit)",
                      "dispatchedBox.dispatchRecord.sentOn": "Date Dispatched", "identifiedSample.aliquot.aliquotType.aliquotTypeName": "Aliquot Type",
                      "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourType.tumourLocation":"Cancer Type", "identifiedSample.aliquot.barcode":"Aliquot Barcode",
                      "identifiedSample.dNAAmount":"DNA Volume", "identifiedSample.aliquot.fixationReport.fixationTypeAliquot":"Fixation Type", "identifiedSample.aliquot.fixationReport.processingScheduleAliquot":"Processing Schedule",
                      "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot":"Fixation Start Date", "identifiedSample.aliquot.fixationReport.fixationStartTimeAliquot":"Fixation Start Time",
                      "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot":"Fixation End Date", "identifiedSample.aliquot.fixationReport.fixationEndTimeAliquot":"Fixation End Time",
                      "identifiedSample.aliquot.fixationReport.fixationPeriodAliquot":"Fixation Period", "identifiedSample.aliquot.fixationReport.fixationTimeUnknownAliquot":"Fixation Time Unknown",
                      "identifiedSample.aliquot.fixationReport.comments":"Fixation comments", "identifiedSample.aliquot.fixationReport.timeInProcessor":"Time In Processor"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "Dispatched Items", "column.widths": [0.2, 0.15, 0.2, 0.2, 0.3, 0.2, 0.2, 0.25, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.15, 0.25, 0.2, 0.2]]
        return parameters
    }
}
