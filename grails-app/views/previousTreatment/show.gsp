
<%@ page import="geldb.PreviousTreatment" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'previousTreatment.label', default: 'Previous Treatment')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-previousTreatment" class="first">

	<table class="table">
		<tbody>

			<tr class="prop">
				<td valign="top" class="name"><g:message code="previousTreatment.participant.label" default="Participant" /></td>

				<td valign="top" class="value"><g:link controller="participant" action="show" id="${previousTreatmentInstance?.participant?.id}">${previousTreatmentInstance?.participant?.encodeAsHTML()}</g:link></td>

			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="previousTreatment.previousTreatmentName.label" default="Previous Treatment Type" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: previousTreatmentInstance, field: "previousTreatmentType")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
