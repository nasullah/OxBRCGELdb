
<%@ page import="geldb.CollectionMethod" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'collectionMethod.label', default: 'Collection Method')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-collectionMethod" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="collectionMethodName" title="${message(code: 'collectionMethod.collectionMethodName.label', default: 'Collection Method Name')}" />
			
				<g:sortableColumn property="collectionMethodDesc" title="${message(code: 'collectionMethod.collectionMethodDesc.label', default: 'Collection Method Desc')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${collectionMethodInstanceList}" status="i" var="collectionMethodInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${collectionMethodInstance.id}">${fieldValue(bean: collectionMethodInstance, field: "collectionMethodName")}</g:link></td>
			
				<td>${fieldValue(bean: collectionMethodInstance, field: "collectionMethodDesc")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${collectionMethodInstanceCount}" />
	</div>
</section>

</body>

</html>
