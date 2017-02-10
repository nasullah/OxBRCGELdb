package geldb.DispatchRecord

import geldb.DNA_Extract
import geldb.SolidSpecimen
import grails.transaction.Transactional

/**
 * AllDispatchedOmicsSamplesService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class AllDispatchedOmicsSamplesService {

    def getFormatters() {
        def formatParticipantID = { domain, value ->
            return value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')?.replace(',','')?.trim()
        }

        def aliquotType = { domain, value ->
            return value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
        }

        def aliquotBarcode = { domain, value ->
            return value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
        }

        def dispatchDate  = { domain, value ->
            def date = value?.toString()
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

        Map formatters = ["identifiedSample.specimen.participant.studySubject.studySubjectIdentifier": formatParticipantID,
                          "identifiedSample.aliquotType.aliquotTypeName":aliquotType, "dispatchedBox.dispatchRecord.sentOn": dispatchDate,
                           "identifiedSample.specimen.fFPE_Tissue_Report.tumourType.tumourLocation":tumourType, "identifiedSample.barcode":aliquotBarcode]
        return formatters
    }

    def getFields(){
        List fields = ["identifiedSample.specimen.participant.studySubject.studySubjectIdentifier", "identifiedSample.specimen.fFPE_Tissue_Report.tumourType.tumourLocation",
                       "identifiedSample.barcode", "dispatchedBox.dispatchRecord.consignmentNumber", "identifiedSample.aliquotType.aliquotTypeName", "dispatchedBox.dispatchRecord.sentOn"]
        return fields
    }

    def getLabels(){
        Map labels = ["identifiedSample.specimen.participant.studySubject.studySubjectIdentifier": "Participant ID", "identifiedSample.barcode": "Sample ID",
                      "dispatchedBox.dispatchRecord.consignmentNumber": "Consignment Number", "dispatchedBox.dispatchRecord.sentOn": "Date Dispatched",
                      "identifiedSample.aliquotType.aliquotTypeName": "Aliquot Type", "identifiedSample.specimen.fFPE_Tissue_Report.tumourType.tumourLocation":"Cancer Type"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "Dispatched Items", "column.widths": [0.2, 0.15, 0.2, 0.2, 0.3, 0.2]]
        return parameters
    }
}
