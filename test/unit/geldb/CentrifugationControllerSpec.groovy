package geldb



import grails.test.mixin.*
import spock.lang.*

@TestFor(CentrifugationController)
@Mock(Centrifugation)
class CentrifugationControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.centrifugationInstanceList
            model.centrifugationInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.centrifugationInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def centrifugation = new Centrifugation()
            centrifugation.validate()
            controller.save(centrifugation)

        then:"The create view is rendered again with the correct model"
            model.centrifugationInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            centrifugation = new Centrifugation(params)

            controller.save(centrifugation)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/centrifugation/show/1'
            controller.flash.message != null
            Centrifugation.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def centrifugation = new Centrifugation(params)
            controller.show(centrifugation)

        then:"A model is populated containing the domain instance"
            model.centrifugationInstance == centrifugation
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def centrifugation = new Centrifugation(params)
            controller.edit(centrifugation)

        then:"A model is populated containing the domain instance"
            model.centrifugationInstance == centrifugation
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/centrifugation/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def centrifugation = new Centrifugation()
            centrifugation.validate()
            controller.update(centrifugation)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.centrifugationInstance == centrifugation

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            centrifugation = new Centrifugation(params).save(flush: true)
            controller.update(centrifugation)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/centrifugation/show/$centrifugation.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/centrifugation/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def centrifugation = new Centrifugation(params).save(flush: true)

        then:"It exists"
            Centrifugation.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(centrifugation)

        then:"The instance is deleted"
            Centrifugation.count() == 0
            response.redirectedUrl == '/centrifugation/index'
            flash.message != null
    }
}
