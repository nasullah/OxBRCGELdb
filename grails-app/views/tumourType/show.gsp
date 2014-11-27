
<%@ page import="geldb.TumourType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'tumourType.label', default: 'Tumour Type')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-tumourType" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="tumourType.tumourLocation.label" default="Tumour Location" /></td>
				
				<td valign="top" class="value"><g:link controller="tumourLocation" action="show" id="${tumourTypeInstance?.tumourLocation?.id}">${tumourTypeInstance?.tumourLocation?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="tumourType.tumourType.label" default="Tumour Type" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: tumourTypeInstance, field: "tumourType")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
