
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
			
				<g:sortableColumn property="exhausted" title="${message(code: 'DNA_Extract.exhausted.label', default: 'Exhausted')}" />
			
				<g:sortableColumn property="passFail" title="${message(code: 'DNA_Extract.passFail.label', default: 'Pass Fail')}" />
			
				<g:sortableColumn property="passFailReason" title="${message(code: 'DNA_Extract.passFailReason.label', default: 'Pass Fail Reason')}" />
			
				<g:sortableColumn property="notes" title="${message(code: 'DNA_Extract.notes.label', default: 'Notes')}" />
			
				%{--<g:sortableColumn property="dNAConcentration" title="${message(code: 'DNA_Extract.dNAConcentration.label', default: 'D NAC oncentration')}" />--}%
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${DNA_ExtractInstanceList}" status="i" var="DNA_ExtractInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${DNA_ExtractInstance.id}">${fieldValue(bean: DNA_ExtractInstance, field: "exhausted")}</g:link></td>

				<td><g:formatBoolean boolean="${DNA_ExtractInstance.passFail}" /></td>
			
				<td>${fieldValue(bean: DNA_ExtractInstance, field: "passFailReason")}</td>
			
				<td>${fieldValue(bean: DNA_ExtractInstance, field: "notes")}</td>
			
				%{--<td>${fieldValue(bean: DNA_ExtractInstance, field: "dNAConcentration")}</td>--}%
			
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
