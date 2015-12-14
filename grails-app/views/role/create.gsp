<html>

<head>
	<meta name='layout' content='springSecurityUI'/>
	<g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}"/>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<style>

	body {

		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

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
	<g:render template="/_menu/navbar"/>

	<g:render template="/_menu/menubar"/>

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
