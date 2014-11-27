
<%@ page import="geldb.StaffRole" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'staffRole.label', default: 'Staff Role')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-staffRole" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="staffRole.role.label" default="Role" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: staffRoleInstance, field: "role")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
