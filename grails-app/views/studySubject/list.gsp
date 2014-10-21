
<%@ page import="geldb.StudySubject" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'studySubject.label', default: 'Study Subject')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-studySubject" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="studySubject.study.label" default="Study" /></th>
			
				<th><g:message code="studySubject.Participant.label" default="Participant" /></th>
			
				<g:sortableColumn property="studySubjectIdentifier" title="${message(code: 'studySubject.studySubjectIdentifier.label', default: 'Study Subject Identifier')}" />
			
				<g:sortableColumn property="consentStatus" title="${message(code: 'studySubject.consentStatus.label', default: 'Consent Status')}" />
			
				<g:sortableColumn property="recruitmentDate" title="${message(code: 'studySubject.recruitmentDate.label', default: 'Recruitment Date')}" />
			
				<th><g:message code="studySubject.recruitedBy.label" default="Recruited By" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${studySubjectInstanceList}" status="i" var="studySubjectInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${studySubjectInstance.id}">${fieldValue(bean: studySubjectInstance, field: "study")}</g:link></td>
			
				<td>${fieldValue(bean: studySubjectInstance, field: "participant")}</td>
			
				<td>${fieldValue(bean: studySubjectInstance, field: "studySubjectIdentifier")}</td>
			
				<td><g:formatBoolean boolean="${studySubjectInstance.consentStatus}" /></td>
			
				<td><g:formatDate format="dd/MM/yyyy" date="${studySubjectInstance.recruitmentDate}" /></td>
			
				<td>${fieldValue(bean: studySubjectInstance, field: "recruitedBy")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${studySubjectInstanceCount}" />
	</div>
</section>

</body>

</html>
