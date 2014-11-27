
<%@ page import="geldb.Location" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'location.label', default: 'Location')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-location" class="first">

	<table class="table">
		<tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="location.centre.label" default="Centre" /></td>

                <td valign="top" class="value"><g:link controller="centre" action="show" id="${locationInstance?.centre?.id}">${locationInstance?.centre?.encodeAsHTML()}</g:link></td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="location.locationName.label" default="Location Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: locationInstance, field: "locationName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="location.locationDescription.label" default="Location Description" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: locationInstance, field: "locationDescription")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
