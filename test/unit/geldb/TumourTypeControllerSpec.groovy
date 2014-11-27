package geldb


import grails.test.mixin.*
import spock.lang.*

@TestFor(TumourTypeController)
@Mock(TumourType)
class TumourTypeControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.tumourTypeInstanceList
        model.tumourTypeInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.tumourTypeInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        def tumourType = new TumourType()
        tumourType.validate()
        controller.save(tumourType)

        then: "The create view is rendered again with the correct model"
        model.tumourTypeInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        tumourType = new TumourType(params)

        controller.save(tumourType)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/tumourType/show/1'
        controller.flash.message != null
        TumourType.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def tumourType = new TumourType(params)
        controller.show(tumourType)

        then: "A model is populated containing the domain instance"
        model.tumourTypeInstance == tumourType
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def tumourType = new TumourType(params)
        controller.edit(tumourType)

        then: "A model is populated containing the domain instance"
        model.tumourTypeInstance == tumourType
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/tumourType/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def tumourType = new TumourType()
        tumourType.validate()
        controller.update(tumourType)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.tumourTypeInstance == tumourType

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        tumourType = new TumourType(params).save(flush: true)
        controller.update(tumourType)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/tumourType/show/$tumourType.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/tumourType/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def tumourType = new TumourType(params).save(flush: true)

        then: "It exists"
        TumourType.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(tumourType)

        then: "The instance is deleted"
        TumourType.count() == 0
        response.redirectedUrl == '/tumourType/index'
        flash.message != null
    }
}
