
<%@ page import="geldb.Centre" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'centre.label', default: 'Centre')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-centre" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="centreName" title="${message(code: 'centre.centreName.label', default: 'Centre Name')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${centreInstanceList}" status="i" var="centreInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${centreInstance.id}">${fieldValue(bean: centreInstance, field: "centreName")}</g:link></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${centreInstanceCount}" />
	</div>
</section>

</body>

</html>
