package geldb

import grails.converters.XML
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.plugin.filterpane.FilterPaneUtils
import grails.plugins.springsecurity.*
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
/**
 * DNA_ExtractController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class DNA_ExtractController {

    def exportService
    def exportKPIReportService
    def filterPaneService
    def exportAllDNAExtractService
    def importService
    def workListService
    def exportDNAListToCheckService
    def exportCheckedDNAListService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DNA_Extract.findAllByExhausted(false, params), model: [DNA_ExtractInstanceCount: DNA_Extract.findAllByExhausted(false).size()]
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [DNA_ExtractInstanceList: DNA_Extract.findAllByExhausted(false, params), DNA_ExtractInstanceTotal: DNA_Extract.findAllByExhausted(false).size()]
    }

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ DNA_ExtractInstanceList: filterPaneService.filter( params, DNA_Extract ),
                                     DNA_ExtractInstanceTotal: filterPaneService.count( params, DNA_Extract ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def failedDNASampleList(){
        [DNA_ExtractInstanceList: DNA_Extract.findAllByPassFail(false).sort {it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    def reservedDNASampleList(){
        [DNA_ExtractInstanceList: DNA_Extract.findAllBySapphireIdentifierIlike('%_Remaining%').sort {it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    def findAliquotsByGeLId() {
        def gelId= params.search
        if (gelId) {
            def participantByGeLId = Participant.createCriteria().get {
                studySubject {
                    eq('studySubjectIdentifier', gelId, [ignoreCase: true])
                }
            }
            if(participantByGeLId){
                participantByGeLId = participantByGeLId.id
                def listAliquotsByGeLId = Aliquot.findAll {
                    specimen.participant.id == participantByGeLId
                }
                listAliquotsByGeLId = listAliquotsByGeLId.findAll { a ->
                    !a.exhausted
                }
                listAliquotsByGeLId = listAliquotsByGeLId.findAll { a ->
                    a.specimen.participant.id == participantByGeLId
                }
                if (!listAliquotsByGeLId.empty) {
                    def listAliquots = []
                    listAliquotsByGeLId.each {aliquot ->
                        if (aliquot.aliquotType.aliquotTypeName == 'Punch Biopsy Frozen'
                            || aliquot.aliquotType.aliquotTypeName == 'Punch Biopsy FFPE, NBF'
                            || aliquot.aliquotType.aliquotTypeName == 'Punch Biopsy FFPE'){
                            if (!aliquot.sampleTrackingEvent.empty){
                                if (aliquot?.sampleTrackingEvent?.flatten()?.toString()?.contains('Received')){
                                    listAliquots.add(aliquot)
                                }
                            }
                        }else {
                            listAliquots.add(aliquot)
                        }
                    }
                    if (!listAliquots.empty){
                        render(template: "aliquotList", model: [listAliquotsByGeLId: listAliquots])
                    }
                }
            }
        }
    }

    def findAliquotByBarcode() {
        def aliquotBarcode= params.aliquotBarcode
        if (aliquotBarcode) {
            def aliquotList = Aliquot.findAllByBarcodeAndExhausted(aliquotBarcode?.toString(), false)
            if (!aliquotList.empty) {
                render(template: "aliquotList", model: [listAliquotsByGeLId: aliquotList])
            }
        }
    }

    def show(DNA_Extract DNA_ExtractInstance) {
        def listDNA_ExtractInstanceAuditLogData = AuditLogEvent.findAllByPersistedObjectId(DNA_ExtractInstance?.id)
        respond DNA_ExtractInstance, model: [listAuditLogData: listDNA_ExtractInstanceAuditLogData]
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def create() {
        respond new DNA_Extract(params), model: [originalVolume: params.originalVolume, originalDnaId: params.originalDnaId]
    }

    def workLists() {
        workListService.workLists(params.sampleType)
    }

    def aliquotsPendingForExtraction(){
        def aliquotInstanceList = Aliquot.findAllByAliquotTypeOrAliquotTypeOrAliquotTypeOrAliquotTypeOrAliquotType(AliquotType.findByAliquotTypeName('Punch Biopsy FFPE, NBF'), AliquotType.findByAliquotTypeName('Punch Biopsy FFPE'),
                AliquotType.findByAliquotTypeName('Punch biopsy, PAXgene'), AliquotType.findByAliquotTypeName('Section'), AliquotType.findByAliquotTypeName('Punch Biopsy Frozen'))
        aliquotInstanceList = aliquotInstanceList.findAll {aliquot -> !aliquot.sampleTrackingEvent.empty}
        aliquotInstanceList = aliquotInstanceList.findAll {aliquot -> SampleTrackingEvent.findBySampleTrackingEventTypeAndIdentifiedSample(SampleTrackingEventType.findBySampleTrackingEventTypeName('Received at MDC lab'), aliquot) }
        aliquotInstanceList = aliquotInstanceList.findAll {aliquot -> !aliquot.exhausted}
        [aliquotInstanceList: aliquotInstanceList.sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    @Transactional
    def readyToDispatch(){
        def dna = DNA_Extract.findById(params.long('dnaExtractId'))
        if (dna){
            if (!dna.checked || dna.checked == null){
                dna.checked = true
                dna.save flush: true
                flash.message ="Selected item has been checked"
            }else {
                dna.checked = false
                dna.save flush: true
                flash.message ="Selected item has been unchecked"
            }
        }
        def ffDNAExtract = DNA_Extract.createCriteria().list{
            and {
                aliquot {
                    eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy Frozen'))
                }
                ge("dNAConcentrationQubit", '18'.toFloat())
                eq("exhausted", false)
                eq("passFail", true)
                eq('extractionType', ExtractionType.findByExtractionTypeName('DNA Extraction'))
            }
        }
        def glDNAExtract = DNA_Extract.createCriteria().list {
            and {
                aliquot {
                    or {
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Blood Germline'))
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Buffy Coat'))
                    }
                }
                ge("dNAConcentrationQubit", '30'.toFloat())
                ge("dNAAmount", '100'.toDouble())
                eq("exhausted", false)
                eq("passFail", true)
                eq('extractionType', ExtractionType.findByExtractionTypeName('DNA Extraction'))
            }
        }
        def ffpDNAExtract = DNA_Extract.createCriteria().list {
            and {
                aliquot {
                    or {
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy FFPE, NBF'))
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy FFPE'))
                    }
                }
                lt("delatQC", '2.9'.toDouble())
                ge("dNAConcentrationQubit", '18'.toFloat())
                eq("exhausted", false)
                eq("passFail", true)
                eq('extractionType', ExtractionType.findByExtractionTypeName('DNA Extraction'))
            }
        }
        def ffPatientIds = ffDNAExtract.aliquot.specimen.participant.id.flatten().unique()
        def glPatientIds = glDNAExtract.aliquot.specimen.participant.id.flatten().unique()
        def ffpPatientIds = ffpDNAExtract.aliquot.specimen.participant.id.flatten().unique()
        def noFFSampleExpectedPatientIds = SolidSpecimen.findAllByNoFFSampleExpected(true).participant.id
        ffPatientIds.addAll(noFFSampleExpectedPatientIds)
        def patientIdList = ffPatientIds.intersect(glPatientIds).intersect(ffpPatientIds)
        def dispatchedItemSampleIdList = DispatchItem.list().identifiedSample.id
        def dispatchedItemDNAPatientIds = DNA_Extract.findAllByIdInList(dispatchedItemSampleIdList).aliquot.specimen.participant.id.flatten().unique()
        if(!dispatchedItemDNAPatientIds.empty){
            patientIdList -= dispatchedItemDNAPatientIds
        }
        ffDNAExtract = ffDNAExtract.findAll {c -> patientIdList.findAll {it == c.aliquot.specimen.participant.id.first()}}
        glDNAExtract = glDNAExtract.findAll {c -> patientIdList.findAll {it == c.aliquot.specimen.participant.id.first()}}
        ffpDNAExtract = ffpDNAExtract.findAll {c -> patientIdList.findAll {it == c.aliquot.specimen.participant.id.first()}}
        def trio = ffDNAExtract + glDNAExtract + ffpDNAExtract
        [trio: trio.sort {it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}]
    }

    def exportCheckedDNA(){
        List<DNA_Extract> dnaList = new ArrayList<DNA_Extract>();
        dnaList.addAll(readyToDispatch().trio)
        def checkedList = dnaList.findAll {d -> d.checked}

        if (params?.format && params.format != "html") {
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported_Checked_DNA_List.${params.extension}")
            exportService.export(params.format, response.outputStream, checkedList, exportCheckedDNAListService.fields, exportCheckedDNAListService.labels, exportCheckedDNAListService.formatters, exportCheckedDNAListService.parameters)
        }
    }

    def addBarcode(){
        def aliquotType = params.long('aliquotTypeDNA')
        def paramsStartDate = params.startDateDNA
        def paramsEndDate = params.endDateDNA
        def startDate = new Date()
        def endDate =new Date()
        if (paramsStartDate){
            startDate = startDate.parse("yyyy-MM-dd", paramsStartDate.toString())
        }
        if (paramsEndDate){
            endDate = endDate.parse("yyyy-MM-dd", paramsEndDate.toString())
        }

        if (paramsEndDate && paramsStartDate && aliquotType) {
            def listDNA = DNA_Extract.createCriteria().list {
                and {
                    le("extractionDate", endDate)
                    ge("extractionDate", startDate)
                    aliquot {
                        eq("aliquotType", AliquotType.findById(aliquotType))
                    }
                }
            }?.sort {
                it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {
                    it?.size() ? it : null
                }
            }
            [listDNA:listDNA]
        }
    }

    @Transactional
    def updateBarcode(){
        if (params.barcode){
            def DNA_ExtractInstance = DNA_Extract.findById(params.long('DNA_ExtractInstance'))
            if (DNA_ExtractInstance){
                DNA_ExtractInstance.barcode = params.barcode
                DNA_ExtractInstance.save flush: true
                redirect(action: "addBarcode", params:[startDateDNA:params.startDateDNA, endDateDNA: params.endDateDNA, aliquotTypeDNA:params.aliquotTypeDNA])
            }
        }else {
            flash.message = "Please enter barcode"
            redirect(action: "addBarcode", params:[startDateDNA:params.startDateDNA, endDateDNA: params.endDateDNA, aliquotTypeDNA:params.aliquotTypeDNA])
        }
    }

    def controlChart(){
        def controlDNAList = Specimen.findAllByReference('Yes')?.aliquot?.dNA_Extract
        controlDNAList = controlDNAList?.flatten()
        controlDNAList = controlDNAList?.sort {it?.extractionDate}
        def dataList = []
        if (!controlDNAList.empty){
            for (int i = 0; i < controlDNAList.size(); i++){
                def item = []
                def day = controlDNAList?.get(i)?.extractionDate[Calendar.DAY_OF_MONTH]
                def month = controlDNAList?.get(i)?.extractionDate[Calendar.MONTH]
                def year = controlDNAList?.get(i)?.extractionDate[Calendar.YEAR]
                def qubit = controlDNAList?.get(i)?.dNAConcentrationQubit
                item << 'Date.UTC(' + year + ',' + month + ',' + day + ')' << qubit
                if(!item.empty){
                    dataList << item
                }
            }
        }
        [dataList:dataList]
    }

    @Transactional
    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def uploadFile() {
        MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request;
        CommonsMultipartFile file = (CommonsMultipartFile) mpr.getFile("file");
        if (!file.originalFilename) {
            flash.message = "Please choose a file"
            redirect action: "index", method: "GET"
        } else{
            importService.importDate(file)
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportKPIReport (){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported KPI Report.${params.extension}")
            def exportKPIReportData = DNA_Extract.list().sort {it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
            exportService.export(params.format, response.outputStream, exportKPIReportData, exportKPIReportService.fields, exportKPIReportService.labels, exportKPIReportService.formatters, exportKPIReportService.parameters)
        }
    }

    @Secured(['ROLE_ADMIN'])
    def exportAllDNAExtracts (){
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Exported DNA Extracts.${params.extension}")
            def dnaExtractList = DNA_Extract.list().sort {it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
            exportService.export(params.format, response.outputStream, dnaExtractList, exportAllDNAExtractService.fields, exportAllDNAExtractService.labels, exportAllDNAExtractService.formatters, exportAllDNAExtractService.parameters)
        }
    }

    def exportDNAExportListToCheck(){
        def aliquotType = params.long('aliquotTypeDNA')
        def paramsStartDate = params.startDateDNA
        def paramsEndDate = params.endDateDNA
        def startDate = new Date()
        def endDate =new Date()
        if (paramsStartDate){
            startDate = startDate.parse("yyyy-MM-dd", paramsStartDate.toString())
        }
        if (paramsEndDate){
            endDate = endDate.parse("yyyy-MM-dd", paramsEndDate.toString())
        }

        if (paramsEndDate && paramsStartDate && aliquotType){
            if (params?.format && params.format != "html") {
                response.contentType = grailsApplication.config.grails.mime.types[params.format]
                response.setHeader("Content-disposition", "attachment; filename= DNA_Extract.${params.extension}")
                def listDNA = DNA_Extract.createCriteria().list {
                    and {
                        le("extractionDate", endDate)
                        ge("extractionDate", startDate)
                        aliquot {
                            eq("aliquotType", AliquotType.findById(aliquotType))
                        }
                    }
                }?.sort {it.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}
                exportService.export(params.format, response.outputStream, listDNA, exportDNAListToCheckService.fields, exportDNAListToCheckService.labels, exportDNAListToCheckService.formatters, exportDNAListToCheckService.parameters)
            }
        }else {
            flash.message = "Enter start date, end date and sample type"
            redirect(uri: "/participant/summaryReport")
        }
    }

    @Transactional
    def save(DNA_Extract DNA_ExtractInstance) {
        if (DNA_ExtractInstance == null) {
            notFound()
            return
        }

        if (DNA_ExtractInstance.hasErrors()) {
            respond DNA_ExtractInstance.errors, view: 'create'
            return
        }

        if (params.aliquot){
            DNA_ExtractInstance.save flush: true
            def exhaustAliquot = params.exhaustAliquot
            if (exhaustAliquot == 'True'){
                DNA_ExtractInstance.aliquot.each{ a->
                    a.exhausted = true
                    a.save flush: true
                }
            }
        }else{
            flash.message = "Please enter participant GeL ID, click Find Aliquot button then select aliquot/aliquots from the list."
            respond DNA_ExtractInstance, view: 'create'
            return
        }

        if (params.originalVolume && params.originalDnaId){
            def originalDNA = DNA_Extract.findById(params.long('originalDnaId'))
            if (originalDNA){
                def originalVolume = params.originalVolume
                originalVolume = originalVolume?.toString()?.toDouble()
                if (originalVolume > DNA_ExtractInstance.dNAAmount){
                    def newVolume = originalVolume - DNA_ExtractInstance.dNAAmount
                    originalDNA.dNAAmount = newVolume
                    originalDNA.save flush: true
                }
            }
        }

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'DNA_ExtractInstance.label', default: 'DNA_Extract'), DNA_ExtractInstance.id])
                redirect DNA_ExtractInstance
            }
            '*' { respond DNA_ExtractInstance, [status: CREATED] }
        }
    }

    def getElution() {
        def aliquot = Aliquot.findById(params.long('selectAliquot'))
        if(aliquot){
            def aliquotType = aliquot.getAliquotType()
            def selectExtractionType = ExtractionType.findById(params.long('selectExtractionType'))?.extractionTypeName
            if (selectExtractionType){
                if (selectExtractionType == "DNA Extraction"){
                    selectExtractionType = "DNA"
                } else if(selectExtractionType == "RNA Extraction") {
                    selectExtractionType = "RNA"
                }
            }
            def gelId = aliquot?.specimen?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}
            if (aliquotType && gelId && selectExtractionType){
                if (aliquotType.aliquotTypeName == 'Buffy Coat'){
                    def elution = gelId.toString() + "_" + selectExtractionType + "_GL_"
                    render([elution: elution] as XML)
                }else {
                    def elution = gelId.toString() + "_" + selectExtractionType + "_" + aliquotType.toString().replace(" ","") + "_"
                    render([elution: elution] as XML)
                }
            }
        }
    }

    def preDispatchReport(){
        List <IdentifiedSample> identifiedSampleList = new ArrayList()
        def positionMap = [:]
        if (!request.getFile('preDispatchCsvFile')?.originalFilename) {
            flash.message = "Please choose a file"
            redirect(uri: "/participant/summaryReport")
        }else{
            request.getFile('preDispatchCsvFile').inputStream.splitEachLine(',')
                { fields ->
                    def barcode = fields[1].trim()
                    if (barcode && barcode != "NO READ"){
                        def identifiedSample = IdentifiedSample.findByBarcode(barcode)
                        if (identifiedSample){
                            identifiedSampleList.add(identifiedSample)
                            positionMap.put(barcode,fields[0].trim())
                        }
                    }
                }
        }

        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename= Pre-dispatch report.${params.extension}")

            def position  = { domain, value ->
                if (domain.barcode){
                    return positionMap.get(domain.barcode)
                }else {
                    return ''
                }
            }

            def barcode  = { domain, value ->
                return domain?.barcode
            }

            def participanId  = { domain, value ->
                if (Aliquot.findById(domain.id)){
                    def gelId = domain.specimen.participant.studySubject.studySubjectIdentifier
                    gelId = gelId.toString().replace('[','')?.replace(']','')?.replace('null','')?.replace(',','')?.trim()
                    return gelId
                }else if (DNA_Extract.findById(domain.id)){
                    def gelId = domain.aliquot.specimen.participant.studySubject.studySubjectIdentifier
                    gelId = gelId.toString().replace('[','')?.replace(']','')?.replace('null','')?.replace(',','')?.trim()
                    return gelId
                }else {
                    return ''
                }
            }

            def sampleType  = { domain, value ->
                if (Aliquot.findById(domain.id)){
                    return domain.aliquotType
                }else if (DNA_Extract.findById(domain.id)){
                    def aliquotType = domain.aliquot.aliquotType
                    aliquotType = aliquotType.toString().replace('[','')?.replace(']','')
                    return aliquotType
                }else {
                    return ''
                }
            }
            Map formatters = ["Position":position, "Sample Barcode":barcode, "Participant Id": participanId, "Sample Type":sampleType]
            List fields = ["Position","Participant Id", "Sample Barcode", "Sample Type"]
            Map labels = [:]
            Map parameters = [title: "Pre-dispatch report", "column.widths": [0.1, 0.2, 0.2, 0.25]]
            exportService.export(params.format, response.outputStream, identifiedSampleList, fields, labels, formatters, parameters)
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def edit(DNA_Extract DNA_ExtractInstance) {
        respond DNA_ExtractInstance
    }

    @Transactional
    def update(DNA_Extract DNA_ExtractInstance) {
        if (DNA_ExtractInstance == null) {
            notFound()
            return
        }

        if (DNA_ExtractInstance.hasErrors()) {
            respond DNA_ExtractInstance.errors, view: 'edit'
            return
        }
        if (params.aliquot){
            DNA_ExtractInstance.save flush: true
            def exhaustAliquot = params.exhaustAliquot
            if (exhaustAliquot == 'True'){
                DNA_ExtractInstance.aliquot.each{ a->
                    a.exhausted = true
                    a.save flush: true
                }
            }

            request.withFormat {
                form {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'DNA_Extract.label', default: 'DNA_Extract'), DNA_ExtractInstance.id])
                    redirect DNA_ExtractInstance
                }
                '*' { respond DNA_ExtractInstance, [status: OK] }
            }
        }else{
            flash.message = "Please enter participant GeL ID, click Find Aliquot button then select aliquot/aliquots from the list."
            respond DNA_ExtractInstance, view: 'create'
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    @Transactional
    def delete(DNA_Extract DNA_ExtractInstance) {

        if (DNA_ExtractInstance == null) {
            notFound()
            return
        }

        DNA_ExtractInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DNA_Extract.label', default: 'DNA_Extract'), DNA_ExtractInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'DNA_ExtractInstance.label', default: 'DNA_Extract'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
