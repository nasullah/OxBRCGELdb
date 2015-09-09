
<%@ page import="geldb.DispatchedBox" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'dispatchedBox.label', default: 'Dispatched Box')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-dispatchedBox" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="dispatchedBox.dispatchRecord.label" default="Dispatch Record" /></th>
			
				<g:sortableColumn property="barcode" title="${message(code: 'dispatchedBox.barcode.label', default: 'Barcode')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${dispatchedBoxInstanceList}" status="i" var="dispatchedBoxInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${dispatchedBoxInstance.id}">${fieldValue(bean: dispatchedBoxInstance, field: "dispatchRecord")}</g:link></td>
			
				<td>${fieldValue(bean: dispatchedBoxInstance, field: "barcode")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${dispatchedBoxInstanceCount}" />
	</div>
</section>

</body>

</html>
