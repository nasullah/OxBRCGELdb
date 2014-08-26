package geldb



import grails.test.mixin.*
import spock.lang.*

@TestFor(PlateOrBoxController)
@Mock(PlateOrBox)
class PlateOrBoxControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.plateOrBoxInstanceList
            model.plateOrBoxInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.plateOrBoxInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def plateOrBox = new PlateOrBox()
            plateOrBox.validate()
            controller.save(plateOrBox)

        then:"The create view is rendered again with the correct model"
            model.plateOrBoxInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            plateOrBox = new PlateOrBox(params)

            controller.save(plateOrBox)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/plateOrBox/show/1'
            controller.flash.message != null
            PlateOrBox.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def plateOrBox = new PlateOrBox(params)
            controller.show(plateOrBox)

        then:"A model is populated containing the domain instance"
            model.plateOrBoxInstance == plateOrBox
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def plateOrBox = new PlateOrBox(params)
            controller.edit(plateOrBox)

        then:"A model is populated containing the domain instance"
            model.plateOrBoxInstance == plateOrBox
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/plateOrBox/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def plateOrBox = new PlateOrBox()
            plateOrBox.validate()
            controller.update(plateOrBox)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.plateOrBoxInstance == plateOrBox

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            plateOrBox = new PlateOrBox(params).save(flush: true)
            controller.update(plateOrBox)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/plateOrBox/show/$plateOrBox.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/plateOrBox/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def plateOrBox = new PlateOrBox(params).save(flush: true)

        then:"It exists"
            PlateOrBox.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(plateOrBox)

        then:"The instance is deleted"
            PlateOrBox.count() == 0
            response.redirectedUrl == '/plateOrBox/index'
            flash.message != null
    }
}
