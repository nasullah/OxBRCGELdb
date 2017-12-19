package geldb.FluidSpecimen

import geldb.Aliquot
import geldb.DispatchItem
import geldb.IdentifiedSample

/**
 * ExportAllAliquotCronJobService
 * A service class encapsulates the core business logic of a Grails application
 */
class ExportAllAliquotCronJobService {
    static transactional = false
    def grailsApplication
    def exportService

    def exportAllAliquot() {
        def os = new File(grailsApplication.config.hizniShare + 'exportAliquot.csv').newOutputStream()
        List fields = ["id", "specimen.id", "exhausted", "notes", "blockNumber", "aliquotType", "barcode", "position","aliquotVolumeMass",
                       "unit", "sapphireIdentifier", "aliquotRanking", "createdOn", "frozenBy", "createdTime", "gelSuitabilityReport.reportDate"
                       , "gelSuitabilityReport.reportStaff", "gelSuitabilityReport.comments", "gelSuitabilityReport.handE_pathreview",
                       "gelSuitabilityReport.slideMarkedBy", "gelSuitabilityReport.sideMarkedDate"
                       , "gelSuitabilityReport.percentageTumourContent", "gelSuitabilityReport.tumourContentVerifiedBy",
                       "gelSuitabilityReport.tumourContentVerificationOther", "gelSuitabilityReport.microdissection", "gelSuitabilityReport.microdissectionDetails"
                       , "gelSuitabilityReport.cellularity", "gelSuitabilityReport.percentageNecrosis", "gelSuitabilityReport.dysplasticNonInvasiveElements"
                       , "gelSuitabilityReport.dysplasticNonInvasiveNotes", "gelSuitabilityReport.pathologistComments"
                       , "gelSuitabilityReport.suitableForGel", "gelSuitabilityReport.failureReason", "gelSuitabilityReport.slideScannedOn", "gelSuitabilityReport.slideScannedBy",
                       "gelSuitabilityReport.handEcarriedOutOn", "gelSuitabilityReport.handEcarriedOutBy", "fixationReport.reportDate", "fixationReport.reportStaff"
                       , "fixationReport.comments", "fixationReport.fixationTypeAliquot", "fixationReport.processingScheduleAliquot", "fixationReport.fixationStartDateAliquot",
                       "fixationReport.fixationStartTimeAliquot", "fixationReport.fixationEndDateAliquot", "fixationReport.fixationEndTimeAliquot", "fixationReport.fixationPeriodAliquot",
                       "fixationReport.fixationTimeUnknownAliquot", "fixationReport.fixationCommentsAliquot" , "fixationReport.tissueProcessorUsed", "fixationReport.timeInProcessor",
                       "sampleTrackingEvent", "dispatched"]


        Map labels = ["exhausted":"aliquot.exhausted", "notes":"aliquot.notes", "blockNumber":"aliquot.blockNumber", "aliquotType":"aliquot.aliquotType",
                      "barcode":"aliquot.barcode", "position":"aliquot.position","aliquotVolumeMass":"aliquot.aliquotVolumeMass", "id":"aliquot.id",
                      "unit":"aliquot.unit", "sapphireIdentifier":"aliquot.sapphireIdentifier", "aliquotRanking":"aliquot.aliquotRanking",
                      "createdOn":"aliquot.createdOn", "frozenBy":"aliquot.frozenBy", "createdTime":"aliquot.createdTime",
                      "fixationReport.fixationTypeAliquot":"fixationReport.fixationType", "fixationReport.processingScheduleAliquot":"fixationReport.processingSchedule",
                      "fixationReport.fixationStartDateAliquot":"fixationReport.fixationStartDate", "fixationReport.fixationStartTimeAliquot":"fixationReport.fixationStartTime",
                      "fixationReport.fixationEndDateAliquot":"fixationReport.fixationEndDate", "fixationReport.fixationEndTimeAliquot":"fixationReport.fixationEndTime",
                      "fixationReport.fixationPeriodAliquot":"fixationReport.fixationPeriod", "fixationReport.fixationTimeUnknownAliquot":"fixationReport.fixationTimeUnknown",
                      "fixationReport.fixationCommentsAliquot":"fixationReport.fixationComments"]

        def aliquotList = Aliquot.list()
        def type = 'csv'
        // Formatter closure
        def gelID = { domain, value ->
            return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
        }

        def clean = { domain, value ->
            return value.toString().replace('[','').replace(']','').trim()
        }

        def dispatched = { domain, value ->
            def dispatchItem = DispatchItem.findByIdentifiedSample(IdentifiedSample.findById(domain.id))
            if (dispatchItem){
                return dispatchItem.dispatchedBox.dispatchRecord.consignmentNumber
            }else {
                return  ""
            }
        }

        Map formatters = ["gelSuitabilityReport.reportDate":clean
                          , "gelSuitabilityReport.reportStaff":clean, "gelSuitabilityReport.comments":clean, "gelSuitabilityReport.handE_pathreview":clean,
                          "gelSuitabilityReport.slideMarkedBy":clean, "gelSuitabilityReport.sideMarkedDate":clean
                          , "gelSuitabilityReport.percentageTumourContent":clean, "gelSuitabilityReport.tumourContentVerifiedBy":clean,
                          "gelSuitabilityReport.tumourContentVerificationOther":clean, "gelSuitabilityReport.microdissection":clean, "gelSuitabilityReport.microdissectionDetails":clean
                          , "gelSuitabilityReport.cellularity":clean, "gelSuitabilityReport.percentageNecrosis":clean, "gelSuitabilityReport.dysplasticNonInvasiveElements":clean
                          , "gelSuitabilityReport.dysplasticNonInvasiveNotes":clean, "gelSuitabilityReport.pathologistComments":clean
                          , "gelSuitabilityReport.suitableForGel":clean, "gelSuitabilityReport.failureReason":clean, "gelSuitabilityReport.slideScannedOn":clean, "gelSuitabilityReport.slideScannedBy":clean,
                          "gelSuitabilityReport.handEcarriedOutOn":clean, "gelSuitabilityReport.handEcarriedOutBy":clean,
                          "fixationReport.fixationTypeAliquot":clean, "fixationReport.processingScheduleAliquot":clean,
                          "fixationReport.fixationStartDateAliquot":clean, "fixationReport.fixationStartTimeAliquot":clean,
                          "fixationReport.fixationEndDateAliquot":clean, "fixationReport.fixationEndTimeAliquot":clean,
                          "fixationReport.fixationPeriodAliquot":clean, "fixationReport.fixationTimeUnknownAliquot":clean,
                          "fixationReport.fixationCommentsAliquot":clean, "fixationReport.tissueProcessorUsed":clean, "fixationReport.timeInProcessor":clean,
                          "fixationReport.reportDate":clean, "fixationReport.reportStaff":clean, "fixationReport.comments":clean, "dispatched":dispatched,
                          "sampleTrackingEvent":clean]

        Map parameters = [title: "exportAliquot"]
        exportService.export(type, os, aliquotList, fields, labels, formatters, parameters )
        os.close()
    }
}
