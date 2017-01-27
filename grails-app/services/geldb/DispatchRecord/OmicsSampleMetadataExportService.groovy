package geldb.DispatchRecord

import geldb.FluidSpecimen
import geldb.StaffMember
import grails.transaction.Transactional

/**
 * OmicsSampleMetadataExportService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class OmicsSampleMetadataExportService {

    def cleanString (String s){
        s = s?.replace('[','')?.replace(']','')?.replace('null','')?.replace(',','')?.trim()
        return s
    }

    def getFormatters() {
        def gelId = { domain, value ->
            return cleanString(value?.toString())
        }

        def laboratoryID  = { domain, value ->
            return "698D0"
        }

        def clinicSampleType  = { domain, value ->
            if(value?.toString()?.contains('Serum SST')) {
                return "serum"
            }else if(value?.toString()?.contains('Plasma PST')) {
                return "lihep_plasma"
            }else if(value?.toString()?.contains('Blood PAXgene')) {
                return "rna_blood"
            }else if(value?.toString()?.contains('Plasma Strek cfDNA')) {
                return "streck_plasma"
            }else if(value?.toString()?.contains('Plasma EDTA cfDNA')) {
                return "edta_plasma"
            }
        }

        def clinicID  = { domain, value ->
            return "RTH"
        }

        def createdOn  = { domain, value ->
            return value?.toString()?.replace(' ', 'T')?.replace(']', '')?.replace('[', '')?.replace('.0', '')
        }

        def aliquotBarcode  = { domain, value ->
            return value?.toString()?.replace(']', '')?.replace('[', '')
        }

        def laboratorySampleID  = { domain, value ->
            def barcode = domain?.identifiedSample?.barcode
            return barcode?.toString()?.replace(']', '')?.replace('[', '')
        }

        def laboratoryMethod  = { domain, value ->
            return "v2"
        }

        def dispatchDate  = { domain, value ->
            def date = value?.toString()
            if(date){
                return date?.substring(0,10) + "T00:00:00"
            }else{
                return ""
            }
        }

        def volumeUl = { domain, value ->
            def fluidSpecimen = FluidSpecimen?.findById(domain?.identifiedSample?.specimen?.id)
            if (fluidSpecimen){
                return value
            }else{
                return ""
            }
        }


        def laboratoryRemainingVolumeBanked  = { domain, value ->
            def fluidSpecimen = FluidSpecimen?.findById(domain?.identifiedSample?.specimen?.id)
            if (fluidSpecimen){
                return "0"
            }else{
                return ""
            }
        }

        Map formatters = ["identifiedSample.specimen.participant.studySubject.studySubjectIdentifier" : gelId,'clinicID':clinicID,
                          "identifiedSample.createdOn":createdOn,"identifiedSample.aliquotType.aliquotTypeName": clinicSampleType, "identifiedSample.barcode":aliquotBarcode, "laboratoryID":laboratoryID,
                          "laboratoryMethod":laboratoryMethod, "laboratoryRemainingVolumeBanked":laboratoryRemainingVolumeBanked, "dispatchedBox.dispatchRecord.sentOn":dispatchDate,
                          "volume_ul":volumeUl, "laboratorySampleID":laboratorySampleID
        ]

        return formatters
    }

    def getFields(){
        List fields = ["identifiedSample.specimen.participant.studySubject.studySubjectIdentifier","clinicID","identifiedSample.barcode",
                       "identifiedSample.aliquotType.aliquotTypeName", "identifiedSample.createdOn","laboratoryID", "laboratorySampleID", "laboratoryMethod",
                       "volume_ul", "laboratoryRemainingVolumeBanked","dispatchedBox.dispatchRecord.sentOn", "dispatchedBox.dispatchRecord.consignmentNumber",
                       "positionIfPlated", "dispatchedBox.barcode","", "", "", "", "", "", "","", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
                       "", "", "", "", "", "", "", "", ""
        ]

        return fields
    }


    def getParameters(){
        Map parameters = [title: "GMC GEL Sample Metadata Cancer","header.enabled":false, "column.widths": [0.2, 0.3, 0.5], "lineEnd":"\r\n", "quoteCharacter": "\u0000"]
        return parameters
    }
}
