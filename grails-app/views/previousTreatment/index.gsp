
<%@ page import="geldb.PreviousTreatment" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'previousTreatment.label', default: 'Previous Treatment')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-previousTreatment" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="previousTreatmentType" title="${message(code: 'previousTreatment.previousTreatmentType.label', default: 'Previous Treatment Type')}" />
			
				<th><g:message code="previousTreatment.participant.label" default="Participant" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${previousTreatmentInstanceList}" status="i" var="previousTreatmentInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${previousTreatmentInstance.id}">${fieldValue(bean: previousTreatmentInstance, field: "previousTreatmentType")}</g:link></td>
			
				<td>${fieldValue(bean: previousTreatmentInstance, field: "participant")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${previousTreatmentInstanceCount}" />
	</div>
</section>

</body>

</html>
