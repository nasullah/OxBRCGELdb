package geldb



import grails.test.mixin.*
import spock.lang.*

@TestFor(ParticipantController)
@Mock([Participant, ICD10, Centre])
class ParticipantControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        params["familyName"] = 'familyName'
        params["givenName"] = 'givenName'
        params["dateOfBirth"] = new Date()
        params["gender"] = 'Male'
        params["nHSNumber"] = '1234567890'
        params["hospitalNumber"] = '12345'
        params["diagnosis"] = new ICD10(code: 'I', meaning: 'something').save()
        params["centre"] = new Centre(centreName: 'oxford').save()
        params["solidSpecimenExpected"] = true
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.participantInstanceList
            model.participantInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.participantInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def participant = new Participant()
            participant.validate()
            controller.save(participant)

        then:"The create view is rendered again with the correct model"
            model.participantInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            participant = new Participant(params)
            controller.request.method = "POST"
            request.format = 'form'
            controller.save(participant)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/participant/show/1'
            controller.flash.message != null
            Participant.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def participant = new Participant(params)
            controller.show(participant)

        then:"A model is populated containing the domain instance"
            model.participantInstance == participant
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.request.method = "POST"
            request.format = 'form'
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def participant = new Participant(params)
            controller.edit(participant)

        then:"A model is populated containing the domain instance"
            model.participantInstance == participant
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.request.method = "POST"
            request.format = 'form'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/participant/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def participant = new Participant()
            participant.validate()
            controller.update(participant)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.participantInstance == participant

        when:"A valid domain instance is passed to the update action"
            controller.request.method = "POST"
            request.format = 'form'
            response.reset()
            populateValidParams(params)
            participant = new Participant(params).save(flush: true)
            controller.update(participant)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/participant/show/$participant.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/participant/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def participant = new Participant(params).save(flush: true)

        then:"It exists"
            Participant.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(participant)

        then:"The instance is deleted"
            Participant.count() == 0
            response.redirectedUrl == '/participant/index'
            flash.message != null
    }
}
