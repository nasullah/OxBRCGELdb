package geldb


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugins.springsecurity.*
/**
 * StudySubjectController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class StudySubjectController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StudySubject.list(params), model: [studySubjectInstanceCount: StudySubject.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StudySubject.list(params), model: [studySubjectInstanceCount: StudySubject.count()]
    }

    def show(StudySubject studySubjectInstance) {
        respond studySubjectInstance
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def create() {
        respond new StudySubject(params)
    }

    def filterConsentVersionForm() {

        def consentType = Study.get(params.long('study'))
        if (consentType){
            if (consentType.studyName == 'GeL') {
                def listConsentVersionForm = ["Version 1.0 dated 25.08.2014", "Version 2 dated 14.10.14", "Version 2 dated 14.10.2014"]
                render(template: "formVersions", model: [listConsentVersionForm: listConsentVersionForm])
            } else if (consentType.studyName == 'ORB') {
                def listConsentVersionForm = ["Version/date: 02/04/2014"]
                render(template: "formVersions", model: [listConsentVersionForm: listConsentVersionForm])
            } else if (consentType.studyName == 'NHS') {
                def listConsentVersionForm = ["1-RTH0029-0503", "1-RBF0071-0708", "1-0308", "1-0611", "1-0413", "2-RTH0030-0503",
                                              "2-RBF0072-0611", "2-0308", "3-RTH0031-0503", "3-308", "3-0611", "4-0308", "Cell Path Form"]
                render(template: "formVersions", model: [listConsentVersionForm: listConsentVersionForm])
            } else if (consentType.studyName == 'ProMPT') {
                def listConsentVersionForm = ["6/ 04/09/2012"]
                render(template: "formVersions", model: [listConsentVersionForm: listConsentVersionForm])
            } else if (consentType.studyName == 'GoTarget') {
                def listConsentVersionForm = ["Version 2.0 April 2010"]
                render(template: "formVersions", model: [listConsentVersionForm: listConsentVersionForm])
            }else if (consentType.studyName == '100K Genomes Main Project') {
                def listConsentVersionForm = ["Version 2.0 dated 20.01.2015", "Version 2.1 dated 24.09.2015", "Version 2.2 dated 01.07.2016"]
                render(template: "formVersions", model: [listConsentVersionForm: listConsentVersionForm])
            }else if (consentType.studyName == 'HICF2') {
                def listConsentVersionForm = ["HICF2"]
                render(template: "formVersions", model: [listConsentVersionForm: listConsentVersionForm])
            }else if (consentType.studyName == 'ORB paediatrics') {
                def listConsentVersionForm = ["Version/date: 2/April 2014"]
                render(template: "formVersions", model: [listConsentVersionForm: listConsentVersionForm])
            }else if (consentType.studyName == 'GI consent') {
                def listConsentVersionForm = ["11/YH/0020", "16/YH/0247"]
                render(template: "formVersions", model: [listConsentVersionForm: listConsentVersionForm])
            }
        }
    }

    @Transactional
    def save(StudySubject studySubjectInstance) {
        if (studySubjectInstance == null) {
            notFound()
            return
        }

        if (studySubjectInstance.hasErrors()) {
            respond studySubjectInstance.errors, view: 'create'
            return
        }

        studySubjectInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'studySubjectInstance.label', default: 'StudySubject'), studySubjectInstance.id])
                //redirect studySubjectInstance
                redirect(controller:'participant',action: 'show', params: [id:studySubjectInstance.participant.id])
            }
            '*' { respond studySubjectInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def edit(StudySubject studySubjectInstance) {
        respond studySubjectInstance
    }

    @Transactional
    def update(StudySubject studySubjectInstance) {
        if (studySubjectInstance == null) {
            notFound()
            return
        }

        if (studySubjectInstance.hasErrors()) {
            respond studySubjectInstance.errors, view: 'edit'
            return
        }

        studySubjectInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'StudySubject.label', default: 'StudySubject'), studySubjectInstance.id])
//                redirect studySubjectInstance
                redirect(controller:'participant',action: 'show', params: [id:studySubjectInstance.participant.id])
            }
            '*' { respond studySubjectInstance, [status: OK] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    @Transactional
    def delete(StudySubject studySubjectInstance) {

        if (studySubjectInstance == null) {
            notFound()
            return
        }

        studySubjectInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'StudySubject.label', default: 'StudySubject'), studySubjectInstance.id])
                redirect(controller:'participant',action: 'show', params: [id:studySubjectInstance.participant.id])
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'studySubjectInstance.label', default: 'StudySubject'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
