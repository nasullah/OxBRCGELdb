package geldb



import grails.test.mixin.*
import spock.lang.*

@TestFor(SolidSpecimenController)
@Mock([SolidSpecimen, Participant, Centre, Location, Units, CollectionMethod])
class SolidSpecimenControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        def centre = new Centre(centreName: 'oxford').save()
        def participant = new Participant(hospitalNumber: '1234', centre: centre).save()
        params["collectionMethod"] = new CollectionMethod(collectionMethodName: 'test', collectionMethodDesc: 'test').save()
        params["participant"] = participant
        params["histologyNumber"] = '12345'
        params["exhausted"] = false
        params["passFail"] = true
        params["collectionDate"] = new Date()
        params["collectionLocation"] = new Location(locationName: '1', locationDescription: '2').save()
        params["specimenWeight"] = '1'
        params["massUnit"] = new Units(unitName: 'g', unitDescription: 'gram', unitType: 'MassUnit').save()
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.solidSpecimenInstanceList
            model.solidSpecimenInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.solidSpecimenInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def solidSpecimen = new SolidSpecimen()
            solidSpecimen.validate()
            controller.save(solidSpecimen)

        then:"The create view is rendered again with the correct model"
            model.solidSpecimenInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            solidSpecimen = new SolidSpecimen(params)
            controller.request.method = "POST"
            request.format = 'form'
            controller.save(solidSpecimen)

        then:"A redirect is issued to the show action"
//            response.redirectedUrl == '/solidSpecimen/show/1'
            controller.flash.message != null
            SolidSpecimen.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def solidSpecimen = new SolidSpecimen(params)
            controller.show(solidSpecimen)

        then:"A model is populated containing the domain instance"
            model.solidSpecimenInstance == solidSpecimen
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def solidSpecimen = new SolidSpecimen(params)
            controller.edit(solidSpecimen)

        then:"A model is populated containing the domain instance"
            model.solidSpecimenInstance == solidSpecimen
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.request.method = "POST"
            request.format = 'form'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/solidSpecimen/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def solidSpecimen = new SolidSpecimen()
            solidSpecimen.validate()
            controller.update(solidSpecimen)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.solidSpecimenInstance == solidSpecimen

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            solidSpecimen = new SolidSpecimen(params).save(flush: true)
            controller.request.method = "POST"
            request.format = 'form'
            controller.update(solidSpecimen)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/solidSpecimen/show/$solidSpecimen.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/solidSpecimen/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def solidSpecimen = new SolidSpecimen(params).save(flush: true)

        then:"It exists"
            SolidSpecimen.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(solidSpecimen)

        then:"The instance is deleted"
            SolidSpecimen.count() == 0
            response.redirectedUrl == '/solidSpecimen/index'
            flash.message != null
    }
}
