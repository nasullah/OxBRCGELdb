package geldb



import grails.test.mixin.*
import spock.lang.*

@TestFor(Extract_QC_ReportController)
@Mock(Extract_QC_Report)
class Extract_QC_ReportControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.extract_QC_ReportInstanceList
            model.extract_QC_ReportInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.extract_QC_ReportInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            def extract_QC_Report = new Extract_QC_Report()
            extract_QC_Report.validate()
            controller.save(extract_QC_Report)

        then:"The create view is rendered again with the correct model"
            model.extract_QC_ReportInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            extract_QC_Report = new Extract_QC_Report(params)

            controller.save(extract_QC_Report)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/extract_QC_Report/show/1'
            controller.flash.message != null
            Extract_QC_Report.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def extract_QC_Report = new Extract_QC_Report(params)
            controller.show(extract_QC_Report)

        then:"A model is populated containing the domain instance"
            model.extract_QC_ReportInstance == extract_QC_Report
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def extract_QC_Report = new Extract_QC_Report(params)
            controller.edit(extract_QC_Report)

        then:"A model is populated containing the domain instance"
            model.extract_QC_ReportInstance == extract_QC_Report
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/extract_QC_Report/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def extract_QC_Report = new Extract_QC_Report()
            extract_QC_Report.validate()
            controller.update(extract_QC_Report)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.extract_QC_ReportInstance == extract_QC_Report

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            extract_QC_Report = new Extract_QC_Report(params).save(flush: true)
            controller.update(extract_QC_Report)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/extract_QC_Report/show/$extract_QC_Report.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/extract_QC_Report/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def extract_QC_Report = new Extract_QC_Report(params).save(flush: true)

        then:"It exists"
            Extract_QC_Report.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(extract_QC_Report)

        then:"The instance is deleted"
            Extract_QC_Report.count() == 0
            response.redirectedUrl == '/extract_QC_Report/index'
            flash.message != null
    }
}
