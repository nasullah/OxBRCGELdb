<html>

<head>
	<meta name='layout' content='springSecurityUI'/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

	<style>

	#navbar {
		max-width: 1150px;
		margin: 0 auto;
	}

	#userForm {
		max-width: 500px;
		margin: 0 auto;
	}

	</style>
</head>

<body>

<center><h3 style="font-size: xx-large">Create User</h3></center>

<div id='navbar'>

	<a class='btn btn-primary btn-s' <g:link controller="home" action="index" style="color: white"><i class="glyphicon glyphicon-home"></i> Back to Home Page</g:link>

	<p>

</div>

<div id='userForm'>
	<g:form action="save" name='userCreateForm'>

	<%
	def tabData = []
	tabData << [name: 'userinfo', icon: 'icon_user', messageCode: 'spring.security.ui.user.info']
	tabData << [name: 'roles',    icon: 'icon_role', messageCode: 'spring.security.ui.user.roles']
	%>

	<s2ui:tabs elementId='tabs' height='375' data="${tabData}">

		<s2ui:tab name='userinfo' height='280'>
			<table>
			<tbody>

				<s2ui:textFieldRow name='username' labelCode='user.username.label' bean="${user}"
								labelCodeDefault='Username' value="${user?.username}"/>

				<s2ui:passwordFieldRow name='password' labelCode='user.password.label' bean="${user}"
									labelCodeDefault='Password' value="${user?.password}"/>

				<s2ui:checkboxRow name='enabled' labelCode='user.enabled.label' bean="${user}"
							   labelCodeDefault='Enabled' value="${user?.enabled}"/>

				<s2ui:checkboxRow name='accountExpired' labelCode='user.accountExpired.label' bean="${user}"
							   labelCodeDefault='Account Expired' value="${user?.accountExpired}"/>

				<s2ui:checkboxRow name='accountLocked' labelCode='user.accountLocked.label' bean="${user}"
							   labelCodeDefault='Account Locked' value="${user?.accountLocked}"/>

				<s2ui:checkboxRow name='passwordExpired' labelCode='user.passwordExpired.label' bean="${user}"
							   labelCodeDefault='Password Expired' value="${user?.passwordExpired}"/>
			</tbody>
			</table>
		</s2ui:tab>

		<s2ui:tab name='roles' height='280'>
			<g:each var="auth" in="${authorityList}">
			<div>
				<g:checkBox name="${auth.authority}" />
				<g:link controller='role' action='edit' id='${auth.id}'>${auth.authority.encodeAsHTML()}</g:link>
			</div>
			</g:each>
		</s2ui:tab>

	</s2ui:tabs>

	<div style='float:left; margin-top: 10px; '>
	<g:submitButton name="create" class="btn btn-primary" value="Save"/>
	</div>

	</g:form>
</div>

<script>
$(document).ready(function() {
	$('#username').focus();
	<s2ui:initCheckboxes/>
});
</script>

</body>
</html>
