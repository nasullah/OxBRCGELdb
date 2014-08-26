
<%@ page import="geldb.Freezer" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'freezer.label', default: 'Freezer')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-freezer" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="freezerName" title="${message(code: 'freezer.freezerName.label', default: 'Freezer Name')}" />
			
				<g:sortableColumn property="freezerTemperature" title="${message(code: 'freezer.freezerTemperature.label', default: 'Freezer Temperature')}" />
			
				<g:sortableColumn property="room" title="${message(code: 'freezer.room.label', default: 'Room')}" />
			
				<g:sortableColumn property="freezerNotes" title="${message(code: 'freezer.freezerNotes.label', default: 'Freezer Notes')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${freezerInstanceList}" status="i" var="freezerInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${freezerInstance.id}">${fieldValue(bean: freezerInstance, field: "freezerName")}</g:link></td>
			
				<td>${fieldValue(bean: freezerInstance, field: "freezerTemperature")}</td>
			
				<td>${fieldValue(bean: freezerInstance, field: "room")}</td>
			
				<td>${fieldValue(bean: freezerInstance, field: "freezerNotes")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${freezerInstanceCount}" />
	</div>
</section>

</body>

</html>
