package geldb.DNAExtract

import geldb.Aliquot
import geldb.DNAExtractionKit
import geldb.DNA_Extract
import geldb.ExtractionType
import geldb.IdentifiedSample
import geldb.StaffMember
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.ss.usermodel.WorkbookFactory
import org.grails.plugins.excelimport.ExcelImportService
import org.springframework.transaction.annotation.Transactional
import org.springframework.web.multipart.commons.CommonsMultipartFile

/**
 * ImportService
 * A service class encapsulates the core business logic of a Grails application
 */

@Transactional
class ImportService {

    def getExcelImportService() {
        ExcelImportService.getService()
    }

    @Transactional
    def importDate(CommonsMultipartFile file) {
        Map CONFIG_DNA_EXTRACT_COLUMN_MAP = [
            sheet:'GEL',
            startRow: 1,
            columnMap:  [
                    'A':'rowNumber',
                    'B':'Sample ID',
                    'C':'Sample',
                    'D':'User name',
                    'E':'Date',
                    'F':'Nanodrop concentration',
                    'G':'Unit',
                    'H':'260/280',
                    'I':'260/230',
                    'J':'Sample Type',
                    'K':'Qubit concentration',
                    'L':'Unit',
                    'M':'Delta Cq',
                    'N':'Pass/Fail',
                    'O':'Pass/Fail Reason',
                    'P':'Notes',
                    'Q':'Barcode original aliquot',
                    'R':'Barcode DNA tube',
                    'S':'Experiment name',
                    'T':'Kit',
                    'U':'Volume',
                    'V':'Units',
                    'W':'Exhaust original aliquot',
                    'X':'Elution'
            ]
        ]

        def passedList =[]
        def failedList =[]
        def duplicatedList =[]
        Workbook workbook = WorkbookFactory.create(file.inputStream)
        def dnaExtractList = excelImportService.columns(workbook, CONFIG_DNA_EXTRACT_COLUMN_MAP)
        dnaExtractList.each { Map dnaExtractParams ->
            def rowNumber = null
            def sampleID = null
            def aliquot = null
            def dNAConcentrationNanodrop
            def dNAConcentrationQubit
            def extractionDate = null
            def extractedBy = null
            def participantID
            def sapphireIdentifier = null
            def barcode
            def dNAAmount
            def delatQC
            def a260A280
            def a260A230
            def experimentName
            def extractionKit = null
            def extractionType = null
            def existingSapphireIdentifier = null
            def existingDNAExtractBarcode = null
            def existingBarcode = null
            def notes
            def passFailureReason

            if (dnaExtractParams.get('rowNumber').toString().trim().isNumber()){
                rowNumber = Double?.valueOf(dnaExtractParams.get('rowNumber')?.toString()?.trim())?.toInteger()?.toString()
            }
            if (dnaExtractParams.get('Sample ID').toString().trim().isNumber()){
                sampleID = Double?.valueOf(dnaExtractParams.get('Sample ID')?.toString()?.trim())?.toInteger()?.toString()
            }
            if (dnaExtractParams.get('Barcode original aliquot')){
                if(dnaExtractParams.get('Barcode original aliquot').toString().trim().isNumber()){
                    def barcodeOfAliquot = Double?.valueOf(dnaExtractParams.get('Barcode original aliquot')?.toString()?.trim())?.toInteger()?.toString()
                    aliquot = Aliquot.findByBarcode(barcodeOfAliquot)
                }else {
                    def barcodeOfAliquot = dnaExtractParams.get('Barcode original aliquot')?.toString()?.trim()
                    aliquot = Aliquot.findByBarcode(barcodeOfAliquot)
                }
            }
            dNAConcentrationNanodrop = dnaExtractParams.get('Nanodrop concentration')?.toString()?.trim()
            dNAConcentrationQubit = dnaExtractParams.get('Qubit concentration')?.toString()?.trim()
            if (dnaExtractParams.get('Date') && dnaExtractParams.get('Date')?.toString()?.trim()?.size() == 10){
                extractionDate =Date?.parse("yyyy-MM-dd", dnaExtractParams.get('Date')?.toString()?.trim())
            }
            if (dnaExtractParams.get('User name')){
                extractedBy = StaffMember?.findByStaffName(dnaExtractParams.get('User name')?.toString()?.trim())
            }
            participantID = aliquot?.specimen?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}
            if (aliquot && participantID){
                if (aliquot?.aliquotType?.aliquotTypeName == 'Buffy Coat'){
                    sapphireIdentifier = participantID?.toString() + "_" + "GL" + "_" + dnaExtractParams.get('Elution')?.toString()?.trim()
                }else {
                    sapphireIdentifier = participantID?.toString() + "_" + aliquot?.aliquotType?.aliquotTypeName?.toString()?.replace(" ","") + "_" + dnaExtractParams.get('Elution')?.toString()?.trim()
                }
            }
            if (dnaExtractParams.get('Barcode DNA tube').toString().trim().isNumber()){
                barcode = Double?.valueOf(dnaExtractParams.get('Barcode DNA tube')?.toString()?.trim())?.toInteger()?.toString()
            }else{
                barcode = dnaExtractParams.get('Barcode DNA tube')?.toString()?.trim()
            }
            dNAAmount = dnaExtractParams.get('Volume')?.toString()?.trim()
            delatQC = dnaExtractParams.get('Delta Cq')?.toString()?.trim()
            a260A280 = dnaExtractParams.get('260/280')?.toString()?.trim()
            a260A230 = dnaExtractParams.get('260/230')?.toString()?.trim()
            experimentName = dnaExtractParams.get('Experiment name')?.toString()?.trim()
            notes = dnaExtractParams.get('Notes')?.toString()?.trim()
            passFailureReason = dnaExtractParams.get('Pass/Fail Reason')?.toString()?.trim()
            if (dnaExtractParams.get('Kit')){
                extractionKit = DNAExtractionKit.findByExtractionKitName(dnaExtractParams.get('Kit')?.toString()?.trim())
            }
            if (dnaExtractParams.get('Sample Type')){
                extractionType = ExtractionType.findByExtractionTypeName(dnaExtractParams.get('Sample Type')?.toString()?.trim())
            }
            if (sapphireIdentifier){
                existingSapphireIdentifier = DNA_Extract.findBySapphireIdentifier(sapphireIdentifier)
            }
            if (barcode){
                existingDNAExtractBarcode = DNA_Extract.findByBarcode(barcode)
            }
            if (barcode){
                existingBarcode = IdentifiedSample.findByBarcode(barcode)
            }
            def row = 'Row Number ' + rowNumber  + '--------------------' +'Sample ID ' + sampleID  + '--------------------' + 'Elution ' + sapphireIdentifier + '--------------------' + 'Aliquot barcode ' + aliquot?.barcode
            if (existingSapphireIdentifier || existingDNAExtractBarcode){
                duplicatedList.add(row)
            } else if (aliquot
                    && dNAConcentrationNanodrop
                    && dNAConcentrationQubit
                    && extractionDate
                    && dNAAmount
                    && a260A280
                    && a260A230
                    && experimentName
                    && extractionKit
                    && extractionType
                    && !existingSapphireIdentifier
                    && !existingDNAExtractBarcode
                    && !existingBarcode) {
                def dnaExtractInstance = new DNA_Extract(aliquot: aliquot, dNAConcentrationNanodrop: dNAConcentrationNanodrop, dNAConcentrationQubit: dNAConcentrationQubit, extractionDate: extractionDate,
                        extractedBy: extractedBy, sapphireIdentifier: sapphireIdentifier, barcode: barcode, dNAAmount: dNAAmount, notes: notes, passFailReason: passFailureReason,
                        delatQC: delatQC, a260A280: a260A280, a260A230: a260A230, experimentName: experimentName, extractionKit: extractionKit, extractionType: extractionType)
                dnaExtractInstance.save failOnError: true
                if (dnaExtractParams.get('Exhaust original aliquot').toString().trim() == "Yes"){
                    aliquot.exhausted = true
                    aliquot.save flush: true
                }
                passedList.add(row)
            }else {
                failedList.add(row)
            }
        }
        [passedList : passedList, failedList : failedList, duplicatedList : duplicatedList]
    }
}
