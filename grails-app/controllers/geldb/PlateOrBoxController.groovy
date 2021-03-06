package geldb

import grails.plugins.springsecurity.Secured
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.ss.usermodel.WorkbookFactory
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent
import org.grails.plugin.filterpane.FilterPaneUtils
import org.grails.plugins.excelimport.ExcelImportService
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * PlateOrBoxController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class PlateOrBoxController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PlateOrBox.list(params), model: [plateOrBoxInstanceCount: PlateOrBox.count()]
    }

//    def list(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond PlateOrBox.list(params), model: [plateOrBoxInstanceCount: PlateOrBox.count()]
//    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [plateOrBoxInstanceList: PlateOrBox.list(params), plateOrBoxInstanceTotal: PlateOrBox.count()]
    }
    def filterPaneService

    def filter = {
        if(!params.max) params.max = 10
        render( view:'list', model:[ plateOrBoxInstanceList: filterPaneService.filter( params, PlateOrBox ),
                                     plateOrBoxInstanceTotal: filterPaneService.count( params, PlateOrBox ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params), params:params ] )
    }

    def show(PlateOrBox plateOrBoxInstance) {
        def positionList = plateOrBoxInstance.well
        positionList = positionList.sort{it.letter+it.number}
        if (params.sort && params.order == "asc") {
            if (params.sort == 'studySubjectIdentifier') {
                if (DNA_Extract.findById(IdentifiedSample.findByPositionInListAndExhausted(positionList, false).id)){
                    positionList = positionList.sort {
                        it.containedSamples.aliquot.specimen.participant.studySubject.studySubjectIdentifier?.findResult {it?.size() ? it : null}?.toString() +it.containedSamples.aliquot.aliquotType.aliquotTypeName?.toString()
                    }
                }else {
                    positionList = positionList.sort {
                        it.containedSamples.specimen.participant.studySubject.studySubjectIdentifier?.findResult {it?.size() ? it : null}?.toString() +it.containedSamples.aliquotType.aliquotTypeName?.toString()
                    }
                }
            }else {
                positionList = positionList.sort{it.letter+it.number}
            }
        }

        if (params.sort && params.order == "desc"){
            if (params.sort == 'studySubjectIdentifier') {
                if (DNA_Extract.findById(IdentifiedSample.findByPositionInListAndExhausted(positionList, false).id)){
                    positionList = positionList.sort {
                        it.containedSamples.aliquot.specimen.participant.studySubject.studySubjectIdentifier?.findResult {it?.size() ? it : null}?.toString() +it.containedSamples.aliquot.aliquotType.aliquotTypeName?.toString()
                    }.reverse()
                }else {
                    positionList = positionList.sort {
                        it.containedSamples.specimen.participant.studySubject.studySubjectIdentifier?.findResult {it?.size() ? it : null}?.toString()  +it.containedSamples.aliquotType.aliquotTypeName?.toString()
                    }.reverse()
                }

            }else {
                positionList = positionList.sort{it.letter+it.number}
            }
        }
        def listPlateOrBoxAuditLogData = AuditLogEvent.findAllByPersistedObjectId(plateOrBoxInstance?.id)
        def listPositionAuditLogData = AuditLogEvent.findAllByPersistedObjectIdInList(plateOrBoxInstance?.well?.id)
        listPlateOrBoxAuditLogData.addAll(listPositionAuditLogData)
        respond plateOrBoxInstance, model: [listAuditLogData: listPlateOrBoxAuditLogData, positionList:positionList]
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def create() {
        respond new PlateOrBox(params)
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def getExcelImportService() {
        ExcelImportService.getService()
    }

    @Transactional
    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def uploadScannerFile(){
        def boxInstance = PlateOrBox.findById(params.long('box'))
        if (!request.getFile('file').originalFilename) {
            flash.message = "Please choose a file"
            redirect boxInstance
        } else{
            request.getFile('file').inputStream.splitEachLine(',')
                    { fields ->
                        def identifiedSample = IdentifiedSample.findByBarcodeAndExhausted(fields[1].trim(), false)
                        if (identifiedSample) {
                            def scannedPosition = fields[0].trim()
                            def letter = scannedPosition?.toString()?.substring(0,1)
                            def number = scannedPosition?.toString()?.substring(1, scannedPosition?.toString()?.length())
                            if (letter && number && !Position.findByLetterAndNumberAndPlateOrBox(letter, number, boxInstance)){
                                def position = new Position(letter: letter, number: number, plateOrBox: boxInstance)
                                position.addToContainedSamples(identifiedSample).save flush: true
                            }else if (letter && number && Position.findByLetterAndNumberAndPlateOrBox(letter, number, boxInstance)){
                                def position = Position.findByLetterAndNumberAndPlateOrBox(letter, number, boxInstance)
                                def nonExhaustedSample = position.containedSamples.findAll {s -> !s.exhausted}
                                if (!nonExhaustedSample){
                                    position.addToContainedSamples(identifiedSample).save flush: true
                                }
                            }
                        }
                    }
            redirect boxInstance
        }
    }

    @Transactional
    def save(PlateOrBox plateOrBoxInstance) {
        if (plateOrBoxInstance == null) {
            notFound()
            return
        }

        if (plateOrBoxInstance.hasErrors()) {
            respond plateOrBoxInstance.errors, view: 'create'
            return
        }

        plateOrBoxInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'plateOrBoxInstance.label', default: 'PlateOrBox'), plateOrBoxInstance.id])
                redirect plateOrBoxInstance
            }
            '*' { respond plateOrBoxInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def edit(PlateOrBox plateOrBoxInstance) {
        respond plateOrBoxInstance
    }

    @Transactional
    def update(PlateOrBox plateOrBoxInstance) {
        if (plateOrBoxInstance == null) {
            notFound()
            return
        }

        if (plateOrBoxInstance.hasErrors()) {
            respond plateOrBoxInstance.errors, view: 'edit'
            return
        }

        plateOrBoxInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PlateOrBox.label', default: 'PlateOrBox'), plateOrBoxInstance.id])
                redirect plateOrBoxInstance
            }
            '*' { respond plateOrBoxInstance, [status: OK] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    @Transactional
    def delete(PlateOrBox plateOrBoxInstance) {

        if (plateOrBoxInstance == null) {
            notFound()
            return
        }

        plateOrBoxInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PlateOrBox.label', default: 'PlateOrBox'), plateOrBoxInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'plateOrBoxInstance.label', default: 'PlateOrBox'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
