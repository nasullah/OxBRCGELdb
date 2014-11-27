package geldb


import grails.test.mixin.*
import spock.lang.*

@TestFor(CollectionMethodController)
@Mock(CollectionMethod)
class CollectionMethodControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.collectionMethodInstanceList
        model.collectionMethodInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.collectionMethodInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        def collectionMethod = new CollectionMethod()
        collectionMethod.validate()
        controller.save(collectionMethod)

        then: "The create view is rendered again with the correct model"
        model.collectionMethodInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        collectionMethod = new CollectionMethod(params)

        controller.save(collectionMethod)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/collectionMethod/show/1'
        controller.flash.message != null
        CollectionMethod.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def collectionMethod = new CollectionMethod(params)
        controller.show(collectionMethod)

        then: "A model is populated containing the domain instance"
        model.collectionMethodInstance == collectionMethod
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def collectionMethod = new CollectionMethod(params)
        controller.edit(collectionMethod)

        then: "A model is populated containing the domain instance"
        model.collectionMethodInstance == collectionMethod
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/collectionMethod/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def collectionMethod = new CollectionMethod()
        collectionMethod.validate()
        controller.update(collectionMethod)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.collectionMethodInstance == collectionMethod

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        collectionMethod = new CollectionMethod(params).save(flush: true)
        controller.update(collectionMethod)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/collectionMethod/show/$collectionMethod.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/collectionMethod/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def collectionMethod = new CollectionMethod(params).save(flush: true)

        then: "It exists"
        CollectionMethod.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(collectionMethod)

        then: "The instance is deleted"
        CollectionMethod.count() == 0
        response.redirectedUrl == '/collectionMethod/index'
        flash.message != null
    }
}
