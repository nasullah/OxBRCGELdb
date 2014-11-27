
<%@ page import="geldb.CollectionMethod" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'collectionMethod.label', default: 'Collection Method')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-collectionMethod" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="collectionMethod.collectionMethodName.label" default="Collection Method Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: collectionMethodInstance, field: "collectionMethodName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="collectionMethod.collectionMethodDesc.label" default="Collection Method Desc" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: collectionMethodInstance, field: "collectionMethodDesc")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
