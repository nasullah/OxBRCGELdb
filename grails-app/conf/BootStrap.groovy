import GELBootsDB.Role
import GELBootsDB.User
import GELBootsDB.UserRole

class BootStrap {

    def init = { servletContext ->
        def eventOwnerRole = new Role(authority: 'ROLE_EVENT_OWNER').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

        def testUser = new User(username: 'me', enabled: true, password: 'password')
        testUser.save(flush: true)

        UserRole.create testUser, userRole, true

        assert User.count() == 1
        assert Role.count() == 2
        assert UserRole.count() == 1

    }
    def destroy = {
    }
}
