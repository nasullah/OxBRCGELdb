package geldb.FluidSpecimen

import geldb.DNA_Extract
import geldb.DispatchItem
import geldb.IdentifiedSample

/**
 * ExportAllDNACronJobService
 * A service class encapsulates the core business logic of a Grails application
 */

class ExportAllDNACronJobService {
    static transactional = false
    def grailsApplication
    def exportService

    def exportAllDNA() {
        def os = new File(grailsApplication.config.hizniShare + 'exportDNA.csv').newOutputStream()
        List fields = ["id", "aliquot.id", "exhausted", "passFail", "passFailReason", "notes", "barcode", "position",
                       "dNAConcentrationNanodrop", "dNAConcentrationQubit", "extractionDate", "extractedBy", "geLSampleIdentifier",
                       "sapphireIdentifier", "dNAAmount", "delatQC", "a260A280", "a260A230", "experimentName", "extractionKit",
                       "extractionType", "rin", "checked", "dispatched"]


        Map labels = ["id": "DNA_Extract.id", "exhausted":"DNA_Extract.exhausted", "passFail":"DNA_Extract.passFail", "passFailReason":"DNA_Extract.passFailReason",
                      "notes":"DNA_Extract.notes", "barcode": "DNA_Extract.barcode", "position":"DNA_Extract.position",
                      "dNAConcentrationNanodrop":"DNA_Extract.dNAConcentrationNanodrop", "dNAConcentrationQubit":"DNA_Extract.dNAConcentrationQubit",
                      "extractionDate":"DNA_Extract.extractionDate", "extractedBy":"DNA_Extract.extractedBy", "geLSampleIdentifier":"DNA_Extract.geLSampleIdentifier",
                      "sapphireIdentifier":"DNA_Extract.sapphireIdentifier", "dNAAmount":"DNA_Extract.dNAAmount", "delatQC":"DNA_Extract.deltaQC", "a260A280":"DNA_Extract.a260A280",
                      "a260A230":"DNA_Extract.a260A230", "experimentName": "DNA_Extract.experimentName", "extractionKit":"DNA_Extract.extractionKit",
                      "extractionType":"DNA_Extract.extractionType", "rin":"DNA_Extract.rin", "checked":"DNA_Extract.checked"]

        def dnaList = DNA_Extract.list()

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

        def type = 'csv'
        Map formatters = ["aliquot.id":clean, "dispatched":dispatched]
        Map parameters = [title: "DNAExport"]
        exportService.export(type, os, dnaList, fields, labels, formatters, parameters )
        os.close()
    }
}
