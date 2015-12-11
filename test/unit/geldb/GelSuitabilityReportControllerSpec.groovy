package geldb


import grails.test.mixin.*
import spock.lang.*

@TestFor(GelSuitabilityReportController)
@Mock([GelSuitabilityReport, Aliquot, FluidSpecimen, Participant, Centre, Location, Units, AliquotType, StaffMember])
class GelSuitabilityReportControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        def centre = new Centre(centreName: 'oxford').save()
        def participant = new Participant(hospitalNumber: '1234', centre: centre).save()
        def collectionLocation = new Location(locationName: '1', locationDescription: '2').save()
        def volumeUnit = new Units(unitName: 'ml', unitDescription: 'milli', unitType: 'VolumeUnit').save()
        def specimen = new FluidSpecimen(participant: participant, exhausted: false, passFail: true, collectionDate: new Date(),
                collectionLocation: collectionLocation, fluidSampleType: "Blood_whole_BLD", fluidSpecimenVolume: 1, volumeUnit: volumeUnit).save()
        def aliquotType = new AliquotType(aliquotTypeName: 'test').save()
        params["aliquot"] = new Aliquot(specimen: specimen, exhausted: false, passFail: true, aliquotType: aliquotType).save()
        params["reportDate"] = new Date()
        params["reportStaff"] = new StaffMember(staffName: '12', centre: centre, staffRole: 'Anaesthetist').save()
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.gelSuitabilityReportInstanceList
        model.gelSuitabilityReportInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.gelSuitabilityReportInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        def gelSuitabilityReport = new GelSuitabilityReport()
        gelSuitabilityReport.validate()
        controller.save(gelSuitabilityReport)

        then: "The create view is rendered again with the correct model"
        model.gelSuitabilityReportInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        gelSuitabilityReport = new GelSuitabilityReport(params)
        controller.request.method = "POST"
        request.format = 'form'
        controller.save(gelSuitabilityReport)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/aliquot/show/2'
        controller.flash.message != null
        GelSuitabilityReport.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def gelSuitabilityReport = new GelSuitabilityReport(params)
        controller.show(gelSuitabilityReport)

        then: "A model is populated containing the domain instance"
        model.gelSuitabilityReportInstance == gelSuitabilityReport
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def gelSuitabilityReport = new GelSuitabilityReport(params)
        controller.edit(gelSuitabilityReport)

        then: "A model is populated containing the domain instance"
        model.gelSuitabilityReportInstance == gelSuitabilityReport
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        controller.request.method = "POST"
        request.format = 'form'
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/gelSuitabilityReport/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def gelSuitabilityReport = new GelSuitabilityReport()
        gelSuitabilityReport.validate()
        controller.update(gelSuitabilityReport)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.gelSuitabilityReportInstance == gelSuitabilityReport

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        gelSuitabilityReport = new GelSuitabilityReport(params).save(flush: true)
        controller.request.method = "POST"
        request.format = 'form'
        controller.update(gelSuitabilityReport)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/gelSuitabilityReport/show/$gelSuitabilityReport.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        controller.request.method = "POST"
        request.format = 'form'
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/gelSuitabilityReport/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def gelSuitabilityReport = new GelSuitabilityReport(params).save(flush: true)

        then: "It exists"
        GelSuitabilityReport.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.request.method = "POST"
        request.format = 'form'
        controller.delete(gelSuitabilityReport)

        then: "The instance is deleted"
        GelSuitabilityReport.count() == 0
        response.redirectedUrl == '/gelSuitabilityReport/index'
        flash.message != null
    }
}
