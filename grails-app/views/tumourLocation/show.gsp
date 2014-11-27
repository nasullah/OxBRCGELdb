
<%@ page import="geldb.TumourLocation" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'tumourLocation.label', default: 'Tumour Location')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-tumourLocation" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="tumourLocation.tumourLocation.label" default="Tumour Location" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: tumourLocationInstance, field: "tumourLocation")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
