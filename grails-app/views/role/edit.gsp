<html>

<head>
	<meta name='layout' content='springSecurityUI'/>
	<g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}"/>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<style>

	#navbar {
		max-width: 1150px;
		margin: 0 auto;
	}

	#editRole {
		max-width: 500px;
		margin: 0 auto;
	}

	</style>
</head>

<body>

<center><h3 style="font-size: xx-large">Edit Role</h3></center>

<div id='navbar'>
	<g:render template="/_menu/navbar"/>

	<g:render template="/_menu/menubar"/>

	<p>

</div>

<div  id="editRole">

	<g:form action="update" name='roleEditForm'>
	<g:hiddenField name="id" value="${role?.id}"/>
	<g:hiddenField name="version" value="${role?.version}"/>

	<%
	def tabData = []
	tabData << [name: 'roleinfo', icon: 'icon_role',  messageCode: 'spring.security.ui.role.info']
	tabData << [name: 'users',    icon: 'icon_users', messageCode: 'spring.security.ui.role.users']
	%>

	<s2ui:tabs elementId='tabs' height='150' data="${tabData}">

		<s2ui:tab name='roleinfo' height='150'>
			<table>
			<tbody>
				<s2ui:textFieldRow name='authority' labelCode='role.authority.label' bean="${role}"
								labelCodeDefault='Authority' value="${role?.authority}"/>
			</tbody>
			</table>
		</s2ui:tab>

		<s2ui:tab name='users' height='150'>
			<g:if test='${users.empty}'>
			<g:message code="spring.security.ui.role_no_users"/>
			</g:if>
			<g:each var="u" in="${users}">
				<g:link controller='user' action='edit' id='${u.id}'>${u.username.encodeAsHTML()}</g:link><br/>
			</g:each>
		</s2ui:tab>

	</s2ui:tabs>

	<div style='float:left; margin-top: 10px;'>
	<s2ui:submitButton elementId='update' form='roleEditForm' messageCode='default.button.update.label'/>

	<g:if test='${role}'>
	<s2ui:deleteButton />
	</g:if>

	</div>

	</g:form>

</div>
<g:if test='${role}'>
<s2ui:deleteButtonForm instanceId='${role.id}'/>
</g:if>

</body>
</html>
