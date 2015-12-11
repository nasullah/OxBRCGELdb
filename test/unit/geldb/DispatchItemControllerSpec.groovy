package geldb


import grails.test.mixin.*
import spock.lang.*

@TestFor(DispatchItemController)
@Mock([DispatchItem, DispatchedBox, DispatchRecord, Destination, IdentifiedSample, Aliquot, FluidSpecimen, Participant, Centre, Location, Units, AliquotType, DNA_Extract])
class DispatchItemControllerSpec extends Specification {

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
        def aliquot = new Aliquot(specimen: specimen, exhausted: false, passFail: true, aliquotType: aliquotType).save()
        def destination = new Destination(companyName: 'a', companyAddress: 'b', companyCountry: 'uk', companyPostalCode: 'ox1').save()
        def dispatchRecord = new DispatchRecord(destination: destination, sentOn: new Date(), receivedOn: new Date(), fAO: 'a', consignmentNumber: '12',
                companyName: 'a', companyAddress: 'b', companyCountry: 'uk', companyPostalCode: 'ox1').save()
        params["dispatchedBox"] = new DispatchedBox(barcode: '12', dispatchRecord: dispatchRecord).save()
        params["positionIfPlated"] = 'positionIfPlated'
        params["volume_ul"] = '1'
        params["identifiedSample"] = aliquot
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.dispatchItemInstanceList
        model.dispatchItemInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.dispatchItemInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        def dispatchItem = new DispatchItem()
        dispatchItem.validate()
        controller.save(dispatchItem)

        then: "The create view is rendered again with the correct model"
        model.dispatchItemInstance == null
        view != 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        dispatchItem = new DispatchItem(params)
        controller.request.method = "POST"
        request.format = 'form'
        controller.save(dispatchItem)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/dispatchedBox/show/1'
        controller.flash.message != null
        DispatchItem.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def dispatchItem = new DispatchItem(params)
        controller.show(dispatchItem)

        then: "A model is populated containing the domain instance"
        model.dispatchItemInstance == dispatchItem
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def dispatchItem = new DispatchItem(params)
        controller.edit(dispatchItem)

        then: "A model is populated containing the domain instance"
        model.dispatchItemInstance == dispatchItem
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        controller.request.method = "POST"
        request.format = 'form'
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/dispatchItem/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def dispatchItem = new DispatchItem()
        dispatchItem.validate()
        controller.update(dispatchItem)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.dispatchItemInstance == dispatchItem

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        dispatchItem = new DispatchItem(params).save(flush: true)
        controller.request.method = "POST"
        request.format = 'form'
        controller.update(dispatchItem)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/dispatchItem/show/$dispatchItem.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        controller.request.method = "POST"
        request.format = 'form'
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/dispatchItem/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def dispatchItem = new DispatchItem(params).save(flush: true)

        then: "It exists"
        DispatchItem.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.request.method = "POST"
        request.format = 'form'
        controller.delete(dispatchItem)

        then: "The instance is deleted"
        DispatchItem.count() == 0
        response.redirectedUrl == '/dispatchItem/index'
        flash.message != null
    }
}
