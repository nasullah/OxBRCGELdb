<%@ page import="geldb.Participant" %>


            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'familyName', 'error')} ">
                        <label for="familyName" class="control-label"><g:message code="participant.familyName.label" default="Family Name" /></label>
                        <div>
                            <g:textField class="form-control" name="familyName" value="${participantInstance?.familyName}"/>
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'familyName', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'givenName', 'error')} ">
                        <label for="givenName" class="control-label"><g:message code="participant.givenName.label" default="Given Name" /></label>
                        <div>
                            <g:textField class="form-control" name="givenName" value="${participantInstance?.givenName}"/>
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'givenName', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			<div class="${hasErrors(bean: participantInstance, field: 'dateOfBirth', 'error')} ">
				<label for="dateOfBirth" class="control-label"><g:message code="participant.dateOfBirth.label" default="Date Of Birth" /></label>
				<div>
					<bs:datePicker name="dateOfBirth" precision="day"   value="${participantInstance?.dateOfBirth}" default="none" noSelection="['': '']" /><span class="">Select or enter date as YYYY-MM-DD</span>
					<span class="help-inline">${hasErrors(bean: participantInstance, field: 'dateOfBirth', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'gender', 'error')} ">
                        <label for="gender" class="control-label"><g:message code="participant.gender.label" default="Gender" /></label>
                        <div>
                            <g:select class="form-control" name="gender" from="${participantInstance.constraints.gender.inList}" value="${participantInstance?.gender}" valueMessagePrefix="participant.gender" noSelection="['': '']"/>
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'gender', 'error')}</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'nHSNumber', 'error')} ">
                        <label for="nHSNumber" class="control-label"><g:message code="participant.nHSNumber.label" default="NHS Number" /></label>
                        <div>
                            <g:textField class="form-control" name="nHSNumber" value="${participantInstance?.nHSNumber}"/>
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'nHSNumber', 'error')}</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'hospitalNumber', 'error')} ">
                        <label for="hospitalNumber" class="control-label"><g:message code="participant.hospitalNumber.label" default="Hospital Number" /></label>
                        <div>
                            <g:textField class="form-control" name="hospitalNumber" value="${participantInstance?.hospitalNumber}"/>
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'hospitalNumber', 'error')}</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'diagnosis', 'error')} required">
                        <label for="diagnosis" class="control-label"><g:message code="participant.diagnosis.label" default="Diagnosis" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="diagnosis" name="diagnosis.id" from="${geldb.ICD10.list()}" optionKey="id" required="" value="${participantInstance?.diagnosis?.id}" />
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'diagnosis', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			%{--<div class="${hasErrors(bean: participantInstance, field: 'specimen', 'error')} ">--}%
				%{--<label for="specimen" class="control-label"><g:message code="participant.specimen.label" default="Specimen" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${participantInstance?.specimen?}" var="s">--}%
    %{--<li><g:link controller="specimen" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="specimen" action="create" params="['participant.id': participantInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'specimen.label', default: 'Specimen')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: participantInstance, field: 'specimen', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: participantInstance, field: 'studySubject', 'error')} ">--}%
				%{--<label for="studySubject" class="control-label"><g:message code="participant.studySubject.label" default="Study Subject" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${participantInstance?.studySubject?}" var="s">--}%
    %{--<li><g:link controller="studySubject" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="studySubject" action="create" params="['participant.id': participantInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'studySubject.label', default: 'StudySubject')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: participantInstance, field: 'studySubject', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

