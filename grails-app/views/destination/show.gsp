
<%@ page import="geldb.Destination" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'destination.label', default: 'Destination')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-destination" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="destination.companyName.label" default="Company Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: destinationInstance, field: "companyName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="destination.companyAddress.label" default="Company Address" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: destinationInstance, field: "companyAddress")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="destination.companyPostalCode.label" default="Company Postal Code" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: destinationInstance, field: "companyPostalCode")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="destination.companyCountry.label" default="Company Country" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: destinationInstance, field: "companyCountry")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
