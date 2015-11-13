<%@ page import="geldb.Participant" %>


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
                <bs:datePicker name="dateOfBirth" precision="day"   value="${participantInstance?.dateOfBirth}" default="none"  /><span class="">Select or enter date as YYYY-MM-DD</span>
                <span class="help-inline">${hasErrors(bean: participantInstance, field: 'dateOfBirth', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: participantInstance, field: 'gender', 'error')} ">
            <label for="gender" class="control-label"><g:message code="participant.gender.label" default="Gender" /></label>
            <div>
                <g:select class="form-control" name="gender" from="${participantInstance.constraints.gender.inList}" value="${participantInstance?.gender}" valueMessagePrefix="participant.gender"  noSelection="['':'- Choose gender -']"/>
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
        <div class="${hasErrors(bean: participantInstance, field: 'solidSpecimenExpected', 'error')} ">
            <label for="solidSpecimenExpected" class="control-label"><g:message code="participantInstance.solidSpecimenExpected.label" default="Solid Specimen Expected?" /></label>
            <div>
                <g:radioGroup name="solidSpecimenExpected"
                              values="[true, false]"
                              labels="['Yes', 'No']"
                              value="${participantInstance?.solidSpecimenExpected}">
                    ${it.label}  ${it.radio}
                </g:radioGroup>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-6" id="showSearch">
        <label for="searchDiagnosis" class="control-label"><g:message code="participant.diagnosis.label" default="Enter diagnosis keywords or ICD10 code" /></label>
        <div class="input-group">
            <g:textField type="text" id="searchDiagnosis" name="searchDiagnosis" class="form-control"  placeholder="Enter diagnosis keywords separated by spaces" ></g:textField>
            <div class="input-group-btn">
                <button type="button" class="btn btn" value="Find" onClick= 'getICD10()'><span class="glyphicon glyphicon-search"></span> Find Diagnosis</button>
            </div>
        </div>
    </div>

    <div class="col-lg-6" id="selectICD10">
        <div class="${hasErrors(bean: participantInstance, field: 'diagnosis', 'error')} required">
            <label for="diagnosis" class="control-label"><g:message code="participant.diagnosis.label" default="Diagnosis" /></label>

            <div class="input-group">
                <g:select class="form-control" id="diagnosis" name="diagnosis.id" size="1" from="${geldb.ICD10.list()}" optionKey="id"  value="${participantInstance?.diagnosis?.id}" noSelection="['':'']"/>
                <span class="help-inline">${hasErrors(bean: participantInstance, field: 'diagnosis', 'error')}</span>
                <div class="input-group-btn">
                    <button type="button" class="btn btn" value="Edit" onClick= 'showSearch()'><span class="glyphicon glyphicon-pencil"></span> Edit</button>
                </div>
            </div>
        </div>
    </div>
</div>

<g:if test="${participantInstance.studySubject && participantInstance.studySubject.findResult("Null") {it.studySubjectIdentifier ? it : null} == "Null"}">
    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: participantInstance.studySubject, field: 'studySubjectIdentifier', 'error')} required">
                <label for="studySubjectIdentifier" class="control-label"><g:message code="studySubject.studySubjectIdentifier.label" default="GeL Study ID/Participant ID" /><span class="required-indicator">*</span></label>
                <div>
                    <g:textField class="form-control" name="studySubjectIdentifier" maxlength="50" required="" value="${participantInstance?.studySubject?.first()?.studySubjectIdentifier}"/>
                    <span class="help-inline">${hasErrors(bean: participantInstance.studySubject, field: 'studySubjectIdentifier', 'error')}</span>
                </div>
            </div>
        </div>
    </div>
</g:if>

<div class="modal fade" id="notFound">
    <div class="modal-dialog" style="position: absolute; left: 0%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">Not Found!</h4>
            </div>
            <div class="modal-body">
                <p>No ICD10 found with keywords you entered</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<g:javascript plugin="jquery" library="jquery" />
<script>

    var diagnosis = $("#diagnosis").val();
    hideICD10();

    if (diagnosis != ""){
        $("#showSearch").hide();
        $("#selectICD10").show();

    }

    function showSearch(){
        $("#showSearch").show();
        hideICD10();
    }

    function hideICD10(){
        $("#selectICD10").hide();
    }

    function showICD10(){
        $("#selectICD10").show();
    }

    function getICD10(){
        ${remoteFunction (controller: 'participant',
                        action: 'findICD10',
                        params: '"searchDiagnosis=" + $("#searchDiagnosis").val()',
                        update: 'selectICD10',
                        onFailure:'error()'
                )}
        showICD10()
    }

    function error(){
        var select = $("#selectICD10");
        select.empty().append("Not found");
        $('#notFound').modal()
    }
</script>
