package geldb



import grails.test.mixin.*
import spock.lang.*

@TestFor(DNA_ExtractController)
@Mock([DNA_Extract, Aliquot, FluidSpecimen, Participant, Centre, Location, Units, AliquotType, StaffMember, ExtractionType, DNAExtractionKit])
class DNA_ExtractControllerSpec extends Specification {

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
        params["exhausted"] = false
        params["passFail"] = true
        params["dNAConcentrationNanodrop"] = '1'
        params["dNAConcentrationQubit"] = '1'
        params["extractionDate"] = new Date()
        params["dNAAmount"] = '1'
        params["a260A280"] = '1'
        params["a260A230"] = '1'
        params["experimentName"] = 'experimentName'
        params["extractionKit"] = new DNAExtractionKit(extractionKitName: '12').save()
        params["extractionType"] = new ExtractionType(extractionTypeName: '12').save()
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.DNA_ExtractInstanceList
            model.DNA_ExtractInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.DNA_ExtractInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def DNA_Extract = new DNA_Extract()
            DNA_Extract.validate()
            controller.save(DNA_Extract)

        then:"The create view is rendered again with the correct model"
            model.DNA_ExtractInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            DNA_Extract = new DNA_Extract(params)
            controller.request.method = "POST"
            request.format = 'form'
            controller.save(DNA_Extract)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/DNA_Extract/show/3'
            controller.flash.message != null
            DNA_Extract.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def DNA_Extract = new DNA_Extract(params)
            controller.show(DNA_Extract)

        then:"A model is populated containing the domain instance"
            model.DNA_ExtractInstance == DNA_Extract
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def DNA_Extract = new DNA_Extract(params)
            controller.edit(DNA_Extract)

        then:"A model is populated containing the domain instance"
            model.DNA_ExtractInstance == DNA_Extract
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.request.method = "POST"
            request.format = 'form'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/DNA_Extract/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def DNA_Extract = new DNA_Extract()
            DNA_Extract.validate()
            controller.update(DNA_Extract)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.DNA_ExtractInstance == DNA_Extract

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            DNA_Extract = new DNA_Extract(params).save(flush: true)
            controller.request.method = "POST"
            request.format = 'form'
            controller.update(DNA_Extract)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/DNA_Extract/show/$DNA_Extract.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/DNA_Extract/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def DNA_Extract = new DNA_Extract(params).save(flush: true)

        then:"It exists"
            DNA_Extract.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(DNA_Extract)

        then:"The instance is deleted"
            DNA_Extract.count() == 0
            response.redirectedUrl == '/DNA_Extract/index'
            flash.message != null
    }
}
