<%@ page import="geldb.Study" %>


            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: studyInstance, field: 'studyName', 'error')} ">
                        <label for="studyName" class="control-label"><g:message code="study.studyName.label" default="Study Name" /></label>
                        <div>
                            <g:textField class="form-control" name="studyName" value="${studyInstance?.studyName}"/>
                            <span class="help-inline">${hasErrors(bean: studyInstance, field: 'studyName', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			%{--<div class="${hasErrors(bean: studyInstance, field: 'studyIdentifiers', 'error')} ">--}%
				%{--<label for="studyIdentifiers" class="control-label"><g:message code="study.studyIdentifiers.label" default="Study Identifiers" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${studyInstance?.studyIdentifiers?}" var="s">--}%
    %{--<li><g:link controller="studyIdentifier" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="studyIdentifier" action="create" params="['study.id': studyInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'studyIdentifier.label', default: 'StudyIdentifier')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: studyInstance, field: 'studyIdentifiers', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: studyInstance, field: 'studySubject', 'error')} ">--}%
				%{--<label for="studySubject" class="control-label"><g:message code="study.studySubject.label" default="Study Subject" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${studyInstance?.studySubject?}" var="s">--}%
    %{--<li><g:link controller="studySubject" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="studySubject" action="create" params="['study.id': studyInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'studySubject.label', default: 'StudySubject')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: studyInstance, field: 'studySubject', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

