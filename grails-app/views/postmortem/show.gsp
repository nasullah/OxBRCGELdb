
<%@ page import="geldb.Postmortem" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'postmortem.label', default: 'Postmortem')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-postmortem" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="postmortem.solidSpecimenReport.label" default="Solid Specimen Report" /></td>
				
				<td valign="top" class="value"><g:link controller="solidSpecimenReport" action="show" id="${postmortemInstance?.solidSpecimenReport?.id}">${postmortemInstance?.solidSpecimenReport?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="postmortem.delayInHours.label" default="Delay In Hours" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: postmortemInstance, field: "delayInHours")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="postmortem.warmIschemiaTimeMin.label" default="Warm Ischemia Time Min" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: postmortemInstance, field: "warmIschemiaTimeMin")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="postmortem.coldIschemiaTimeMin.label" default="Cold Ischemia Time Min" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: postmortemInstance, field: "coldIschemiaTimeMin")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
