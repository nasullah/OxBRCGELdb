package geldb


import grails.test.mixin.*
import spock.lang.*

//@TestFor(StaffRoleController)
//@Mock(StaffRole)
class StaffRoleControllerSpec extends Specification {

//    def populateValidParams(params) {
//        assert params != null
//        // TODO: Populate valid properties like...
//        //params["name"] = 'someValidName'
//    }
//
//    void "Test the index action returns the correct model"() {
//
//        when: "The index action is executed"
//        controller.index()
//
//        then: "The model is correct"
//        !model.staffRoleInstanceList
//        model.staffRoleInstanceCount == 0
//    }
//
//    void "Test the create action returns the correct model"() {
//        when: "The create action is executed"
//        controller.create()
//
//        then: "The model is correctly created"
//        model.staffRoleInstance != null
//    }
//
//    void "Test the save action correctly persists an instance"() {
//
//        when: "The save action is executed with an invalid instance"
//        def staffRole = new StaffRole()
//        staffRole.validate()
//        controller.save(staffRole)
//
//        then: "The create view is rendered again with the correct model"
//        model.staffRoleInstance != null
//        view == 'create'
//
//        when: "The save action is executed with a valid instance"
//        response.reset()
//        populateValidParams(params)
//        staffRole = new StaffRole(params)
//
//        controller.save(staffRole)
//
//        then: "A redirect is issued to the show action"
//        response.redirectedUrl == '/staffRole/show/1'
//        controller.flash.message != null
//        StaffRole.count() == 1
//    }
//
//    void "Test that the show action returns the correct model"() {
//        when: "The show action is executed with a null domain"
//        controller.show(null)
//
//        then: "A 404 error is returned"
//        response.status == 404
//
//        when: "A domain instance is passed to the show action"
//        populateValidParams(params)
//        def staffRole = new StaffRole(params)
//        controller.show(staffRole)
//
//        then: "A model is populated containing the domain instance"
//        model.staffRoleInstance == staffRole
//    }
//
//    void "Test that the edit action returns the correct model"() {
//        when: "The edit action is executed with a null domain"
//        controller.edit(null)
//
//        then: "A 404 error is returned"
//        response.status == 404
//
//        when: "A domain instance is passed to the edit action"
//        populateValidParams(params)
//        def staffRole = new StaffRole(params)
//        controller.edit(staffRole)
//
//        then: "A model is populated containing the domain instance"
//        model.staffRoleInstance == staffRole
//    }
//
//    void "Test the update action performs an update on a valid domain instance"() {
//        when: "Update is called for a domain instance that doesn't exist"
//        controller.update(null)
//
//        then: "A 404 error is returned"
//        response.redirectedUrl == '/staffRole/index'
//        flash.message != null
//
//
//        when: "An invalid domain instance is passed to the update action"
//        response.reset()
//        def staffRole = new StaffRole()
//        staffRole.validate()
//        controller.update(staffRole)
//
//        then: "The edit view is rendered again with the invalid instance"
//        view == 'edit'
//        model.staffRoleInstance == staffRole
//
//        when: "A valid domain instance is passed to the update action"
//        response.reset()
//        populateValidParams(params)
//        staffRole = new StaffRole(params).save(flush: true)
//        controller.update(staffRole)
//
//        then: "A redirect is issues to the show action"
//        response.redirectedUrl == "/staffRole/show/$staffRole.id"
//        flash.message != null
//    }
//
//    void "Test that the delete action deletes an instance if it exists"() {
//        when: "The delete action is called for a null instance"
//        controller.delete(null)
//
//        then: "A 404 is returned"
//        response.redirectedUrl == '/staffRole/index'
//        flash.message != null
//
//        when: "A domain instance is created"
//        response.reset()
//        populateValidParams(params)
//        def staffRole = new StaffRole(params).save(flush: true)
//
//        then: "It exists"
//        StaffRole.count() == 1
//
//        when: "The domain instance is passed to the delete action"
//        controller.delete(staffRole)
//
//        then: "The instance is deleted"
//        StaffRole.count() == 0
//        response.redirectedUrl == '/staffRole/index'
//        flash.message != null
//    }
}
