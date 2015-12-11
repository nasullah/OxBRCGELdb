package geldb



import grails.test.mixin.*
import spock.lang.*

@TestFor(FFPE_Tissue_ReportController)
@Mock([FFPE_Tissue_Report, SolidSpecimen, Participant, Centre, Location, Units, CollectionMethod, SampleType, TumourType, TumourLocation, StaffMember, Snomed])
class FFPE_Tissue_ReportControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        def centre = new Centre(centreName: 'oxford').save()
        def participant = new Participant(hospitalNumber: '1234', centre: centre).save()
        def collectionMethod = new CollectionMethod(collectionMethodName: 'test', collectionMethodDesc: 'test').save()
        def tumourLocation = new TumourLocation(tumourLocation: 'other').save()
        params["solidSpecimen"] = new SolidSpecimen(participant: participant, collectionMethod: collectionMethod, histologyNumber: 'histologyNumber', collectionDate: new Date()).save()
        params["sampleType"] = new SampleType(sampleTypeName: 'sampleTypeName', sampleTypeDesc: 'sampleTypeDesc').save()
        params["tumourStatus"] = 'Primary'
        params["tumourType"] = new TumourType(tumourLocation: tumourLocation, tumourType: 'tumourType').save()
        params["reportDate"] = new Date()
        params["reportStaff"] = new StaffMember(staffName: '12', centre: centre, staffRole: 'Anaesthetist').save()
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.FFPE_Tissue_ReportInstanceList
            model.FFPE_Tissue_ReportInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.FFPE_Tissue_ReportInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def FFPE_Tissue_Report = new FFPE_Tissue_Report()
            FFPE_Tissue_Report.validate()
            controller.save(FFPE_Tissue_Report)

        then:"The create view is rendered again with the correct model"
            model.FFPE_Tissue_ReportInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            FFPE_Tissue_Report = new FFPE_Tissue_Report(params)
            controller.request.method = "POST"
            request.format = 'form'
            controller.save(FFPE_Tissue_Report)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/solidSpecimen/show/1'
            controller.flash.message != null
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def FFPE_Tissue_Report = new FFPE_Tissue_Report(params)
            controller.show(FFPE_Tissue_Report)

        then:"A model is populated containing the domain instance"
            model.FFPE_Tissue_ReportInstance == FFPE_Tissue_Report
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def FFPE_Tissue_Report = new FFPE_Tissue_Report(params)
            controller.edit(FFPE_Tissue_Report)

        then:"A model is populated containing the domain instance"
            model.FFPE_Tissue_ReportInstance == FFPE_Tissue_Report
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.request.method = "POST"
            request.format = 'form'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/FFPE_Tissue_Report/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def FFPE_Tissue_Report = new FFPE_Tissue_Report()
            FFPE_Tissue_Report.validate()
            controller.update(FFPE_Tissue_Report)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.FFPE_Tissue_ReportInstance == FFPE_Tissue_Report

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            FFPE_Tissue_Report = new FFPE_Tissue_Report(params).save(flush: true)
            controller.request.method = "POST"
            request.format = 'form'
            controller.update(FFPE_Tissue_Report)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/FFPE_Tissue_Report/show/$FFPE_Tissue_Report.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/FFPE_Tissue_Report/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def FFPE_Tissue_Report = new FFPE_Tissue_Report(params).save(flush: true)

        then:"It exists"
            FFPE_Tissue_Report.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(FFPE_Tissue_Report)

        then:"The instance is deleted"
            FFPE_Tissue_Report.count() == 0
            response.redirectedUrl == '/FFPE_Tissue_Report/index'
            flash.message != null
    }
}
