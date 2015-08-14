package geldb


import grails.test.mixin.*
import spock.lang.*

//@TestFor(PlateController)
//@Mock(Plate)
class PlateControllerSpec extends Specification {

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
//        !model.plateInstanceList
//        model.plateInstanceCount == 0
//    }
//
//    void "Test the create action returns the correct model"() {
//        when: "The create action is executed"
//        controller.create()
//
//        then: "The model is correctly created"
//        model.plateInstance != null
//    }
//
//    void "Test the save action correctly persists an instance"() {
//
//        when: "The save action is executed with an invalid instance"
//        def plate = new Plate()
//        plate.validate()
//        controller.save(plate)
//
//        then: "The create view is rendered again with the correct model"
//        model.plateInstance != null
//        view == 'create'
//
//        when: "The save action is executed with a valid instance"
//        response.reset()
//        populateValidParams(params)
//        plate = new Plate(params)
//
//        controller.save(plate)
//
//        then: "A redirect is issued to the show action"
//        response.redirectedUrl == '/plate/show/1'
//        controller.flash.message != null
//        Plate.count() == 1
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
//        def plate = new Plate(params)
//        controller.show(plate)
//
//        then: "A model is populated containing the domain instance"
//        model.plateInstance == plate
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
//        def plate = new Plate(params)
//        controller.edit(plate)
//
//        then: "A model is populated containing the domain instance"
//        model.plateInstance == plate
//    }
//
//    void "Test the update action performs an update on a valid domain instance"() {
//        when: "Update is called for a domain instance that doesn't exist"
//        controller.update(null)
//
//        then: "A 404 error is returned"
//        response.redirectedUrl == '/plate/index'
//        flash.message != null
//
//
//        when: "An invalid domain instance is passed to the update action"
//        response.reset()
//        def plate = new Plate()
//        plate.validate()
//        controller.update(plate)
//
//        then: "The edit view is rendered again with the invalid instance"
//        view == 'edit'
//        model.plateInstance == plate
//
//        when: "A valid domain instance is passed to the update action"
//        response.reset()
//        populateValidParams(params)
//        plate = new Plate(params).save(flush: true)
//        controller.update(plate)
//
//        then: "A redirect is issues to the show action"
//        response.redirectedUrl == "/plate/show/$plate.id"
//        flash.message != null
//    }
//
//    void "Test that the delete action deletes an instance if it exists"() {
//        when: "The delete action is called for a null instance"
//        controller.delete(null)
//
//        then: "A 404 is returned"
//        response.redirectedUrl == '/plate/index'
//        flash.message != null
//
//        when: "A domain instance is created"
//        response.reset()
//        populateValidParams(params)
//        def plate = new Plate(params).save(flush: true)
//
//        then: "It exists"
//        Plate.count() == 1
//
//        when: "The domain instance is passed to the delete action"
//        controller.delete(plate)
//
//        then: "The instance is deleted"
//        Plate.count() == 0
//        response.redirectedUrl == '/plate/index'
//        flash.message != null
//    }
}
