<%@ page import="geldb.Participant" %>
<%@ page import="geldb.StudySubject" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'participant.label', default: 'Participant')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
    <resource:autoComplete/>
</head>

<body>

<section id="create-participant" class="first">

    <g:hasErrors bean="${participantInstance}">
        <div class="alert alert-danger">
            <g:renderErrors bean="${participantInstance}" as="list" />
        </div>
    </g:hasErrors>

    <g:form action="saveFromBarcode" class="form-horizontal" role="form" >

        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: participantInstance, field: 'familyName', 'error')} ">
                    <label for="familyName" class="control-label"><g:message code="participant.familyName.label" default="Family Name" /></label>
                    <div>
                        <g:textField class="form-control" name="familyName" value="${participantInstance?.familyName}" />
                        <span class="help-inline">${hasErrors(bean: participantInstance, field: 'familyName', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: participantInstance, field: 'givenName', 'error')} ">
                    <label for="givenName" class="control-label"><g:message code="participant.givenName.label" default="Given Name" /></label>
                    <div>
                        <g:textField class="form-control" name="givenName" value="${participantInstance?.givenName}" />
                        <span class="help-inline">${hasErrors(bean: participantInstance, field: 'givenName', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: participantInstance, field: 'dateOfBirth', 'error')} ">
                    <label for="dateOfBirth" class="control-label"><g:message code="participant.dateOfBirth.label" default="Date Of Birth" /></label>
                    <div>
                        <bs:datePicker name="dateOfBirth" precision="day"   value="${participantInstance?.dateOfBirth}" default="none"  />
                        <span class="help-inline">${hasErrors(bean: participantInstance, field: 'dateOfBirth', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: participantInstance, field: 'gender', 'error')} ">
                    <label for="gender" class="control-label"><g:message code="participant.gender.label" default="Gender" /></label>
                    <div>
                        <g:select class="form-control" name="gender" from="${participantInstance?.constraints?.gender?.inList}" value="${participantInstance?.gender}" valueMessagePrefix="participant.gender"  noSelection="['':'- Choose gender -']"/>
                        <span class="help-inline">${hasErrors(bean: participantInstance, field: 'gender', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: participantInstance, field: 'nHSNumber', 'error')} ">
                    <label for="nHSNumber" class="control-label"><g:message code="participant.nHSNumber.label" default="NHS Number" /></label>
                    <div>
                        <g:textField class="form-control" name="nHSNumber" value="${participantInstance?.nHSNumber}" />
                        <span class="help-inline">${hasErrors(bean: participantInstance, field: 'nHSNumber', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: participantInstance, field: 'hospitalNumber', 'error')} ">
                    <label for="hospitalNumber" class="control-label"><g:message code="participant.hospitalNumber.label" default="Hospital Number" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:textField class="form-control" name="hospitalNumber" value="${participantInstance?.hospitalNumber}" required=""/>
                        <span class="help-inline">${hasErrors(bean: participantInstance, field: 'hospitalNumber', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: participantInstance, field: 'centre', 'error')} required">
                    <label for="centre" class="control-label"><g:message code="participant.centre.label" default="Centre" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" id="centre" name="centre.id" from="${geldb.Centre.list().sort()}" optionKey="id" required="" value="${participantInstance?.centre?.id}" />
                        <span class="help-inline">${hasErrors(bean: participantInstance, field: 'centre', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <label for="diagnosis" class="control-label"><g:message code="participant.diagnosis.label" default="Diagnosis (Enter diagnosis keywords or ICD10 code)" /></label>
                <richui:autoComplete class="form-control" name="personName" action="${createLinkTo('dir': 'participant/searchICD10')}" value="${participantInstance?.diagnosis}" onItemSelect="callICD10(id)" maxResultsDisplayed="20" minQueryLength="2" />
                <g:hiddenField id ="diagnosis" name ="diagnosis" value=""/>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: studySubjectInstance, field: 'study', 'error')} required">
                    <label for="study" class="control-label"><g:message code="studySubject.study.label" default="Consent Type" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" id="study" name="study.id" from="${geldb.Study.list()}" optionKey="id" required="" value="${study?.id}" onchange="filterVersion()"  noSelection="['':'- Choose -']" />
                        <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'study', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: studySubjectInstance, field: 'studySubjectIdentifier', 'error')} required">
                    <label for="studySubjectIdentifier" class="control-label"><g:message code="studySubject.studySubjectIdentifier.label" default="Participant ID" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:textField class="form-control" name="studySubjectIdentifier" maxlength="50" required="" value="${studySubjectIdentifier}"/>
                        <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'studySubjectIdentifier', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: studySubjectInstance, field: 'consentFormNumber', 'error')} required">
                    <label for="consentFormNumber" class="control-label"><g:message code="studySubject.consentFormNumber.label" default="Consent Form Number" /></label>
                    <div>
                        <g:textField class="form-control" name="consentFormNumber" maxlength="50" value="${participantInstance?.studySubject?.consentFormNumber}"/>
                        <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'consentFormNumber', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div id="filter" class="${hasErrors(bean: studySubjectInstance, field: 'consentFormVersion', 'error')} required">
                    <label for="consentFormVersion" class="control-label"><g:message code="studySubject.consentFormVersion.label" default="Consent Form Version" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:textField class="form-control" name="consentFormVersion" maxlength="50" value="${consentFormVersion}"/>
                        <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'consentFormVersion', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: studySubjectInstance, field: 'consentStatus', 'error')} ">
                    <label for="consentStatus" class="control-label"><g:message code="studySubject.consentStatus.label" default="Consent Status" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:radioGroup name="consentStatus"
                                      values="[true, false]"
                                      labels="['Yes', 'No']"
                                      value="${true}">
                            ${it.label}  ${it.radio}
                        </g:radioGroup>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: studySubjectInstance, field: 'recruitmentDate', 'error')} required">
                    <label for="recruitmentDate" class="control-label"><g:message code="studySubject.recruitmentDate.label" default="Recruitment Date" /></label>
                    <div>
                        <bs:datePicker name="recruitmentDate" precision="day"  value="${participantInstance?.studySubject?.recruitmentDate}" default="none"  />
                        <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'recruitmentDate', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: studySubjectInstance, field: 'recruitedBy', 'error')} ">
                    <label for="recruitedBy" class="control-label"><g:message code="studySubject.recruitedBy.label" default="Recruited By" /></label>
                    <div>
                        <g:textField class="form-control" name="recruitedBy" value="${participantInstance?.studySubject?.recruitedBy}"/>
                        <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'recruitedBy', 'error')}</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="isEmpty">
            <div class="modal-dialog" style="position: absolute; left: 0%;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">Required!</h4>
                    </div>
                    <div class="modal-body">
                        <p>You need to choose a consent type before choosing consent form version </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-actions margin-top-medium">
            <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'save', default: 'Save')}" />
            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
        </div>
    </g:form>

</section>

<hr/>

<g:javascript plugin="jquery" library="jquery" />
<script>

    function callICD10(diagnosis){
        document.getElementById('diagnosis').value = diagnosis;
    }

    function filterVersion(){
        ${remoteFunction (controller: 'studySubject',
                        action: 'filterConsentVersionForm',
                        params: '"study=" + $("#study").val()',
                        update: 'filter',
                        onFailure: 'consentError()'
                )}
        disable()
    }

    function consentError(request, status, error){
        $('#consentFormVersion').val("");
    }

    function disable(){
        if ($.trim($("#study").val()) == ''){
            $('#consentFormVersion').prop('disabled', 'disabled');
        } else{
            $('#consentFormVersion').prop('disabled', false);
        }
    }

    function alertUser(){
        if ($.trim($("#study").val()) == ''){
            $('#consentFormVersion').prop('disabled', 'disabled');
            $('#isEmpty').modal()
        }
    }
</script>

</body>

</html>