
<%@ page import="geldb.InstrumentsUsedByPathologist" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'instrumentsUsedByPathologist.label', default: 'Instruments Used By Pathologist')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-instrumentsUsedByPathologist" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="instrumentsUsedByPathologist.solidSpecimenReport.label" default="Solid Specimen Report" /></th>
			
				<g:sortableColumn property="instruments" title="${message(code: 'instrumentsUsedByPathologist.instruments.label', default: 'Instruments')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${instrumentsUsedByPathologistInstanceList}" status="i" var="instrumentsUsedByPathologistInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${instrumentsUsedByPathologistInstance.id}">${fieldValue(bean: instrumentsUsedByPathologistInstance, field: "solidSpecimenReport")}</g:link></td>
			
				<td>${fieldValue(bean: instrumentsUsedByPathologistInstance, field: "instruments")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${instrumentsUsedByPathologistInstanceCount}" />
	</div>
</section>

</body>

</html>
