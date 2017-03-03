
<%@ page import="geldb.DiseaseType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'diseaseType.label', default: 'Disease Type')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-diseaseType" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="diseaseType.participant.label" default="Participant" /></th>
			
				<th><g:message code="diseaseType.expectedDiseaseType.label" default="Expected Disease Type" /></th>
			
				<g:sortableColumn property="recordedDate" title="${message(code: 'diseaseType.recordedDate.label', default: 'Recorded Date')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${diseaseTypeInstanceList}" status="i" var="diseaseTypeInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${diseaseTypeInstance.id}">${fieldValue(bean: diseaseTypeInstance, field: "participant")}</g:link></td>
			
				<td>${fieldValue(bean: diseaseTypeInstance, field: "expectedDiseaseType")}</td>
			
				<td><g:formatDate date="${diseaseTypeInstance.recordedDate}" /></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${diseaseTypeInstanceCount}" />
	</div>
</section>

</body>

</html>
