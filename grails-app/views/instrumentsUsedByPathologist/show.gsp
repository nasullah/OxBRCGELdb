
<%@ page import="geldb.InstrumentsUsedByPathologist" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'instrumentsUsedByPathologist.label', default: 'Instruments Used By Pathologist')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-instrumentsUsedByPathologist" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="instrumentsUsedByPathologist.solidSpecimenReport.label" default="Solid Specimen Report" /></td>
				
				<td valign="top" class="value"><g:link controller="solidSpecimenReport" action="show" id="${instrumentsUsedByPathologistInstance?.solidSpecimenReport?.id}">${instrumentsUsedByPathologistInstance?.solidSpecimenReport?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="instrumentsUsedByPathologist.instruments.label" default="Instruments" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: instrumentsUsedByPathologistInstance, field: "instruments")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
