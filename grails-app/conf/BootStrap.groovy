import GELBootsDB.Role
import GELBootsDB.User
import GELBootsDB.UserRole
import org.springframework.jca.cci.CciOperationNotSupportedException
import org.springframework.web.context.support.WebApplicationContextUtils

class BootStrap {

    def init = { servletContext ->



//        def eventOwnerRole = new Role(authority: 'ROLE_EVENT_OWNER').save(flush: true)
//        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)
//
//        def testUser = new User(username: 'me', enabled: true, password: 'password')
//        testUser.save(flush: true)
//
//        UserRole.create testUser, userRole, true
//
//        assert User.count() == 1
//        assert Role.count() == 2
//        assert UserRole.count() == 1


//        def springContext = WebApplicationContextUtils.getWebApplicationContext(servletContext)
//        springContext.getBean( "customObjectMarshallers" ).register()

        environments {
            test {
                createRoles()
                createAdminUser("admin", "password", "support@example.com")
            }
            development {
                createRoles()
                createAdminUser("admin", "password", "support@example.com")
            }

            production {
                createRoles()
                createAdminUser("admin", "password", "support@example.com")
            }
        }
    }

    def destroy = {
    }
    def createRoles(){
        Role.findByAuthority('ROLE_ADMIN') ?: new Role(authority: 'ROLE_ADMIN').save(failOnError: true)
        Role.findByAuthority('ROLE_USER') ?: new Role(authority: 'ROLE_USER').save(failOnError: true)
        Role.findByAuthority('ROLE_CAN_SEE_DEMOGRAPHICS') ?: new Role(authority: 'ROLE_CAN_SEE_DEMOGRAPHICS').save(failOnError: true)
    }

    def createAdminUser(String username, String password, String email){
        if(!User.findByUsername(username) ){
            def user = new User(username: username, enabled: true, emailAddress: email, password: password).save(failOnError: true)
            UserRole.create user, Role.findByAuthority('ROLE_ADMIN')
        }
    }
}