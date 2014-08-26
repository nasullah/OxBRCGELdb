package geldb



import grails.test.mixin.*
import spock.lang.*

@TestFor(TestDateController)
@Mock(TestDate)
class TestDateControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.testDateInstanceList
            model.testDateInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.testDateInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def testDate = new TestDate()
            testDate.validate()
            controller.save(testDate)

        then:"The create view is rendered again with the correct model"
            model.testDateInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            testDate = new TestDate(params)

            controller.save(testDate)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/testDate/show/1'
            controller.flash.message != null
            TestDate.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def testDate = new TestDate(params)
            controller.show(testDate)

        then:"A model is populated containing the domain instance"
            model.testDateInstance == testDate
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def testDate = new TestDate(params)
            controller.edit(testDate)

        then:"A model is populated containing the domain instance"
            model.testDateInstance == testDate
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/testDate/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def testDate = new TestDate()
            testDate.validate()
            controller.update(testDate)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.testDateInstance == testDate

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            testDate = new TestDate(params).save(flush: true)
            controller.update(testDate)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/testDate/show/$testDate.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/testDate/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def testDate = new TestDate(params).save(flush: true)

        then:"It exists"
            TestDate.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(testDate)

        then:"The instance is deleted"
            TestDate.count() == 0
            response.redirectedUrl == '/testDate/index'
            flash.message != null
    }
}
