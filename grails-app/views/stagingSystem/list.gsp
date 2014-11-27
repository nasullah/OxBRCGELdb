
<%@ page import="geldb.StagingSystem" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'stagingSystem.label', default: 'StagingSystem')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-stagingSystem" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="stagingSystem" title="${message(code: 'stagingSystem.stagingSystem.label', default: 'Staging System')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${stagingSystemInstanceList}" status="i" var="stagingSystemInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${stagingSystemInstance.id}">${fieldValue(bean: stagingSystemInstance, field: "stagingSystem")}</g:link></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${stagingSystemInstanceCount}" />
	</div>
</section>

</body>

</html>
