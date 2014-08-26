
<%@ page import="geldb.Specimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'specimen.label', default: 'Specimen')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-specimen" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="localIdentifier" title="${message(code: 'specimen.localIdentifier.label', default: 'Local Identifier')}" />
			
				<g:sortableColumn property="size" title="${message(code: 'specimen.size.label', default: 'Size')}" />
			
				<g:sortableColumn property="unit" title="${message(code: 'specimen.unit.label', default: 'Unit')}" />
			
				<g:sortableColumn property="exhausted" title="${message(code: 'specimen.exhausted.label', default: 'Exhausted')}" />
			
				<g:sortableColumn property="passFail" title="${message(code: 'specimen.passFail.label', default: 'Pass Fail')}" />
			
				<g:sortableColumn property="notes" title="${message(code: 'specimen.notes.label', default: 'Notes')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${specimenInstanceList}" status="i" var="specimenInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${specimenInstance.id}">${fieldValue(bean: specimenInstance, field: "localIdentifier")}</g:link></td>
			
				<td>${fieldValue(bean: specimenInstance, field: "size")}</td>
			
				<td>${fieldValue(bean: specimenInstance, field: "unit")}</td>
			
				<td><g:formatBoolean boolean="${specimenInstance.exhausted}" /></td>
			
				<td><g:formatBoolean boolean="${specimenInstance.passFail}" /></td>
			
				<td>${fieldValue(bean: specimenInstance, field: "notes")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${specimenInstanceCount}" />
	</div>
</section>

</body>

</html>
