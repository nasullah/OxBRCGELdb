
<%@ page import="geldb.StaffMember" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'staffMember.label', default: 'Staff Member')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-staffMember" class="first">

	<table class="table">
		<tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="staffMember.centre.label" default="Centre" /></td>

                <td valign="top" class="value"><g:link controller="centre" action="show" id="${staffMemberInstance?.centre?.id}">${staffMemberInstance?.centre?.encodeAsHTML()}</g:link></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="staffMember.staffRole.label" default="Staff Role" /></td>

                <td valign="top" class="value">${fieldValue(bean: staffMemberInstance, field: "staffRole")}</td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="staffMember.staffName.label" default="Staff Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: staffMemberInstance, field: "staffName")}</td>
				
			</tr>

		
		</tbody>
	</table>
</section>

</body>

</html>
