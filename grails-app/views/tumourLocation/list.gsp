
<%@ page import="geldb.TumourLocation" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'tumourLocation.label', default: 'Tumour Location')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-tumourLocation" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="tumourLocation" title="${message(code: 'tumourLocation.tumourLocation.label', default: 'Tumour Location')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${tumourLocationInstanceList}" status="i" var="tumourLocationInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${tumourLocationInstance.id}">${fieldValue(bean: tumourLocationInstance, field: "tumourLocation")}</g:link></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${tumourLocationInstanceCount}" />
	</div>
</section>

</body>

</html>
