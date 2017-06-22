
<%@ page import="geldb.PreviousTreatmentType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'previousTreatmentType.label', default: 'Previous Treatment Type')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-previousTreatmentType" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="previousTreatmentType.previousTreatmentTypeName.label" default="Previous Treatment Type Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: previousTreatmentTypeInstance, field: "previousTreatmentTypeName")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
