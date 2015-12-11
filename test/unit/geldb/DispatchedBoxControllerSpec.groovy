package geldb



import grails.test.mixin.*
import spock.lang.*

@TestFor(DispatchedBoxController)
@Mock([DispatchedBox, DispatchRecord, Destination])
class DispatchedBoxControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        def destination = new Destination(companyName: 'a', companyAddress: 'b', companyCountry: 'uk', companyPostalCode: 'ox1').save()
        params["dispatchRecord"] = new DispatchRecord(destination: destination, sentOn: new Date(), receivedOn: new Date(), fAO: 'a', consignmentNumber: '12',
                companyName: 'a', companyAddress: 'b', companyCountry: 'uk', companyPostalCode: 'ox1').save()
        params["barcode"] = 'barcode'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.dispatchedBoxInstanceList
            model.dispatchedBoxInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.dispatchedBoxInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def dispatchedBox = new DispatchedBox()
            dispatchedBox.validate()
            controller.save(dispatchedBox)

        then:"The create view is rendered again with the correct model"
            model.dispatchedBoxInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            dispatchedBox = new DispatchedBox(params)
            controller.request.method = "POST"
            request.format = 'form'
            controller.save(dispatchedBox)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/dispatchedBox/show/1'
            controller.flash.message != null
            DispatchedBox.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def dispatchedBox = new DispatchedBox(params)
            controller.show(dispatchedBox)

        then:"A model is populated containing the domain instance"
            model.dispatchedBoxInstance == dispatchedBox
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def dispatchedBox = new DispatchedBox(params)
            controller.edit(dispatchedBox)

        then:"A model is populated containing the domain instance"
            model.dispatchedBoxInstance == dispatchedBox
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.request.method = "POST"
            request.format = 'form'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/dispatchedBox/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def dispatchedBox = new DispatchedBox()
            dispatchedBox.validate()
            controller.update(dispatchedBox)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.dispatchedBoxInstance == dispatchedBox

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            dispatchedBox = new DispatchedBox(params).save(flush: true)
            controller.request.method = "POST"
            request.format = 'form'
            controller.update(dispatchedBox)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/dispatchedBox/show/$dispatchedBox.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/dispatchedBox/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def dispatchedBox = new DispatchedBox(params).save(flush: true)

        then:"It exists"
            DispatchedBox.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.request.method = "POST"
            request.format = 'form'
            controller.delete(dispatchedBox)

        then:"The instance is deleted"
            DispatchedBox.count() == 0
            response.redirectedUrl == '/dispatchedBox/index'
            flash.message != null
    }
}
