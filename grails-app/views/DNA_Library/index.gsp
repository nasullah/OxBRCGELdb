
<%@ page import="geldb.DNA_Library" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNA_Library.label', default: 'DNA Library')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-DNA_Library" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="exhausted" title="${message(code: 'DNA_Library.exhausted.label', default: 'Exhausted')}" />
			
				<g:sortableColumn property="passFail" title="${message(code: 'DNA_Library.passFail.label', default: 'Pass Fail')}" />
			
				<g:sortableColumn property="passFailReason" title="${message(code: 'DNA_Library.passFailReason.label', default: 'Pass Fail Reason')}" />
			
				<g:sortableColumn property="notes" title="${message(code: 'DNA_Library.notes.label', default: 'Notes')}" />
			
				%{--<g:sortableColumn property="dNA_QC_qPCR" title="${message(code: 'DNA_Library.dNA_QC_qPCR.label', default: 'D NA QC q PCR')}" />--}%
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${DNA_LibraryInstanceList}" status="i" var="DNA_LibraryInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${DNA_LibraryInstance.id}">${fieldValue(bean: DNA_LibraryInstance, field: "exhausted")}</g:link></td>
			
				<td><g:formatBoolean boolean="${DNA_LibraryInstance.passFail}" /></td>
			
				<td>${fieldValue(bean: DNA_LibraryInstance, field: "passFailReason")}</td>
			
				<td>${fieldValue(bean: DNA_LibraryInstance, field: "notes")}</td>
			
				%{--<td>${fieldValue(bean: DNA_LibraryInstance, field: "dNA_QC_qPCR")}</td>--}%
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${DNA_LibraryInstanceCount}" />
	</div>
</section>

</body>

</html>
