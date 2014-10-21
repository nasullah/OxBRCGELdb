
<%@ page import="geldb.Participant" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'participant.label', default: 'Participant')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-participant" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="familyName" title="${message(code: 'participant.familyName.label', default: 'Family Name')}" />
			
				<g:sortableColumn property="givenName" title="${message(code: 'participant.givenName.label', default: 'Given Name')}" />
			
				<g:sortableColumn property="dateOfBirth" title="${message(code: 'participant.dateOfBirth.label', default: 'Date Of Birth')}" />
			
				<g:sortableColumn property="gender" title="${message(code: 'participant.gender.label', default: 'Gender')}" />
			
				<g:sortableColumn property="nHSNumber" title="${message(code: 'participant.nHSNumber.label', default: 'NHS Number')}" />
			
				<g:sortableColumn property="hospitalNumber" title="${message(code: 'participant.hospitalNumber.label', default: 'Hospital Number')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${participantInstanceList}" status="i" var="participantInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${participantInstance.id}">${fieldValue(bean: participantInstance, field: "familyName")}</g:link></td>
			
				<td>${fieldValue(bean: participantInstance, field: "givenName")}</td>
			
				<td><g:formatDate format="dd/MM/yyyy" date="${participantInstance.dateOfBirth}" /></td>
			
				<td>${fieldValue(bean: participantInstance, field: "gender")}</td>
			
				<td>${fieldValue(bean: participantInstance, field: "nHSNumber")}</td>
			
				<td>${fieldValue(bean: participantInstance, field: "hospitalNumber")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${participantInstanceCount}" />
	</div>
</section>

</body>

</html>
