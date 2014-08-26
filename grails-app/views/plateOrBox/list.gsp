
<%@ page import="geldb.PlateOrBox" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'plateOrBox.label', default: 'PlateOrBox')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-plateOrBox" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="identifier" title="${message(code: 'plateOrBox.identifier.label', default: 'Identifier')}" />
			
				<g:sortableColumn property="storageLocation" title="${message(code: 'plateOrBox.storageLocation.label', default: 'Storage Location')}" />
			
				<g:sortableColumn property="numberOfWells" title="${message(code: 'plateOrBox.numberOfWells.label', default: 'Number Of Wells')}" />
			
				<g:sortableColumn property="plateType" title="${message(code: 'plateOrBox.plateType.label', default: 'Plate Type')}" />
			
				<g:sortableColumn property="intendedAssay" title="${message(code: 'plateOrBox.intendedAssay.label', default: 'Intended Assay')}" />
			
				<g:sortableColumn property="notes" title="${message(code: 'plateOrBox.notes.label', default: 'Notes')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${plateOrBoxInstanceList}" status="i" var="plateOrBoxInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${plateOrBoxInstance.id}">${fieldValue(bean: plateOrBoxInstance, field: "identifier")}</g:link></td>
			
				<td>${fieldValue(bean: plateOrBoxInstance, field: "storageLocation")}</td>
			
				<td>${fieldValue(bean: plateOrBoxInstance, field: "numberOfWells")}</td>
			
				<td>${fieldValue(bean: plateOrBoxInstance, field: "plateType")}</td>
			
				<td>${fieldValue(bean: plateOrBoxInstance, field: "intendedAssay")}</td>
			
				<td>${fieldValue(bean: plateOrBoxInstance, field: "notes")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${plateOrBoxInstanceCount}" />
	</div>
</section>

</body>

</html>
