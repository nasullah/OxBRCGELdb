package geldb

import grails.plugins.springsecurity.Secured
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * DispatchedBoxController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class DispatchedBoxController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DispatchedBox.list(params), model:[dispatchedBoxInstanceCount: DispatchedBox.count()]
    }

	def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DispatchedBox.list(params), model:[dispatchedBoxInstanceCount: DispatchedBox.count()]
    }

    def show(DispatchedBox dispatchedBoxInstance) {
        def dispatchItemList = dispatchedBoxInstance?.dispatchItems?.sort{it.positionIfPlated}

        if (params.sort && params.order == "asc") {
            if (params.sort == 'aliquot.specimen.participant.studySubject.studySubjectIdentifier'){
                dispatchItemList = dispatchItemList.sort{it.identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier}
            } else if (params.sort == 'specimen.participant.studySubject.studySubjectIdentifier'){
                dispatchItemList = dispatchItemList.sort{it.identifiedSample.specimen.participant.studySubject.studySubjectIdentifier}
            } else if(params.sort == 'positionIfPlated'){
                dispatchItemList = dispatchItemList.sort{it.positionIfPlated}
            }
        }

        if (params.sort && params.order == "desc"){
            if (params.sort == 'aliquot.specimen.participant.studySubject.studySubjectIdentifier'){
                dispatchItemList = dispatchItemList.sort{it.identifiedSample.aliquot.specimen.participant.studySubject.studySubjectIdentifier}.reverse()
            } else if (params.sort == 'specimen.participant.studySubject.studySubjectIdentifier'){
                dispatchItemList = dispatchItemList.sort{it.identifiedSample.specimen.participant.studySubject.studySubjectIdentifier}.reverse()
            } else if(params.sort == 'positionIfPlated'){
                dispatchItemList = dispatchItemList.sort{it.positionIfPlated}.reverse()
            }
        }

        def listDispatchedBoxAuditLogData = AuditLogEvent.findAllByPersistedObjectId(dispatchedBoxInstance?.id)
        def listDispatchItemAuditLogData = AuditLogEvent.findAllByPersistedObjectIdInList(dispatchedBoxInstance?.dispatchItems?.id)
        listDispatchedBoxAuditLogData.addAll(listDispatchItemAuditLogData)
        [dispatchedBoxInstance: dispatchedBoxInstance, dispatchItemList: dispatchItemList, listAuditLogData: listDispatchedBoxAuditLogData]
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def create() {
        respond new DispatchedBox(params)
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def uploadFile = {
        def dispatchedBox = DispatchedBox.findById(params.long('dispatchedBox'))
        if (!request.getFile('file').originalFilename) {
            flash.message = "Please choose a file"
            redirect(controller:'dispatchedBox',action: 'show', params: [id: dispatchedBox.id])
        } else{
            def passedList = []
            def failedList = []
            request.getFile('file').inputStream.splitEachLine(',')
                    { fields ->
                        def row = 'Position: ' + fields[0].trim()  + '--------------------' +'Barcode: ' + fields[1].trim()
                        def identifiedSample = IdentifiedSample.findByBarcodeAndExhausted(fields[1].trim(), false)
                        if (identifiedSample) {
                            def dispatchItemInstance = new DispatchItem()
                            dispatchItemInstance.identifiedSample = identifiedSample
                            if (DNA_Extract.findById(identifiedSample.id)){
                                dispatchItemInstance.volume_ul = identifiedSample.dNAAmount
                            }else if (Aliquot.findById(identifiedSample.id)){
                                dispatchItemInstance.volume_ul = identifiedSample.aliquotVolumeMass
                            }
                            dispatchItemInstance.positionIfPlated = fields[0].trim()
                            dispatchItemInstance.dispatchedBox = dispatchedBox
                            if (dispatchItemInstance.volume_ul){
                                dispatchItemInstance.save flush: true
                                passedList.add(row)
                                for (item in IdentifiedSample.listOrderById()) {
                                    if (item.id == dispatchItemInstance.identifiedSample.id) {
                                        item.exhausted = true
                                        item.save flush: true
                                    }
                                }
                            }else{
                                failedList.add(row)
                            }
                        }else{
                            failedList.add(row)
                        }
                    }
            [dispatchedBox: dispatchedBox.id, failedList:failedList, passedList:passedList]
        }
    }

    @Transactional
    def save(DispatchedBox dispatchedBoxInstance) {
        if (dispatchedBoxInstance == null) {
            notFound()
            return
        }

        if (dispatchedBoxInstance.hasErrors()) {
            respond dispatchedBoxInstance.errors, view:'create'
            return
        }

        dispatchedBoxInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'dispatchedBoxInstance.label', default: 'DispatchedBox'), dispatchedBoxInstance.id])
                redirect dispatchedBoxInstance
            }
            '*' { respond dispatchedBoxInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def edit(DispatchedBox dispatchedBoxInstance) {
        respond dispatchedBoxInstance
    }

    @Transactional
    def update(DispatchedBox dispatchedBoxInstance) {
        if (dispatchedBoxInstance == null) {
            notFound()
            return
        }

        if (dispatchedBoxInstance.hasErrors()) {
            respond dispatchedBoxInstance.errors, view:'edit'
            return
        }

        dispatchedBoxInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DispatchedBox.label', default: 'DispatchedBox'), dispatchedBoxInstance.id])
                redirect dispatchedBoxInstance
            }
            '*'{ respond dispatchedBoxInstance, [status: OK] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    @Transactional
    def delete(DispatchedBox dispatchedBoxInstance) {

        if (dispatchedBoxInstance == null) {
            notFound()
            return
        }

        dispatchedBoxInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DispatchedBox.label', default: 'DispatchedBox'), dispatchedBoxInstance.id])
//                redirect action:"index", method:"GET"
                redirect(controller:'dispatchRecord',action: 'show', params: [id: dispatchedBoxInstance.dispatchRecord.id])
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'dispatchedBoxInstance.label', default: 'DispatchedBox'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
