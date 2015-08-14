package geldb


import grails.test.mixin.*
import spock.lang.*

//@TestFor(Library_QC_ReportController)
//@Mock(Library_QC_Report)
class Library_QC_ReportControllerSpec extends Specification {
//
//    def populateValidParams(params) {
//        assert params != null
//        // TODO: Populate valid properties like...
//        //params["name"] = 'someValidName'
//    }
//
//    void "Test the index action returns the correct model"() {
//
//        when: "The index action is executed"
//        controller.index()
//
//        then: "The model is correct"
//        !model.library_QC_ReportInstanceList
//        model.library_QC_ReportInstanceCount == 0
//    }
//
//    void "Test the create action returns the correct model"() {
//        when: "The create action is executed"
//        controller.create()
//
//        then: "The model is correctly created"
//        model.library_QC_ReportInstance != null
//    }
//
//    void "Test the save action correctly persists an instance"() {
//
//        when: "The save action is executed with an invalid instance"
//        request.contentType = FORM_CONTENT_TYPE
//        def library_QC_Report = new Library_QC_Report()
//        library_QC_Report.validate()
//        controller.save(library_QC_Report)
//
//        then: "The create view is rendered again with the correct model"
//        model.library_QC_ReportInstance != null
//        view == 'create'
//
//        when: "The save action is executed with a valid instance"
//        response.reset()
//        populateValidParams(params)
//        library_QC_Report = new Library_QC_Report(params)
//
//        controller.save(library_QC_Report)
//
//        then: "A redirect is issued to the show action"
//        response.redirectedUrl == '/library_QC_Report/show/1'
//        controller.flash.message != null
//        Library_QC_Report.count() == 1
//    }
//
//    void "Test that the show action returns the correct model"() {
//        when: "The show action is executed with a null domain"
//        controller.show(null)
//
//        then: "A 404 error is returned"
//        response.status == 404
//
//        when: "A domain instance is passed to the show action"
//        populateValidParams(params)
//        def library_QC_Report = new Library_QC_Report(params)
//        controller.show(library_QC_Report)
//
//        then: "A model is populated containing the domain instance"
//        model.library_QC_ReportInstance == library_QC_Report
//    }
//
//    void "Test that the edit action returns the correct model"() {
//        when: "The edit action is executed with a null domain"
//        controller.edit(null)
//
//        then: "A 404 error is returned"
//        response.status == 404
//
//        when: "A domain instance is passed to the edit action"
//        populateValidParams(params)
//        def library_QC_Report = new Library_QC_Report(params)
//        controller.edit(library_QC_Report)
//
//        then: "A model is populated containing the domain instance"
//        model.library_QC_ReportInstance == library_QC_Report
//    }
//
//    void "Test the update action performs an update on a valid domain instance"() {
//        when: "Update is called for a domain instance that doesn't exist"
//        request.contentType = FORM_CONTENT_TYPE
//        controller.update(null)
//
//        then: "A 404 error is returned"
//        response.redirectedUrl == '/library_QC_Report/index'
//        flash.message != null
//
//
//        when: "An invalid domain instance is passed to the update action"
//        response.reset()
//        def library_QC_Report = new Library_QC_Report()
//        library_QC_Report.validate()
//        controller.update(library_QC_Report)
//
//        then: "The edit view is rendered again with the invalid instance"
//        view == 'edit'
//        model.library_QC_ReportInstance == library_QC_Report
//
//        when: "A valid domain instance is passed to the update action"
//        response.reset()
//        populateValidParams(params)
//        library_QC_Report = new Library_QC_Report(params).save(flush: true)
//        controller.update(library_QC_Report)
//
//        then: "A redirect is issues to the show action"
//        response.redirectedUrl == "/library_QC_Report/show/$library_QC_Report.id"
//        flash.message != null
//    }
//
//    void "Test that the delete action deletes an instance if it exists"() {
//        when: "The delete action is called for a null instance"
//        request.contentType = FORM_CONTENT_TYPE
//        controller.delete(null)
//
//        then: "A 404 is returned"
//        response.redirectedUrl == '/library_QC_Report/index'
//        flash.message != null
//
//        when: "A domain instance is created"
//        response.reset()
//        populateValidParams(params)
//        def library_QC_Report = new Library_QC_Report(params).save(flush: true)
//
//        then: "It exists"
//        Library_QC_Report.count() == 1
//
//        when: "The domain instance is passed to the delete action"
//        controller.delete(library_QC_Report)
//
//        then: "The instance is deleted"
//        Library_QC_Report.count() == 0
//        response.redirectedUrl == '/library_QC_Report/index'
//        flash.message != null
//    }
}
