package geldb



import grails.test.mixin.*
import spock.lang.*

@TestFor(StudySubjectController)
@Mock([StudySubject, Study, Participant, Centre])
class StudySubjectControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        def centre = new Centre(centreName: 'oxford').save()
        params["participant"] = new Participant(hospitalNumber: '1234', centre: centre).save()
        params["study"] = new Study(studyName: 'gel').save()
        params["studySubjectIdentifier"] = '123456'
        params["consentFormNumber"] = '1234'
        params["consentStatus"] = true
        params["recruitmentDate"] = new Date()
        params["recruitedBy"] = 'recruitedBy'
        params["consentFormVersion"] = "Version 2.1 dated 24.09.2015"
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.studySubjectInstanceList
            model.studySubjectInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.studySubjectInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def studySubject = new StudySubject()
            studySubject.validate()
            controller.save(studySubject)

        then:"The create view is rendered again with the correct model"
            model.studySubjectInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            studySubject = new StudySubject(params)
            controller.request.method = "POST"
            request.format = 'form'
            controller.save(studySubject)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/participant/show/1'
            controller.flash.message != null
            StudySubject.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def studySubject = new StudySubject(params)
            controller.show(studySubject)

        then:"A model is populated containing the domain instance"
            model.studySubjectInstance == studySubject
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def studySubject = new StudySubject(params)
            controller.edit(studySubject)

        then:"A model is populated containing the domain instance"
            model.studySubjectInstance == studySubject
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.request.method = "POST"
            request.format = 'form'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/studySubject/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def studySubject = new StudySubject()
            studySubject.validate()
            controller.update(studySubject)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.studySubjectInstance == studySubject

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            studySubject = new StudySubject(params).save(flush: true)
            controller.request.method = "POST"
            request.format = 'form'
            controller.update(studySubject)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/participant/show/$studySubject.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/studySubject/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def studySubject = new StudySubject(params).save(flush: true)

        then:"It exists"
            StudySubject.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(studySubject)

        then:"The instance is deleted"
            StudySubject.count() == 0
            response.redirectedUrl == '/studySubject/index'
            flash.message != null
    }
}
