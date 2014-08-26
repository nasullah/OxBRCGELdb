
<%@ page import="geldb.StaffMember" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'staffMember.label', default: 'Staff Member')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-staffMember" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="staffName" title="${message(code: 'staffMember.staffName.label', default: 'Staff Name')}" />
			
				<g:sortableColumn property="staffRole" title="${message(code: 'staffMember.staffRole.label', default: 'Staff Role')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${staffMemberInstanceList}" status="i" var="staffMemberInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${staffMemberInstance.id}">${fieldValue(bean: staffMemberInstance, field: "staffName")}</g:link></td>
			
				<td>${fieldValue(bean: staffMemberInstance, field: "staffRole")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${staffMemberInstanceCount}" />
	</div>
</section>

</body>

</html>
