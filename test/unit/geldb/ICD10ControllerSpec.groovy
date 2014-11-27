package geldb


import grails.test.mixin.*
import spock.lang.*

@TestFor(ICD10Controller)
@Mock(ICD10)
class ICD10ControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.ICD10InstanceList
        model.ICD10InstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.ICD10Instance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        def ICD10 = new ICD10()
        ICD10.validate()
        controller.save(ICD10)

        then: "The create view is rendered again with the correct model"
        model.ICD10Instance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        ICD10 = new ICD10(params)

        controller.save(ICD10)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/ICD10/show/1'
        controller.flash.message != null
        ICD10.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def ICD10 = new ICD10(params)
        controller.show(ICD10)

        then: "A model is populated containing the domain instance"
        model.ICD10Instance == ICD10
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def ICD10 = new ICD10(params)
        controller.edit(ICD10)

        then: "A model is populated containing the domain instance"
        model.ICD10Instance == ICD10
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/ICD10/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def ICD10 = new ICD10()
        ICD10.validate()
        controller.update(ICD10)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.ICD10Instance == ICD10

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        ICD10 = new ICD10(params).save(flush: true)
        controller.update(ICD10)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/ICD10/show/$ICD10.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/ICD10/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def ICD10 = new ICD10(params).save(flush: true)

        then: "It exists"
        ICD10.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(ICD10)

        then: "The instance is deleted"
        ICD10.count() == 0
        response.redirectedUrl == '/ICD10/index'
        flash.message != null
    }
}
