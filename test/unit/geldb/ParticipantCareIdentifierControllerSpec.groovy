package geldb


import grails.test.mixin.*
import spock.lang.*

@TestFor(ParticipantCareIdentifierController)
@Mock(ParticipantCareIdentifier)
class ParticipantCareIdentifierControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.participantCareIdentifierInstanceList
        model.participantCareIdentifierInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.participantCareIdentifierInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        def participantCareIdentifier = new ParticipantCareIdentifier()
        participantCareIdentifier.validate()
        controller.save(participantCareIdentifier)

        then: "The create view is rendered again with the correct model"
        model.participantCareIdentifierInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        participantCareIdentifier = new ParticipantCareIdentifier(params)

        controller.save(participantCareIdentifier)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/participantCareIdentifier/show/1'
        controller.flash.message != null
        ParticipantCareIdentifier.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def participantCareIdentifier = new ParticipantCareIdentifier(params)
        controller.show(participantCareIdentifier)

        then: "A model is populated containing the domain instance"
        model.participantCareIdentifierInstance == participantCareIdentifier
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def participantCareIdentifier = new ParticipantCareIdentifier(params)
        controller.edit(participantCareIdentifier)

        then: "A model is populated containing the domain instance"
        model.participantCareIdentifierInstance == participantCareIdentifier
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/participantCareIdentifier/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def participantCareIdentifier = new ParticipantCareIdentifier()
        participantCareIdentifier.validate()
        controller.update(participantCareIdentifier)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.participantCareIdentifierInstance == participantCareIdentifier

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        participantCareIdentifier = new ParticipantCareIdentifier(params).save(flush: true)
        controller.update(participantCareIdentifier)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/participantCareIdentifier/show/$participantCareIdentifier.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/participantCareIdentifier/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def participantCareIdentifier = new ParticipantCareIdentifier(params).save(flush: true)

        then: "It exists"
        ParticipantCareIdentifier.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(participantCareIdentifier)

        then: "The instance is deleted"
        ParticipantCareIdentifier.count() == 0
        response.redirectedUrl == '/participantCareIdentifier/index'
        flash.message != null
    }
}
