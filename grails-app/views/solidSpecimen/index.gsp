
<%@ page import="geldb.SolidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'solidSpecimen.label', default: 'Solid Specimen')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-solidSpecimen" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="localIdentifier" title="${message(code: 'solidSpecimen.localIdentifier.label', default: 'Local Identifier')}" />
			
				<g:sortableColumn property="size" title="${message(code: 'solidSpecimen.size.label', default: 'Size')}" />
			
				<g:sortableColumn property="unit" title="${message(code: 'solidSpecimen.unit.label', default: 'Unit')}" />
			
				<g:sortableColumn property="exhausted" title="${message(code: 'solidSpecimen.exhausted.label', default: 'Exhausted')}" />
			
				<g:sortableColumn property="passFail" title="${message(code: 'solidSpecimen.passFail.label', default: 'Pass Fail')}" />
			
				<g:sortableColumn property="notes" title="${message(code: 'solidSpecimen.notes.label', default: 'Notes')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${solidSpecimenInstanceList}" status="i" var="solidSpecimenInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${solidSpecimenInstance.id}">${fieldValue(bean: solidSpecimenInstance, field: "localIdentifier")}</g:link></td>
			
				<td>${fieldValue(bean: solidSpecimenInstance, field: "size")}</td>
			
				<td>${fieldValue(bean: solidSpecimenInstance, field: "unit")}</td>
			
				<td><g:formatBoolean boolean="${solidSpecimenInstance.exhausted}" /></td>
			
				<td><g:formatBoolean boolean="${solidSpecimenInstance.passFail}" /></td>
			
				<td>${fieldValue(bean: solidSpecimenInstance, field: "notes")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${solidSpecimenInstanceCount}" />
	</div>
</section>

</body>

</html>
