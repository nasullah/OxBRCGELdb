<%@ page import="geldb.StudySubject" %>


            <p><b>Participant- ${studySubjectInstance?.participant}</b></p>

			%{--<div class="${hasErrors(bean: studySubjectInstance, field: 'participant', 'error')} required">--}%
				%{--<label for="participant" class="control-label"><g:message code="studySubject.participant.label" default="Participant" /><span class="required-indicator">*</span></label>--}%
				%{--<div>--}%
					%{--<g:select class="form-control" id="participant" name="participant.id" from="${geldb.Participant.list()}" optionKey="id" required="" value="${studySubjectInstance?.participant?.id}" class="many-to-one"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'participant', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

            <g:hiddenField name="participant.id" id="participant" value="${studySubjectInstance?.participant?.id}"  />

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: studySubjectInstance, field: 'study', 'error')} required">
                        <label for="study" class="control-label"><g:message code="studySubject.study.label" default="Consent Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="study" name="study.id" from="${geldb.Study.list()}" optionKey="id" required="" value="${studySubjectInstance?.study?.id}" onchange="filterVersion()"  noSelection="['':'- Choose -']" />
                            <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'study', 'error')}</span>
                        </div>
                    </div>
                </div>

                <g:if test="${studySubjectInstance.participant.studySubject.findResult("Null") {it.studySubjectIdentifier ? it : null} == "Null" || studySubjectInstance.studySubjectIdentifier != null}">
                    <div class="col-lg-6">
                        <div class="${hasErrors(bean: studySubjectInstance, field: 'studySubjectIdentifier', 'error')} required">
                            <label for="studySubjectIdentifier" class="control-label"><g:message code="studySubject.studySubjectIdentifier.label" default="GeL STUDY ID (GELnnn)/Participant ID" /><span class="required-indicator">*</span></label>
                            <div>
                                <g:textField class="form-control" name="studySubjectIdentifier" maxlength="50" required="" value="${studySubjectInstance?.studySubjectIdentifier}"/>
                                <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'studySubjectIdentifier', 'error')}</span>
                            </div>
                        </div>
                    </div>
                </g:if>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: studySubjectInstance, field: 'consentFormNumber', 'error')} required">
                        <label for="consentFormNumber" class="control-label"><g:message code="studySubject.consentFormNumber.label" default="Consent Form Number" /></label>
                        <div>
                            <g:textField class="form-control" name="consentFormNumber" maxlength="50" value="${studySubjectInstance?.consentFormNumber}"/>
                            <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'consentFormNumber', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div id="filter" class="${hasErrors(bean: studySubjectInstance, field: 'consentFormVersion', 'error')} required">
                        <label for="consentFormVersion" class="control-label"><g:message code="studySubject.consentFormVersion.label" default="Consent Form Version" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" name="consentFormVersion" id="consentFormVersion" from="${studySubjectInstance.constraints.consentFormVersion.inList}" value="${studySubjectInstance?.consentFormVersion}" valueMessagePrefix="studySubjectInstance.consentFormVersion" noSelection="['':'- Choose -']" onclick="alertUser()"/>
                            <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'consentFormVersion', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: studySubjectInstance, field: 'consentStatus', 'error')} ">
                        <label for="consentStatus" class="control-label"><g:message code="studySubject.consentStatus.label" default="Consent Status" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:radioGroup name="consentStatus"
                                          values="[true, false, '']"
                                          labels="['Yes', 'No', 'Not completed']"
                                          value="${studySubjectInstance?.consentStatus}">
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
                            <bs:datePicker name="recruitmentDate" precision="day"  value="${studySubjectInstance?.recruitmentDate}"  />
                            <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'recruitmentDate', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: studySubjectInstance, field: 'recruitedBy', 'error')} ">
                        <label for="recruitedBy" class="control-label"><g:message code="studySubject.recruitedBy.label" default="Recruited By" /></label>
                        <div>
                            <g:textField class="form-control" name="recruitedBy" value="${studySubjectInstance?.recruitedBy}"/>
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

<g:javascript plugin="jquery" library="jquery" />
<script>
    function filterVersion(){
        ${remoteFunction (controller: 'studySubject',
                        action: 'filterConsentVersionForm',
                        params: '"study=" + $("#study").val()',
                        update: 'filter',
                        onFailure: 'error()'
                )}
        disable()
    }

    function error(request, status, error){
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



