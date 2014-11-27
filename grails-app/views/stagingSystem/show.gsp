
<%@ page import="geldb.StagingSystem" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'stagingSystem.label', default: 'StagingSystem')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-stagingSystem" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="stagingSystem.stagingSystem.label" default="Staging System" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: stagingSystemInstance, field: "stagingSystem")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
