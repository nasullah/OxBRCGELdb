package geldb.DispatchRecord

import geldb.DNA_Extract
import grails.transaction.Transactional

/**
 * AllDispatchedSamplesDataService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class AllDispatchedSamplesDataService {

    def cleanString (String s){
        s = s?.replace('[','')?.replace(']','')?.replace('null','')?.replace(',','')?.trim()
        return s
    }

    def getFormatters() {
        def gelId = { domain, value ->
            return cleanString(value?.toString())
        }

        def clean = {domain, value ->
            value = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
            return value
        }

        def cleanFluid = { domain, value ->
            if (value?.toString()?.startsWith('[Main Specimen-')) {
                return ""
            } else {
                value = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
                return value
            }
        }

        def cleanMain = { domain, value ->
            if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                return ""
            } else {
                value = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
                return value
            }
        }

        def tumourType = { domain, value ->
            if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                return ''
            } else return cleanString(value?.toString())
        }

        def laboratoryID  = { domain, value ->
            return "698D0"
        }

        def clinicID  = { domain, value ->
            return "RTH"
        }

        def extractionDate  = { domain, value ->
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

        def morphology = { domain, value ->
            if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                return ''
            } else {
                def code = value?.findResult {it?.size() ? it : null}
                if(code){
                    code = code?.toString()?.replace('[','')?.replace(']','')?.replace(' ','')
                    def list = code?.toString()?.split(',')
                    list = list?.findAll {s -> s?.startsWith('M')}
                    return list?.toString()?.replace('[','')?.replace(']','')
                }
                return ''
            }
        }

        def provenance = { domain, value ->
            if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                return ''
            } else {
                return cleanString(value?.toString())
            }
        }

        def topography = { domain, value ->
            if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                return ''
            } else {
                def code = value?.findResult {it?.size() ? it : null}
                if(code){
                    code = code?.toString()?.replace('[','')?.replace(']','')?.replace(' ','')
                    def list = code?.toString()?.split(',')
                    list = list?.findAll{s -> s?.startsWith('T')}
                    return list?.toString()?.replace('[','')?.replace(']','')
                }
                return ''
            }
        }

        def macrodissection = { domain, value ->
            if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                def macro = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                if (macro) {
                    if (macro == 'true') {
                        return "yes"
                    } else {
                        return "no"
                    }
                } else {
                    return ""
                }
            }else {
                return ""
            }
        }

        def macrodissectionDetails = { domain, value ->
            if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                def details = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                if (details) {
                    return details
                } else {
                    return ""
                }
            }else {
                return ""
            }
        }

        def fixationStartDate = { domain, value ->
            if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                return ''
            } else {
                if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                    def fixationStartTime = domain?.identifiedSample?.aliquot?.fixationReport?.fixationStartTimeAliquot
                    fixationStartTime = fixationStartTime?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                    def startDate = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                    if (startDate && fixationStartTime) {
                        return startDate?.substring(0, 10) + "T" + fixationStartTime + ":00"
                    } else if (startDate && !fixationStartTime){
                        return startDate?.substring(0, 10) + "T00:00:00"
                    } else {
                        return ""
                    }
                }else{
                    return ""
                }
            }
        }

        def fixationEndDate = { domain, value ->
            if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                return ''
            } else {
                if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                    def fixationEndTime = domain?.identifiedSample?.aliquot?.fixationReport?.fixationEndTimeAliquot
                    fixationEndTime = fixationEndTime?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                    def endDate = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                    if (endDate && fixationEndTime) {
                        return endDate?.substring(0, 10) + "T" + fixationEndTime+ ":00"
                    } else if (endDate && !fixationEndTime) {
                        return endDate?.substring(0, 10) + "T00:00:00"
                    }else {
                        return ""
                    }
                }else{
                    return ""
                }
            }
        }

        def fixationType = { domain, value ->
            if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                return ''
            } else {
                if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                    def type = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                    if (type == 'Nonbuffered formalin FOR') {
                        return "Formal saline"
                    } else if (type == 'Neutral buffered formalin NBF') {
                        return "Neutral buffered Formalin"
                    }else if (type == 'Other ZZZ') {
                        return "Other"
                    }
                }else{
                    return ""
                }
            }
        }

        def fixationComments = { domain, value ->
            if (value?.toString()?.startsWith('[Fluid Specimen-')) {
                return ''
            } else {
                if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')) {
                    def comments = value?.toString()?.replace('[', '')?.replace(']', '')?.replace('null', '')
                    if (comments) {
                        return comments
                    } else {
                        return ""
                    }
                }else{
                    return ""
                }
            }
        }

        def excisionMargin = { domain, value ->
            if(domain?.identifiedSample?.aliquot?.specimen?.toString()?.contains('[Fluid Specimen-')){
                return ''
            } else {
                return '99'
            }
        }

        def processingSchedule = { domain, value ->
            if (value.toString()?.startsWith('[Fluid Specimen-')) {
                return ''
            } else {
                if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')){
                    def schedule = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
                    if (schedule){
                        return schedule?.toLowerCase()?.replace(' ','_')
                    }else{
                        return ""
                    }
                }else{
                    return ""
                }
            }
        }

        def volumeUl = { domain, value ->
            return value
        }

        def laboratoryRemainingVolumeBanked  = { domain, value ->
            if (domain?.identifiedSample?.aliquot?.specimen?.toString()?.startsWith('[Fluid Specimen-')) {
                return "0"
            }else{
                def elution = DNA_Extract?.findById(domain?.identifiedSample?.id)?.sapphireIdentifier
                if (elution){
                    elution = elution?.toString() + '_Remaining'
                    def remainingVolume = DNA_Extract?.findBySapphireIdentifier(elution)?.dNAAmount
                    if (remainingVolume){
                        return remainingVolume
                    }else{
                        return "0"
                    }
                }
            }
        }

        def timeInProcessor = { domain, value ->
            if (value.toString()?.startsWith('[Fluid Specimen-')) {
                return ""
            } else {
                if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy FFPE')){
                    def time = value?.toString()?.replace('[','')?.replace(']','')?.replace('null','')
                    if (time){
                        return time
                    }else{
                        return ""
                    }
                }else{
                    return ""
                }
            }
        }

        def extractionProtocol = { domain, value ->
            return value
        }

        def tumourSampleType = { domain, value ->
            if (value.toString()?.startsWith('[Fluid Specimen-')) {
                return ''
            } else {
                if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Punch Biopsy')
                        || domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('All Prep Lysate')) {
                    return 'cores'
                }else if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Section')) {
                    return 'sections'
                }
                else if(domain?.identifiedSample?.aliquot?.aliquotType?.aliquotTypeName?.toString()?.contains('Scroll')) {
                    return 'scrolls'
                }else {
                    return ""
                }
            }
        }

        Map formatters = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : gelId,'clinicID':clinicID,"identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourStatus":tumourType,
                          "identifiedSample.aliquot.specimen.participant.nHSNumber":clean, "identifiedSample.aliquot.specimen.participant.diagnosis":clean,
                          "identifiedSample.extractionDate":extractionDate,"identifiedSample.aliquot.aliquotType": clean, "identifiedSample.barcode":aliquotBarcode, "laboratoryID":laboratoryID,
                          "Laboratory Method":laboratoryMethod, "laboratoryRemainingVolumeBanked":laboratoryRemainingVolumeBanked, "dispatchedBox.dispatchRecord.sentOn":dispatchDate,
                          "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed.snomedCode" :morphology, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.sampleType":provenance,
                          "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed" :topography, "identifiedSample.aliquot.gelSuitabilityReport.microdissectionDetails":macrodissectionDetails,
                          "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot":fixationStartDate, "identifiedSample.aliquot.fixationReport.fixationTypeAliquot":fixationType,
                          "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot":fixationEndDate, "identifiedSample.aliquot.fixationReport.fixationCommentsAliquot":fixationComments,
                          "identifiedSample.aliquot.fixationReport.processingScheduleAliquot":processingSchedule, "volume_ul":volumeUl, "laboratorySampleID":laboratorySampleID, "Excision Margin":excisionMargin,
                          "identifiedSample.aliquot.fixationReport.timeInProcessor": timeInProcessor, "identifiedSample.aliquot.unit":clean, "identifiedSample.aliquot.aliquotVolumeMass":clean, "identifiedSample.extractionKit":extractionProtocol, "Tumour Sample Type":tumourSampleType,
                          "identifiedSample.aliquot.gelSuitabilityReport.microdissection":macrodissection, "identifiedSample.aliquot.specimen.collectionDate":clean,
                          "identifiedSample.aliquot.derivedFrom":clean, "identifiedSample.aliquot.exhausted":clean, "identifiedSample.aliquot.notes":clean, "identifiedSample.aliquot.blockNumber":clean,
                          "identifiedSample.aliquot.barcode":clean, "identifiedSample.aliquot.position":clean, "identifiedSample.aliquot.sapphireIdentifier":clean, "identifiedSample.aliquot.aliquotRanking":clean,
                          "identifiedSample.aliquot.createdOn":clean, "identifiedSample.aliquot.frozenBy":clean, "identifiedSample.aliquot.gelSuitabilityReport.reportDate":clean, "identifiedSample.aliquot.gelSuitabilityReport.reportStaff":clean,
                          "identifiedSample.aliquot.gelSuitabilityReport.comments":clean, "identifiedSample.aliquot.gelSuitabilityReport.handE_pathreview":clean, "identifiedSample.aliquot.gelSuitabilityReport.slideMarkedBy":clean,
                          "identifiedSample.aliquot.gelSuitabilityReport.sideMarkedDate":clean, "identifiedSample.aliquot.gelSuitabilityReport.percentageTumourContent":clean, "identifiedSample.aliquot.gelSuitabilityReport.tumourContentVerifiedBy":clean,
                          "identifiedSample.aliquot.gelSuitabilityReport.tumourContentVerificationOther":clean, "identifiedSample.aliquot.gelSuitabilityReport.cellularity":clean, "identifiedSample.aliquot.gelSuitabilityReport.percentageNecrosis":clean,
                          "identifiedSample.aliquot.gelSuitabilityReport.dysplasticNonInvasiveElements":clean, "identifiedSample.aliquot.gelSuitabilityReport.dysplasticNonInvasiveNotes":clean, "identifiedSample.aliquot.gelSuitabilityReport.pathologistComments":clean,
                          "identifiedSample.aliquot.gelSuitabilityReport.suitableForGel":clean, "identifiedSample.aliquot.gelSuitabilityReport.failureReason":clean, "identifiedSample.aliquot.gelSuitabilityReport.slideScannedOn":clean,
                          "identifiedSample.aliquot.gelSuitabilityReport.slideScannedBy": clean, "identifiedSample.aliquot.gelSuitabilityReport.handEcarriedOutOn":clean, "identifiedSample.aliquot.gelSuitabilityReport.handEcarriedOutBy":clean,
                          "identifiedSample.aliquot.fixationReport.reportDate":clean, "identifiedSample.aliquot.fixationReport.reportStaff":clean, "identifiedSample.aliquot.fixationReport.comments":clean,
                          "identifiedSample.aliquot.fixationReport.fixationStartTimeAliquot":clean, "identifiedSample.aliquot.fixationReport.fixationEndTimeAliquot":clean, "identifiedSample.aliquot.fixationReport.fixationPeriodAliquot":clean,
                          "identifiedSample.aliquot.fixationReport.fixationTimeUnknownAliquot":clean, "identifiedSample.aliquot.fixationReport.tissueProcessorUsed":clean, "identifiedSample.aliquot.specimen.exhausted": clean , "identifiedSample.aliquot.specimen.notes":clean,
                          "identifiedSample.aliquot.specimen.collectionTime":clean, "identifiedSample.aliquot.specimen.collectionLocation":clean, "identifiedSample.aliquot.specimen.collectedBy":clean, "identifiedSample.aliquot.specimen.position":clean, "identifiedSample.aliquot.specimen.sapphireIdentifier": clean,
                          "identifiedSample.aliquot.specimen.barcode":clean, "identifiedSample.aliquot.specimen.primaryContainer": cleanFluid, "identifiedSample.aliquot.specimen.fluidSpecimenVolume":cleanFluid,
                          "identifiedSample.aliquot.specimen.volumeUnit":cleanFluid, "identifiedSample.aliquot.specimen.fluidSampleType":cleanFluid, "identifiedSample.aliquot.specimen.timePoint":cleanFluid,
                          "identifiedSample.aliquot.specimen.anatomicalSite":cleanMain, "identifiedSample.aliquot.specimen.collectionMethod":cleanMain, "identifiedSample.aliquot.specimen.methodOfTransportToPathologist":cleanMain,
                          "identifiedSample.aliquot.specimen.surgeon":cleanMain, "identifiedSample.aliquot.specimen.pathologist":cleanMain, "identifiedSample.aliquot.specimen.specimenWeight":cleanMain,
                          "identifiedSample.aliquot.specimen.massUnit":cleanMain, "identifiedSample.aliquot.specimen.histologyNumber":cleanMain, "identifiedSample.aliquot.specimen.noFFSampleExpected":cleanMain,
                          "identifiedSample.aliquot.specimen.numberOfBiopsies":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.reportDate":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.reportStaff":cleanMain,
                          "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.comments":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.stage":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.stagingSystem":cleanMain,
                          "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourType":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cellPathMacroscopicReport":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cellPathMicroscopicReport":cleanMain,
                          "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cellPathSummaryReport":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cellPathSupplementaryReport":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.startDate":cleanMain,
                          "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.startTime":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.endDate":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.endTime":cleanMain,
                          "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.period":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.reportedBy":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.startDate":cleanMain,
                          "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.startTime":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.endDate":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.endTime":cleanMain,
                          "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.period":cleanMain, "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.reportedBy":cleanMain
        ]

        return formatters
    }

    def getFields(){
        List fields = ["identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier","identifiedSample.aliquot.specimen.participant.nHSNumber", "identifiedSample.aliquot.specimen.participant.diagnosis",
                       "dispatchedBox.dispatchRecord.sentOn", "dispatchedBox.dispatchRecord.consignmentNumber", "positionIfPlated", "dispatchedBox.barcode","identifiedSample.barcode","identifiedSample.extractionKit",
                       "identifiedSample.extractionDate","identifiedSample.passFail","identifiedSample.passFailReason", "identifiedSample.notes", "identifiedSample.dNAConcentrationNanodrop",
                       "identifiedSample.dNAConcentrationQubit", "identifiedSample.extractedBy", "identifiedSample.position", "identifiedSample.sapphireIdentifier", "identifiedSample.delatQC",
                       "identifiedSample.a260A280", "identifiedSample.a260A230", "identifiedSample.experimentName", "identifiedSample.extractionKit", "identifiedSample.extractionType", "volume_ul",
                       "identifiedSample.aliquot.aliquotType", "identifiedSample.aliquot.derivedFrom", "identifiedSample.aliquot.exhausted", "identifiedSample.aliquot.notes", "identifiedSample.aliquot.blockNumber",
                       "identifiedSample.aliquot.barcode", "identifiedSample.aliquot.position", "identifiedSample.aliquot.aliquotVolumeMass", "identifiedSample.aliquot.unit", "identifiedSample.aliquot.sapphireIdentifier",
                       "identifiedSample.aliquot.aliquotRanking", "identifiedSample.aliquot.createdOn", "identifiedSample.aliquot.frozenBy", "identifiedSample.aliquot.gelSuitabilityReport.reportDate",
                       "identifiedSample.aliquot.gelSuitabilityReport.reportStaff", "identifiedSample.aliquot.gelSuitabilityReport.comments", "identifiedSample.aliquot.gelSuitabilityReport.handE_pathreview",
                       "identifiedSample.aliquot.gelSuitabilityReport.slideMarkedBy", "identifiedSample.aliquot.gelSuitabilityReport.sideMarkedDate", "identifiedSample.aliquot.gelSuitabilityReport.percentageTumourContent",
                       "identifiedSample.aliquot.gelSuitabilityReport.tumourContentVerifiedBy", "identifiedSample.aliquot.gelSuitabilityReport.tumourContentVerificationOther", "identifiedSample.aliquot.gelSuitabilityReport.cellularity",
                       "identifiedSample.aliquot.gelSuitabilityReport.percentageNecrosis", "identifiedSample.aliquot.gelSuitabilityReport.dysplasticNonInvasiveElements", "identifiedSample.aliquot.gelSuitabilityReport.dysplasticNonInvasiveNotes",
                       "identifiedSample.aliquot.gelSuitabilityReport.pathologistComments", "identifiedSample.aliquot.gelSuitabilityReport.suitableForGel", "identifiedSample.aliquot.gelSuitabilityReport.failureReason", "identifiedSample.aliquot.gelSuitabilityReport.slideScannedOn",
                       "identifiedSample.aliquot.gelSuitabilityReport.slideScannedBy", "identifiedSample.aliquot.gelSuitabilityReport.handEcarriedOutOn", "identifiedSample.aliquot.gelSuitabilityReport.handEcarriedOutBy",
                       "identifiedSample.aliquot.fixationReport.reportDate", "identifiedSample.aliquot.fixationReport.reportStaff", "identifiedSample.aliquot.fixationReport.comments",
                       "identifiedSample.aliquot.fixationReport.fixationStartTimeAliquot", "identifiedSample.aliquot.fixationReport.fixationEndTimeAliquot", "identifiedSample.aliquot.fixationReport.fixationPeriodAliquot",
                       "identifiedSample.aliquot.fixationReport.fixationTimeUnknownAliquot", "identifiedSample.aliquot.fixationReport.tissueProcessorUsed", "identifiedSample.aliquot.specimen.exhausted", "identifiedSample.aliquot.specimen.notes",
                       "identifiedSample.aliquot.specimen.collectionDate", "identifiedSample.aliquot.specimen.collectionTime", "identifiedSample.aliquot.specimen.collectionLocation", "identifiedSample.aliquot.specimen.collectedBy",
                       "identifiedSample.aliquot.specimen.position", "identifiedSample.aliquot.specimen.sapphireIdentifier", "identifiedSample.aliquot.specimen.barcode", "identifiedSample.aliquot.specimen.primaryContainer",
                       "identifiedSample.aliquot.specimen.fluidSpecimenVolume", "identifiedSample.aliquot.specimen.volumeUnit", "identifiedSample.aliquot.specimen.fluidSampleType", "identifiedSample.aliquot.specimen.timePoint",
                       "identifiedSample.aliquot.specimen.anatomicalSite", "identifiedSample.aliquot.specimen.collectionMethod", "identifiedSample.aliquot.specimen.methodOfTransportToPathologist", "identifiedSample.aliquot.specimen.surgeon", "identifiedSample.aliquot.specimen.pathologist",
                       "identifiedSample.aliquot.specimen.specimenWeight", "identifiedSample.aliquot.specimen.massUnit", "identifiedSample.aliquot.specimen.histologyNumber", "identifiedSample.aliquot.specimen.noFFSampleExpected", "identifiedSample.aliquot.specimen.numberOfBiopsies",
                       "identifiedSample.aliquot.gelSuitabilityReport.microdissection", "identifiedSample.aliquot.gelSuitabilityReport.microdissectionDetails", "identifiedSample.aliquot.specimen.collectionDate", "identifiedSample.aliquot.fixationReport.fixationTypeAliquot",
                       "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot", "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot", "identifiedSample.aliquot.fixationReport.fixationCommentsAliquot", "identifiedSample.aliquot.fixationReport.processingScheduleAliquot",
                       "identifiedSample.aliquot.fixationReport.timeInProcessor", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourStatus", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed.snomedCode", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.sampleType",
                       "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.reportDate", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.reportStaff", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.comments",
                       "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.stage", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.stagingSystem", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourType", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cellPathMacroscopicReport",
                       "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cellPathMicroscopicReport", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cellPathSummaryReport", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cellPathSupplementaryReport",
                       "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.startDate", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.startTime", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.endDate",
                       "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.endTime", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.period", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.reportedBy",
                       "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.startDate", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.startTime", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.endDate",
                       "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.endTime", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.period", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.reportedBy"

        ]

        return fields
    }

    def getLabels(){
        Map labels= ["identifiedSample.barcode" : "Sample Barcode","identifiedSample.aliquot.aliquotType":"Aliquot Type","testResultTypeSummaryQC" : "Test Result Type",
                     "identifiedSample.extractionDate":"DNA Extraction Date", "identifiedSample.passFail":"Pass/Fail","identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier" : "Participant ID",
                     "clinicID" : "Clinic ID", "laboratoryID":"Laboratory ID", "laboratorySampleID":"Laboratory Sample ID", "volume_ul":"Laboratory Sample Volume", "laboratoryRemainingVolumeBanked":"Laboratory Remaining Volume Banked",
                     "dispatchedBox.dispatchRecord.sentOn":"Sample Dispatch Date", "dispatchedBox.dispatchRecord.consignmentNumber":"GMC Sample Consignment Number","positionIfPlated":"Rack Well", "dispatchedBox.barcode":"GMC Rack ID",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourStatus":"Tumour Status", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed.snomedCode":"Morphology (Snomed RT)",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.sampleType":"Sample Type", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.snomed":"Topography (SnomedRT)",
                     "identifiedSample.aliquot.gelSuitabilityReport.microdissectionDetails":"Macrodissection Details", "identifiedSample.aliquot.gelSuitabilityReport.microdissection":"Macrodissected",
                     "identifiedSample.aliquot.fixationReport.fixationEndDateAliquot":"Fixation End DateTime", "identifiedSample.aliquot.fixationReport.fixationTypeAliquot":"Type of Fixative",
                     "identifiedSample.aliquot.fixationReport.fixationStartDateAliquot":"Fixation Start DateTime", "identifiedSample.aliquot.fixationReport.fixationCommentsAliquot":"Fixation Comments",
                     "identifiedSample.aliquot.fixationReport.processingScheduleAliquot":"Processing Schedule", "identifiedSample.aliquot.fixationReport.timeInProcessor":"Time in formalin on processor", "identifiedSample.extractionKit":"DNA Extraction Protocol",
                     "identifiedSample.aliquot.specimen.participant.nHSNumber":"NHS Number", "identifiedSample.aliquot.specimen.participant.diagnosis":"Diagnosis", "identifiedSample.passFailReason":"DNA Pass/Fail Reason",
                     "identifiedSample.notes":"DNA Extraction Notes", "identifiedSample.aliquot.derivedFrom":"Derived From", "identifiedSample.aliquot.exhausted":"Aliquot Exhausted", "identifiedSample.aliquot.notes":"Aliquot Notes",
                     "identifiedSample.aliquot.blockNumber":"Aliquot Block Number", "identifiedSample.aliquot.barcode":"Aliquot Barcode", "identifiedSample.aliquot.position":"Aliquot Position",
                     "identifiedSample.aliquot.aliquotVolumeMass":"Aliquot Volume/Mass", "identifiedSample.aliquot.unit":"Aliquot Unit", "identifiedSample.aliquot.sapphireIdentifier":"Local Aliquot Identifier",
                     "identifiedSample.aliquot.aliquotRanking":"Aliquot Ranking", "identifiedSample.aliquot.createdOn":"Aliquot Created On", "identifiedSample.aliquot.frozenBy":"Aliquot Frozen By",
                     "identifiedSample.aliquot.gelSuitabilityReport.reportDate":"Gel Suitability Report Date", "identifiedSample.aliquot.gelSuitabilityReport.reportStaff":"GelSuitability Report By",
                     "identifiedSample.aliquot.gelSuitabilityReport.comments":"Gel Suitability Report Comments", "identifiedSample.aliquot.gelSuitabilityReport.handE_pathreview":"H & E Path Review",
                     "identifiedSample.aliquot.gelSuitabilityReport.slideMarkedBy":"Slide Marked By", "identifiedSample.aliquot.gelSuitabilityReport.sideMarkedDate":"Side Marked Date",
                     "identifiedSample.aliquot.gelSuitabilityReport.percentageTumourContent":"Percentage Tumour Content", "identifiedSample.aliquot.gelSuitabilityReport.tumourContentVerifiedBy":"Tumour Content Verified By",
                     "identifiedSample.aliquot.gelSuitabilityReport.tumourContentVerificationOther":"Tumour Content Verification Details", "identifiedSample.aliquot.gelSuitabilityReport.cellularity":"Cellularity",
                     "identifiedSample.aliquot.gelSuitabilityReport.percentageNecrosis":"Percentage Necrosis", "identifiedSample.aliquot.gelSuitabilityReport.dysplasticNonInvasiveElements":"Dysplastic Non Invasive Elements",
                     "identifiedSample.aliquot.gelSuitabilityReport.dysplasticNonInvasiveNotes":"Dysplastic Non Invasive Details", "identifiedSample.aliquot.gelSuitabilityReport.suitableForGel":"Suitable For Gel",
                     "identifiedSample.aliquot.gelSuitabilityReport.failureReason":"Gel Suitability Report Failure Reason", "identifiedSample.aliquot.gelSuitabilityReport.slideScannedOn":"Slide Scanned On",
                     "identifiedSample.aliquot.gelSuitabilityReport.slideScannedBy": "Slide Scanned By", "identifiedSample.aliquot.gelSuitabilityReport.handEcarriedOutOn":"H & E Carried Out On",
                     "identifiedSample.aliquot.gelSuitabilityReport.handEcarriedOutBy":"H & E Carried Out By", "identifiedSample.aliquot.gelSuitabilityReport.pathologistComments":"Pathologist Comments",
                     "identifiedSample.aliquot.fixationReport.reportDate":"Fixation Report Date", "identifiedSample.aliquot.fixationReport.reportStaff":"Fixation Report By", "identifiedSample.aliquot.fixationReport.comments":"Fixation Report Comments",
                     "identifiedSample.aliquot.fixationReport.fixationStartTimeAliquot":"Fixation Start Time", "identifiedSample.aliquot.fixationReport.fixationEndTimeAliquot":"Fixation End Time",
                     "identifiedSample.aliquot.fixationReport.fixationPeriodAliquot":"Fixation Period", "identifiedSample.aliquot.fixationReport.fixationTimeUnknownAliquot":"Fixation Time Unknown",
                     "identifiedSample.aliquot.fixationReport.tissueProcessorUsed":"Tissue Processor Used", "identifiedSample.dNAConcentrationNanodrop": "Nanodrop Concentration", "identifiedSample.dNAConcentrationQubit":"Qubit Concentration",
                     "identifiedSample.extractedBy":"Extracted By", "identifiedSample.position":"DNA Position", "identifiedSample.sapphireIdentifier":"DNA Elution", "identifiedSample.delatQC":"Delta CQ",
                     "identifiedSample.a260A280":"A260A280", "identifiedSample.a260A230":"A260A230", "identifiedSample.experimentName":"Experiment Name", "identifiedSample.extractionType":"Extraction Type",
                     "identifiedSample.aliquot.specimen.exhausted": "Specimen Exhausted" , "identifiedSample.aliquot.specimen.notes":"Specimen Notes", "identifiedSample.aliquot.specimen.collectionDate":"Specimen Collection Date",
                     "identifiedSample.aliquot.specimen.collectionTime":"Specimen Collection Time", "identifiedSample.aliquot.specimen.collectionLocation":"Specimen Collection Location",
                     "identifiedSample.aliquot.specimen.collectedBy":"Specimen Collected By", "identifiedSample.aliquot.specimen.position":"Specimen Position", "identifiedSample.aliquot.specimen.sapphireIdentifier": "Local Specimen Identifier",
                     "identifiedSample.aliquot.specimen.barcode":"Specimen Barcode", "identifiedSample.aliquot.specimen.primaryContainer": "Primary Container", "identifiedSample.aliquot.specimen.fluidSpecimenVolume":"Specimen Volume",
                     "identifiedSample.aliquot.specimen.volumeUnit":"Volume Unit", "identifiedSample.aliquot.specimen.fluidSampleType":"Fluid Sample Type", "identifiedSample.aliquot.specimen.timePoint":"Time Point",
                     "identifiedSample.aliquot.specimen.anatomicalSite":"Anatomical Site", "identifiedSample.aliquot.specimen.collectionMethod":"Specimen Collection Method", "identifiedSample.aliquot.specimen.methodOfTransportToPathologist":"Method of transport to pathologist",
                     "identifiedSample.aliquot.specimen.surgeon":"Surgeon", "identifiedSample.aliquot.specimen.pathologist":"Pathologist", "identifiedSample.aliquot.specimen.specimenWeight":"Specimen Weight",
                     "identifiedSample.aliquot.specimen.massUnit":"Mass Unit", "identifiedSample.aliquot.specimen.histologyNumber":"Histology Number", "identifiedSample.aliquot.specimen.noFFSampleExpected":"No FF Sample Expected",
                     "identifiedSample.aliquot.specimen.numberOfBiopsies":"Number of Biopsies", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.reportDate":"Main Specimen Report Date", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.reportStaff":"Main Specimen Report By",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.comments":"Main Specimen Report Comments", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.stage":"Main Specimen Stage", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.stagingSystem":"Main Specimen Staging System",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.tumourType":"Tumour Type", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cellPathMacroscopicReport":"Cell Path Macroscopic Report",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cellPathMicroscopicReport":"Cell Path Microscopic Report", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cellPathSummaryReport":"Cell Path Summary Report",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cellPathSupplementaryReport":"Cell Path Supplementary Report", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.startDate":"Cold Ischaemia Start Date",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.startTime":"Cold Ischaemia Start Time", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.endDate":"Cold Ischaemia End Date",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.endTime":"Cold Ischaemia End Time", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.period":"Cold Ischaemia Period",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.cold_ischaemia.reportedBy":"Cold Ischaemia Reported By", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.startDate":"Warm Ischaemia Start Date",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.startTime":"Warm Ischaemia Start Time", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.endDate":"Warm Ischaemia End Date",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.endTime":"Warm Ischaemia End Time", "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.period":"Warm Ischaemia Period",
                     "identifiedSample.aliquot.specimen.fFPE_Tissue_Report.warm_ischaemia.reportedBy":"Warm Ischaemia Reported By"

        ]

        return labels
    }

    def getParameters(){
        Map parameters = [title: "GMC Sample Data"]
        return parameters
    }
}
