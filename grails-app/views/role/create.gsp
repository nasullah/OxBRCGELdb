<html>

<head>
	<meta name='layout' content='springSecurityUI'/>
	<g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}"/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<style>

	#navbar {
		max-width: 1150px;
		margin: 0 auto;
	}

	#roleForm {
		max-width: 500px;
		margin: 0 auto;
	}

	</style>
</head>

<body>

<center><h3 style="font-size: xx-large">Create Role</h3></center>

<div id='navbar'>
	<a class='btn btn-primary btn-s' <g:link controller="home" action="index" style="color: white"><i class="glyphicon glyphicon-home"></i> Back to Home Page</g:link>


	<p>

</div>

<div class="body" id="roleForm">

	<s2ui:form width='100%' height='200' elementId='formContainer'
	           titleCode='default.create.label' titleCodeArgs='[entityName]'>

	<g:form action="save" name='roleCreateForm'>
		<div class="dialog">

			<br/>

			<table>
				<tbody>

					<s2ui:textFieldRow name='authority' labelCode='role.authority.label' bean="${role}"
					                   size='50' labelCodeDefault='Authority' value="${role?.authority}"/>

					<tr><td>&nbsp;</td></tr>

					<tr class="prop">
						<td valign="top">
							<g:submitButton name="create" class="btn btn-primary" value="Save"/>
						</td>
					</tr>

				</tbody>
			</table>
		</div>

	</g:form>

	</s2ui:form>

</div>

<script>
$(document).ready(function() {
	$('#authority').focus();
});
</script>

</body>
</html>
