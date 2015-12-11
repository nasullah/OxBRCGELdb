package geldb


import grails.test.mixin.*
import spock.lang.*

@TestFor(SnomedController)
@Mock([FFPE_Tissue_Report, SolidSpecimen, Participant, Centre, Location, Units, CollectionMethod, SampleType, TumourType, TumourLocation, StaffMember, Snomed])
class SnomedControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        def centre = new Centre(centreName: 'oxford').save()
        def participant = new Participant(hospitalNumber: '1234', centre: centre).save()
        def collectionMethod = new CollectionMethod(collectionMethodName: 'test', collectionMethodDesc: 'test').save()
        def tumourLocation = new TumourLocation(tumourLocation: 'other').save()
        def solidSpecimen = new SolidSpecimen(participant: participant, collectionMethod: collectionMethod, histologyNumber: 'histologyNumber', collectionDate: new Date()).save()
        def sampleType = new SampleType(sampleTypeName: 'sampleTypeName', sampleTypeDesc: 'sampleTypeDesc').save()
        def tumourStatus = 'Primary'
        def tumourType = new TumourType(tumourLocation: tumourLocation, tumourType: 'tumourType').save()
        def reportDate = new Date()
        def reportStaff = new StaffMember(staffName: '12', centre: centre, staffRole: 'Anaesthetist').save()
        params["fFPE_Tissue_Report"] = new FFPE_Tissue_Report(solidSpecimen : solidSpecimen, sampleType: sampleType, tumourStatus: tumourStatus, tumourType: tumourType,
                reportDate: reportDate, reportStaff: reportStaff).save()
        params["snomedCode"] = "snomedCode"
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.snomedInstanceList
        model.snomedInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.snomedInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        def snomed = new Snomed()
        snomed.validate()
        controller.save(snomed)

        then: "The create view is rendered again with the correct model"
        model.snomedInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        snomed = new Snomed(params)
        controller.request.method = "POST"
        request.format = 'form'
        controller.save(snomed)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/snomed/show/1'
        controller.flash.message != null
        Snomed.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def snomed = new Snomed(params)
        controller.show(snomed)

        then: "A model is populated containing the domain instance"
        model.snomedInstance == snomed
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def snomed = new Snomed(params)
        controller.edit(snomed)

        then: "A model is populated containing the domain instance"
        model.snomedInstance == snomed
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        controller.request.method = "POST"
        request.format = 'form'
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/snomed/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def snomed = new Snomed()
        snomed.validate()
        controller.update(snomed)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.snomedInstance == snomed

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        snomed = new Snomed(params).save(flush: true)
        controller.request.method = "POST"
        request.format = 'form'
        controller.update(snomed)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/FFPE_Tissue_Report/show/$snomed.fFPE_Tissue_Report.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        controller.request.method = "POST"
        request.format = 'form'
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/snomed/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def snomed = new Snomed(params).save(flush: true)

        then: "It exists"
        Snomed.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.request.method = "POST"
        request.format = 'form'
        controller.delete(snomed)

        then: "The instance is deleted"
        Snomed.count() == 0
        response.redirectedUrl == '/snomed/index'
        flash.message != null
    }
}
