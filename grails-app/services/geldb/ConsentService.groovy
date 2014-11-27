package geldb

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.web.JSONBuilder
import groovy.json.JsonSlurper
import org.apache.ivy.util.url.BasicURLHandler
import org.springframework.http.HttpMethod
import org.springframework.http.MediaType
import org.springframework.test.web.client.MockRestServiceServer
import org.springframework.test.web.client.match.MockRestRequestMatchers
import org.springframework.test.web.client.response.MockRestResponseCreators

/**
 * ConsentService
 * A service class encapsulates the core business logic of a Grails application
 */
class ConsentService {

    def grailsApplication


    def login() {

        def greenLightUsername = grailsApplication.config.greenlight.apiUsername
        def greenLightPassword = grailsApplication.config.greenlight.apiPassword
        def greenLightUrlAddress = grailsApplication.config.greenlight.urlAddress


        def builder = new JSONBuilder()
        def rest = new RestBuilder()
        JSON requestJson = builder.build {
            username = greenLightUsername
            password = greenLightPassword
        }
        def response
        try {
            response = rest.post("${greenLightUrlAddress}/api/login") {
                body requestJson
            }
        }
        catch (Exception ex) {
            log.error(ex)
            return null
        }


        def jsonSlurper = new JsonSlurper()
        def responseObject
        if (response && response?.responseEntity?.statusCode ==  org.springframework.http.HttpStatus.OK) {
            responseObject =  jsonSlurper.parseText(response.body)
            return responseObject?.access_token
        }
        return null
    }

    def getConsent(nhsNumber) {
        def token = login()
        if(!token){
            return [erros:true,errorMessage:"Can not login to Greenlight"]
        }
        def consent = apiConsnetStatus(token, nhsNumber)
        if(consent){
            logout(token)
            return [errors: false, consent:consent]
        }
        return [erros:true,errorMessage:"Can not retrieve Consent from Greenlight"]
    }

    def logout(token) {
        def greenLightUrlAddress = grailsApplication.config.greenlight.urlAddress

        def rest = new RestBuilder()
        def response

        try {
            response = rest.post("${greenLightUrlAddress}/api/logout") {
                auth "Bearer ${token}"
            }
        }
        catch (Exception ex) {
            log.error(ex)
            return null
        }

        if (response && response?.responseEntity?.statusCode ==  org.springframework.http.HttpStatus.OK) {
            return response
        }
    }

    def apiConsnetStatus(token, nhsNumber) {
        def greenLightUrlAddress = grailsApplication.config.greenlight.urlAddress
        def rest = new RestBuilder()
        def response

        try {

            response =
                    rest.post("${greenLightUrlAddress}/api/consents/${nhsNumber}.json") {
                        auth "Bearer ${token}"
                    }
        } catch (Exception ex) {
            log.error(ex)
            return null
        }

        //process the response
        def jsonSlurper = new JsonSlurper()
        if (response && response?.responseEntity?.statusCode ==  org.springframework.http.HttpStatus.OK) {
           return jsonSlurper.parseText(response?.body)
        }
        return null
    }
}
