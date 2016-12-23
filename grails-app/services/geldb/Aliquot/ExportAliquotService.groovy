package geldb.Aliquot

import geldb.SolidSpecimen
import grails.transaction.Transactional

/**
 * ExportAliquotService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportAliquotService {

    def getFormatters(){
        def cleanGelID = { domain, value ->
            return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
        }

        def clean = { domain, value ->
            return value.toString().replace('[','').replace(']','').trim()
        }

        def processingSchedule = {domain, value ->
            if (value.toString()?.startsWith('Fluid Specimen-')) {
                return ""
            } else {
                return value.toString().replace('[','').replace(']','').replace('null','').trim()
            }
        }

        def tumourType = { domain, value ->
            if (value.toString()?.startsWith('Fluid Specimen-')) {
                def patient = domain?.specimen?.participant
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

        Map formatters = ["gelSuitabilityReport.reportDate":clean, "gelSuitabilityReport.reportStaff":clean, "gelSuitabilityReport.comments":clean, "gelSuitabilityReport.handE_pathreview":clean,
                          "gelSuitabilityReport.slideMarkedBy":clean, "gelSuitabilityReport.sideMarkedDate":clean, "gelSuitabilityReport.percentageTumourContent":clean,
                          "gelSuitabilityReport.tumourContentVerifiedBy":clean, "gelSuitabilityReport.tumourContentVerificationOther":clean,
                          "gelSuitabilityReport.microdissection":clean, "gelSuitabilityReport.microdissectionDetails":clean, "gelSuitabilityReport.cellularity":clean,
                          "gelSuitabilityReport.percentageNecrosis":clean, "gelSuitabilityReport.dysplasticNonInvasiveElements":clean,
                          "gelSuitabilityReport.dysplasticNonInvasiveNotes":clean, "gelSuitabilityReport.pathologistComments":clean,
                          "gelSuitabilityReport.suitableForGel":clean, "gelSuitabilityReport.failureReason":clean, "gelSuitabilityReport.slideScannedOn":clean,
                          "gelSuitabilityReport.slideScannedBy":clean, "gelSuitabilityReport.handEcarriedOutOn":clean, "gelSuitabilityReport.handEcarriedOutBy":clean,
                          "specimen.participant.studySubject.studySubjectIdentifier":cleanGelID, "fixationReport.processingScheduleAliquot":clean,
                          "specimen.fFPE_Tissue_Report.processingSchedule":processingSchedule, "specimen.fFPE_Tissue_Report.tumourType.tumourLocation":tumourType]
        return formatters
    }

    def getFields(){
        List fields = ["specimen.participant.studySubject.studySubjectIdentifier", "specimen.fFPE_Tissue_Report.tumourType.tumourLocation", "specimen", "derivedFrom.aliquot",
                       "derivedFrom.derivationDate", "derivedFrom.derivedBy", "derivedFrom.derivationProcess", "sapphireIdentifier",
                       "blockNumber", "aliquotType", "barcode", "exhausted", "notes","aliquotRanking","createdOn","frozenBy","aliquotVolumeMass","unit", "position",
                       "gelSuitabilityReport.reportDate", "gelSuitabilityReport.reportStaff", "gelSuitabilityReport.comments", "gelSuitabilityReport.handE_pathreview",
                       "gelSuitabilityReport.slideMarkedBy", "gelSuitabilityReport.sideMarkedDate", "gelSuitabilityReport.percentageTumourContent",
                       "gelSuitabilityReport.tumourContentVerifiedBy", "gelSuitabilityReport.tumourContentVerificationOther", "gelSuitabilityReport.microdissection",
                       "gelSuitabilityReport.microdissectionDetails", "gelSuitabilityReport.cellularity", "gelSuitabilityReport.percentageNecrosis",
                       "gelSuitabilityReport.dysplasticNonInvasiveElements", "gelSuitabilityReport.dysplasticNonInvasiveNotes", "gelSuitabilityReport.pathologistComments",
                       "gelSuitabilityReport.suitableForGel", "gelSuitabilityReport.failureReason", "gelSuitabilityReport.slideScannedOn", "gelSuitabilityReport.slideScannedBy",
                       "gelSuitabilityReport.handEcarriedOutOn", "gelSuitabilityReport.handEcarriedOutBy","specimen.fFPE_Tissue_Report.processingSchedule", "fixationReport.processingScheduleAliquot"]
        return fields
    }

    def getLabels(){
        Map labels = ["specimen":"Specimen", "derivedFrom.aliquot":"Parent Aliquot", "derivedFrom.derivationDate":"Derivation Date", "derivedFrom.derivedBy":"Derived By", "derivedFrom.derivationProcess":"Derivation Process", "sapphireIdentifier":"Biobanking Identifier",
                      "blockNumber":"Block Number", "barcode":"Barcode", "aliquotType":"Aliquot Type", "exhausted":"Exhausted", "notes":"Notes", "aliquotRanking":"Aliquot Ranking", "createdOn":"Created on",
                      "frozenBy":"Frozen By", "aliquotVolumeMass":"Aliquot Volume Mass", "unit":"Unit", "position":"Position","gelSuitabilityReport.reportDate":"Report Date",
                      "gelSuitabilityReport.reportStaff":"Report Staff", "gelSuitabilityReport.comments":"Comments", "gelSuitabilityReport.handE_pathreview":"H & E path review",
                      "gelSuitabilityReport.slideMarkedBy":"Slide Marked By", "gelSuitabilityReport.sideMarkedDate":"Slide Marked Date", "gelSuitabilityReport.percentageTumourContent":"Percentage Tumour Content",
                      "gelSuitabilityReport.tumourContentVerifiedBy":"Tumour Content Verified By", "gelSuitabilityReport.tumourContentVerificationOther":"Tumour Content Verification Other",
                      "gelSuitabilityReport.microdissection":"Micro dissection", "gelSuitabilityReport.microdissectionDetails":"Micro dissection Details", "gelSuitabilityReport.cellularity":"Cellularity",
                      "gelSuitabilityReport.percentageNecrosis":"Percentage Necrosis", "gelSuitabilityReport.dysplasticNonInvasiveElements":"Dysplastic Non Invasive Elements",
                      "gelSuitabilityReport.dysplasticNonInvasiveNotes":"Dysplastic Non Invasive Notes", "gelSuitabilityReport.pathologistComments":"Pathologist Comments",
                      "gelSuitabilityReport.suitableForGel":"Suitable For Gel", "gelSuitabilityReport.failureReason":"Failure Reason", "gelSuitabilityReport.slideScannedOn":"Slide Scanned On",
                      "gelSuitabilityReport.slideScannedBy":"Slide Scanned By", "gelSuitabilityReport.handEcarriedOutOn":"H & E Carried Out On", "gelSuitabilityReport.handEcarriedOutBy":"H & E carried Out By",
                      "specimen.participant.studySubject.studySubjectIdentifier":"GeL Study ID", "fixationReport.processingScheduleAliquot":"Genomic block processing schedule",
                      "specimen.fFPE_Tissue_Report.processingSchedule":"Main specimen processing schedule", "specimen.fFPE_Tissue_Report.tumourType.tumourLocation":"Cancer Type"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "Aliquots", "column.widths": [0.15, 0.17, 0.6, 0.6, 0.15, 0.15, 0.2, 0.2, 0.15, 0.25, 0.25, 0.2, 0.15, 0.2, 0.15, 0.2, 0.25, 0.15, 0.3, 0.15, 0.15, 0.25, 0.15, 0.25, 0.15, 0.15, 0.25, 0.25, 0.15, 0.25, 0.15,
                                                               0.15, 0.15, 0.25, 0.25, 0.15, 0.25, 0.2, 0.2, 0.2, 0.2, 0.35, 0.35]]
        return parameters
    }
}
