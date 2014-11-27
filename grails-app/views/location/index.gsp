
<%@ page import="geldb.Location" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'location.label', default: 'Location')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-location" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="locationName" title="${message(code: 'location.locationName.label', default: 'Location Name')}" />
			
				<g:sortableColumn property="locationDescription" title="${message(code: 'location.locationDescription.label', default: 'Location Description')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${locationInstanceList}" status="i" var="locationInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${locationInstance.id}">${fieldValue(bean: locationInstance, field: "locationName")}</g:link></td>
			
				<td>${fieldValue(bean: locationInstance, field: "locationDescription")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${locationInstanceCount}" />
	</div>
</section>

</body>

</html>
