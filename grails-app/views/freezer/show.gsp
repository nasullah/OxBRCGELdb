
<%@ page import="geldb.Freezer" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'freezer.label', default: 'Freezer')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-freezer" class="first">

	<table class="table">
		<tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="freezer.centre.label" default="Centre" /></td>

                <td valign="top" class="value"><g:link controller="centre" action="show" id="${freezerInstance?.centre?.id}">${freezerInstance?.centre?.encodeAsHTML()}</g:link></td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="freezer.freezerName.label" default="Freezer Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: freezerInstance, field: "freezerName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="freezer.freezerTemperature.label" default="Freezer Temperature" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: freezerInstance, field: "freezerTemperature")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="freezer.room.label" default="Room" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: freezerInstance, field: "room")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="freezer.freezerNotes.label" default="Freezer Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: freezerInstance, field: "freezerNotes")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="freezer.shelfs.label" default="Shelf/Tower" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${freezerInstance.shelfs}" var="s">
						<li><g:link controller="shelf" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

<hr/>

<p class="text-primary">Available Action</p>

<a class='btn btn-primary btn-xs' <g:link controller="shelf" action="create" params="['freezer.id': freezerInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'shelf.label', default: 'Shelf/Tower')])}</g:link>

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

					<td>${fieldValue(bean: auditLogInstance, field: "eventName")} Freezer</td>

					<td>${freezerInstance.id}</td>

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
