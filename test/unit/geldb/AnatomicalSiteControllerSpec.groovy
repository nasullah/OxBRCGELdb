package geldb


import grails.test.mixin.*
import spock.lang.*

@TestFor(AnatomicalSiteController)
@Mock(AnatomicalSite)
class AnatomicalSiteControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        params["anatomicalSiteCode"] = 'anatomicalSiteCode'
        params["anatomicalSiteName"] = 'anatomicalSiteName'
        params["anatomicalSiteDescription"] = 'anatomicalSiteDescription'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.anatomicalSiteInstanceList
        model.anatomicalSiteInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.anatomicalSiteInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        def anatomicalSite = new AnatomicalSite()
        anatomicalSite.validate()
        controller.save(anatomicalSite)

        then: "The create view is rendered again with the correct model"
        model.anatomicalSiteInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        anatomicalSite = new AnatomicalSite(params)
        controller.request.method = "POST"
        request.format = 'form'
        controller.save(anatomicalSite)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/anatomicalSite/show/1'
        controller.flash.message != null
        AnatomicalSite.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def anatomicalSite = new AnatomicalSite(params)
        controller.show(anatomicalSite)

        then: "A model is populated containing the domain instance"
        model.anatomicalSiteInstance == anatomicalSite
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def anatomicalSite = new AnatomicalSite(params)
        controller.edit(anatomicalSite)

        then: "A model is populated containing the domain instance"
        model.anatomicalSiteInstance == anatomicalSite
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        controller.request.method = "POST"
        request.format = 'form'
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/anatomicalSite/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def anatomicalSite = new AnatomicalSite()
        anatomicalSite.validate()
        controller.update(anatomicalSite)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.anatomicalSiteInstance == anatomicalSite

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        anatomicalSite = new AnatomicalSite(params).save(flush: true)
        controller.request.method = "POST"
        request.format = 'form'
        controller.update(anatomicalSite)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/anatomicalSite/show/$anatomicalSite.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        controller.request.method = "POST"
        request.format = 'form'
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/anatomicalSite/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def anatomicalSite = new AnatomicalSite(params).save(flush: true)

        then: "It exists"
        AnatomicalSite.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.request.method = "POST"
        request.format = 'form'
        controller.delete(anatomicalSite)

        then: "The instance is deleted"
        AnatomicalSite.count() == 0
        response.redirectedUrl == '/anatomicalSite/index'
        flash.message != null
    }
}
