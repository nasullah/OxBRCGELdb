
<%@ page import="geldb.DNA_Extract" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNA_Extract.label', default: 'DNA Extract')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-DNA_Extract" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="localIdentifier" title="${message(code: 'DNA_Extract.localIdentifier.label', default: 'Local Identifier')}" />
			
				<g:sortableColumn property="size" title="${message(code: 'DNA_Extract.size.label', default: 'Size')}" />
			
				<g:sortableColumn property="unit" title="${message(code: 'DNA_Extract.unit.label', default: 'Unit')}" />
			
				<g:sortableColumn property="exhausted" title="${message(code: 'DNA_Extract.exhausted.label', default: 'Exhausted')}" />
			
				<g:sortableColumn property="passFail" title="${message(code: 'DNA_Extract.passFail.label', default: 'Pass Fail')}" />
			
				<g:sortableColumn property="notes" title="${message(code: 'DNA_Extract.notes.label', default: 'Notes')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${DNA_ExtractInstanceList}" status="i" var="DNA_ExtractInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${DNA_ExtractInstance.id}">${fieldValue(bean: DNA_ExtractInstance, field: "localIdentifier")}</g:link></td>
			
				<td>${fieldValue(bean: DNA_ExtractInstance, field: "size")}</td>
			
				<td>${fieldValue(bean: DNA_ExtractInstance, field: "unit")}</td>
			
				<td><g:formatBoolean boolean="${DNA_ExtractInstance.exhausted}" /></td>
			
				<td><g:formatBoolean boolean="${DNA_ExtractInstance.passFail}" /></td>
			
				<td>${fieldValue(bean: DNA_ExtractInstance, field: "notes")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${DNA_ExtractInstanceCount}" />
	</div>
</section>

</body>

</html>
