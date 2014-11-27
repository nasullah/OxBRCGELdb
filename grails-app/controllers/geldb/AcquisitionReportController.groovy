//package geldb
//
//
//import static org.springframework.http.HttpStatus.*
//import grails.transaction.Transactional
//
///**
// * AcquisitionReportController
// * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
// */
//@Transactional(readOnly = true)
//class AcquisitionReportController {
//
//    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
//
//    def index(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond AcquisitionReport.list(params), model: [acquisitionReportInstanceCount: AcquisitionReport.count()]
//    }
//
//    def list(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond AcquisitionReport.list(params), model: [acquisitionReportInstanceCount: AcquisitionReport.count()]
//    }
//
//    def show(AcquisitionReport acquisitionReportInstance) {
//        respond acquisitionReportInstance
//    }
//
//    def create() {
//        respond new AcquisitionReport(params)
//    }
//
//    @Transactional
//    def save(AcquisitionReport acquisitionReportInstance) {
//        if (acquisitionReportInstance == null) {
//            notFound()
//            return
//        }
//
//        if (acquisitionReportInstance.hasErrors()) {
//            respond acquisitionReportInstance.errors, view: 'create'
//            return
//        }
//
//        acquisitionReportInstance.save flush: true
//
//        request.withFormat {
//            form {
//                flash.message = message(code: 'default.created.message', args: [message(code: 'acquisitionReportInstance.label', default: 'AcquisitionReport'), acquisitionReportInstance.id])
//                redirect acquisitionReportInstance
//            }
//            '*' { respond acquisitionReportInstance, [status: CREATED] }
//        }
//    }
//
//    def edit(AcquisitionReport acquisitionReportInstance) {
//        respond acquisitionReportInstance
//    }
//
//    @Transactional
//    def update(AcquisitionReport acquisitionReportInstance) {
//        if (acquisitionReportInstance == null) {
//            notFound()
//            return
//        }
//
//        if (acquisitionReportInstance.hasErrors()) {
//            respond acquisitionReportInstance.errors, view: 'edit'
//            return
//        }
//
//        acquisitionReportInstance.save flush: true
//
//        request.withFormat {
//            form {
//                flash.message = message(code: 'default.updated.message', args: [message(code: 'AcquisitionReport.label', default: 'AcquisitionReport'), acquisitionReportInstance.id])
//                redirect acquisitionReportInstance
//            }
//            '*' { respond acquisitionReportInstance, [status: OK] }
//        }
//    }
//
//    @Transactional
//    def delete(AcquisitionReport acquisitionReportInstance) {
//
//        if (acquisitionReportInstance == null) {
//            notFound()
//            return
//        }
//
//        acquisitionReportInstance.delete flush: true
//
//        request.withFormat {
//            form {
//                flash.message = message(code: 'default.deleted.message', args: [message(code: 'AcquisitionReport.label', default: 'AcquisitionReport'), acquisitionReportInstance.id])
//                redirect action: "index", method: "GET"
//            }
//            '*' { render status: NO_CONTENT }
//        }
//    }
//
//    protected void notFound() {
//        request.withFormat {
//            form {
//                flash.message = message(code: 'default.not.found.message', args: [message(code: 'acquisitionReportInstance.label', default: 'AcquisitionReport'), params.id])
//                redirect action: "index", method: "GET"
//            }
//            '*' { render status: NOT_FOUND }
//        }
//    }
//}
