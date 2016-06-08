
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

<hr/>

<sec:ifAnyGranted roles="ROLE_ADMIN">
	<h2>Audit</h2>
	<section id="list-participant" class="first">

		<table class="table table-bordered margin-top-medium">
			<thead>
			<tr>
				<g:sortableColumn property="dateCreated" title="Date & Time" />

				<g:sortableColumn property="actor" title="Username" />

				<g:sortableColumn property="eventName" title="Event" />

				<g:sortableColumn property="persistedObjectId" title="Record" />

				<g:sortableColumn property="oldValue" title="Old Value" />

				<g:sortableColumn property="newValue" title="New Value" />

			</tr>
			</thead>
			<tbody>
			<g:each in="${listAuditLogData}" status="i" var="auditLogInstance">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

					<td><g:formatDate date="${auditLogInstance.dateCreated}" /></td>

					<td>${fieldValue(bean: auditLogInstance, field: "actor")}</td>

					<td>${fieldValue(bean: auditLogInstance, field: "eventName")} Location</td>

					<td>${locationInstance.id}</td>

					<td>${fieldValue(bean: auditLogInstance, field: "oldValue")}</td>

					<td>${fieldValue(bean: auditLogInstance, field: "newValue")}</td>

				</tr>
			</g:each>
			</tbody>
		</table>

	</section>
</sec:ifAnyGranted>

</body>

</html>
