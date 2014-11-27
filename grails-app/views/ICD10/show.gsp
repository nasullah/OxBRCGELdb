
<%@ page import="geldb.ICD10" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'ICD10.label', default: 'ICD10')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-ICD10" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="ICD10.code.label" default="Code" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: ICD10Instance, field: "code")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="ICD10.meaning.label" default="Meaning" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: ICD10Instance, field: "meaning")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
