package geldb



import grails.test.mixin.*
import spock.lang.*

@TestFor(UnitsController)
@Mock(Units)
class UnitsControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        params["unitType"] = 'MassUnit'
        params["unitName"] = 'unitName'
        params["unitDescription"] = 'unitDescription'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.unitsInstanceList
            model.unitsInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.unitsInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def units = new Units()
            units.validate()
            controller.save(units)

        then:"The create view is rendered again with the correct model"
            model.unitsInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            units = new Units(params)
            controller.request.method = "POST"
            request.format = 'form'
            controller.save(units)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/units/show/1'
            controller.flash.message != null
            Units.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def units = new Units(params)
            controller.show(units)

        then:"A model is populated containing the domain instance"
            model.unitsInstance == units
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def units = new Units(params)
            controller.edit(units)

        then:"A model is populated containing the domain instance"
            model.unitsInstance == units
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.request.method = "POST"
            request.format = 'form'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/units/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def units = new Units()
            units.validate()
            controller.update(units)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.unitsInstance == units

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            units = new Units(params).save(flush: true)
            controller.request.method = "POST"
            request.format = 'form'
            controller.update(units)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/units/show/$units.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/units/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def units = new Units(params).save(flush: true)

        then:"It exists"
            Units.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(units)

        then:"The instance is deleted"
            Units.count() == 0
            response.redirectedUrl == '/units/index'
            flash.message != null
    }
}
