package geldb


import grails.test.mixin.*
import spock.lang.*

@TestFor(DispatchRecordController)
@Mock([DispatchRecord, Destination])
class DispatchRecordControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
        def destination = new Destination(companyName: 'a', companyAddress: 'b', companyCountry: 'uk', companyPostalCode: 'ox1').save()
        params["destination"] = destination
        params["sentOn"] = new Date()
        params["receivedOn"] = new Date()
        params["fAO"] = 'fAO'
        params["consignmentNumber"] = 'consignmentNumber'
        params["companyName"] = 'companyName'
        params["companyAddress"] = 'companyAddress'
        params["companyCountry"] = 'companyCountry'
        params["companyPostalCode"] = 'companyPostalCode'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.dispatchRecordInstanceList
        model.dispatchRecordInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.dispatchRecordInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        def dispatchRecord = new DispatchRecord()
        dispatchRecord.validate()
        controller.save(dispatchRecord)

        then: "The create view is rendered again with the correct model"
        model.dispatchRecordInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        dispatchRecord = new DispatchRecord(params)
        controller.request.method = "POST"
        request.format = 'form'
        controller.save(dispatchRecord)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/dispatchRecord/show/1'
        controller.flash.message != null
        DispatchRecord.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def dispatchRecord = new DispatchRecord(params)
        controller.show(dispatchRecord)

        then: "A model is populated containing the domain instance"
        model.dispatchRecordInstance == dispatchRecord
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def dispatchRecord = new DispatchRecord(params)
        controller.edit(dispatchRecord)

        then: "A model is populated containing the domain instance"
        model.dispatchRecordInstance == dispatchRecord
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        controller.request.method = "POST"
        request.format = 'form'
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/dispatchRecord/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def dispatchRecord = new DispatchRecord()
        dispatchRecord.validate()
        controller.update(dispatchRecord)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.dispatchRecordInstance == dispatchRecord

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        dispatchRecord = new DispatchRecord(params).save(flush: true)
        controller.request.method = "POST"
        request.format = 'form'
        controller.update(dispatchRecord)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/dispatchRecord/show/$dispatchRecord.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        controller.request.method = "POST"
        request.format = 'form'
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/dispatchRecord/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def dispatchRecord = new DispatchRecord(params).save(flush: true)

        then: "It exists"
        DispatchRecord.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.request.method = "POST"
        request.format = 'form'
        controller.delete(dispatchRecord)

        then: "The instance is deleted"
        DispatchRecord.count() == 0
        response.redirectedUrl == '/dispatchRecord/index'
        flash.message != null
    }
}
