
<%@ page import="geldb.Shelf" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'shelf.label', default: 'Shelf')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-shelf" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="shelf.freezer.label" default="Freezer" /></th>
			
				<g:sortableColumn property="shelfName" title="${message(code: 'shelf.shelfName.label', default: 'Shelf Name')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${shelfInstanceList}" status="i" var="shelfInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${shelfInstance.id}">${fieldValue(bean: shelfInstance, field: "freezer")}</g:link></td>
			
				<td>${fieldValue(bean: shelfInstance, field: "shelfName")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${shelfInstanceCount}" />
	</div>
</section>

</body>

</html>
