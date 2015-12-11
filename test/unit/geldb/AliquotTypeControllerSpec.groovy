package geldb


import grails.test.mixin.*
import spock.lang.*

@TestFor(AliquotTypeController)
@Mock(AliquotType)
class AliquotTypeControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        params["aliquotTypeName"] = 'aliquotTypeName'
        params["aliquotTypeDesc"] = 'aliquotTypeDesc'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.aliquotTypeInstanceList
        model.aliquotTypeInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.aliquotTypeInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        def aliquotType = new AliquotType()
        aliquotType.validate()
        controller.save(aliquotType)

        then: "The create view is rendered again with the correct model"
        model.aliquotTypeInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        aliquotType = new AliquotType(params)
        controller.request.method = "POST"
        request.format = 'form'
        controller.save(aliquotType)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/aliquotType/show/1'
        controller.flash.message != null
        AliquotType.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def aliquotType = new AliquotType(params)
        controller.show(aliquotType)

        then: "A model is populated containing the domain instance"
        model.aliquotTypeInstance == aliquotType
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def aliquotType = new AliquotType(params)
        controller.edit(aliquotType)

        then: "A model is populated containing the domain instance"
        model.aliquotTypeInstance == aliquotType
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        controller.request.method = "POST"
        request.format = 'form'
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/aliquotType/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def aliquotType = new AliquotType()
        aliquotType.validate()
        controller.update(aliquotType)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.aliquotTypeInstance == aliquotType

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        aliquotType = new AliquotType(params).save(flush: true)
        controller.request.method = "POST"
        request.format = 'form'
        controller.update(aliquotType)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/aliquotType/show/$aliquotType.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        controller.request.method = "POST"
        request.format = 'form'
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/aliquotType/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def aliquotType = new AliquotType(params).save(flush: true)

        then: "It exists"
        AliquotType.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.request.method = "POST"
        request.format = 'form'
        controller.delete(aliquotType)

        then: "The instance is deleted"
        AliquotType.count() == 0
        response.redirectedUrl == '/aliquotType/index'
        flash.message != null
    }
}
