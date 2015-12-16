<html>

<head>
	<meta name='layout' content='springSecurityUI'/>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<style>

	#navbar {
		max-width: 1150px;
		margin: 0 auto;
	}

	#searchRole {
		max-width: 500px;
		margin: 0 auto;
	}

	</style>
</head>

<body>

<center><h3 style="font-size: xx-large">Search Role</h3></center>

<div id='navbar'>
	<g:render template="/_menu/navbar"/>

	<g:render template="/_menu/menubar"/>

	<p>

</div>

<div id="searchRole">

	<s2ui:form width='100%' height='200' elementId='formContainer'
	           titleCode='spring.security.ui.role.search'>

	<g:form action='roleSearch' name='roleSearchForm'>

		<br/>

		<table>
			<tbody>
			<tr>
				<td><g:message code='role.authority.label' default='Authority'/>:</td>
				<td><g:textField name='authority' class='textField' size='50' maxlength='255' autocomplete='off' value='${authority}'/></td>
			</tr>
			<tr><td colspan='2'>&nbsp;</td></tr>
			<tr>
				<td colspan='2'><g:submitButton name="search" class="btn btn-success" value="Search"/></td>
			</tr>
			</tbody>
		</table>
	</g:form>

	</s2ui:form>

	<g:if test='${searched}'>

<%
def queryParams = [authority: authority]
%>

	<div class="list">
	<table>
		<thead>
		<tr>
			<g:sortableColumn property="authority" title="${message(code: 'role.authority.label', default: 'Authority')}" params="${queryParams}"/>
		</tr>
		</thead>

		<tbody>
		<g:each in="${results}" status="i" var="role">
		<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			<td><g:link action="edit" id="${role.id}">${fieldValue(bean: role, field: "authority")}</g:link></td>
		</tr>
		</g:each>
		</tbody>
	</table>
	</div>

	<div class="paginateButtons">
		<g:paginate total="${totalCount}" params="${queryParams}" />
	</div>

	<div style="text-align:center">
		<s2ui:paginationSummary total="${totalCount}"/>
	</div>

	</g:if>

</div>

<script>
$(document).ready(function() {
	$("#authority").focus().autocomplete({
		minLength: 2,
		cache: false,
		source: "${createLink(action: 'ajaxRoleSearch')}"
	});
});
</script>

</body>
</html>
