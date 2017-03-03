package geldb


import grails.test.mixin.*
import spock.lang.*

@TestFor(DiseaseTypeController)
@Mock(DiseaseType)
class DiseaseTypeControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.diseaseTypeInstanceList
        model.diseaseTypeInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.diseaseTypeInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        def diseaseType = new DiseaseType()
        diseaseType.validate()
        controller.save(diseaseType)

        then: "The create view is rendered again with the correct model"
        model.diseaseTypeInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        diseaseType = new DiseaseType(params)

        controller.save(diseaseType)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/diseaseType/show/1'
        controller.flash.message != null
        DiseaseType.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def diseaseType = new DiseaseType(params)
        controller.show(diseaseType)

        then: "A model is populated containing the domain instance"
        model.diseaseTypeInstance == diseaseType
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def diseaseType = new DiseaseType(params)
        controller.edit(diseaseType)

        then: "A model is populated containing the domain instance"
        model.diseaseTypeInstance == diseaseType
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/diseaseType/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def diseaseType = new DiseaseType()
        diseaseType.validate()
        controller.update(diseaseType)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.diseaseTypeInstance == diseaseType

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        diseaseType = new DiseaseType(params).save(flush: true)
        controller.update(diseaseType)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/diseaseType/show/$diseaseType.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/diseaseType/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def diseaseType = new DiseaseType(params).save(flush: true)

        then: "It exists"
        DiseaseType.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(diseaseType)

        then: "The instance is deleted"
        DiseaseType.count() == 0
        response.redirectedUrl == '/diseaseType/index'
        flash.message != null
    }
}
