
<%@ page import="geldb.MethodOfTransport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'methodOfTransport.label', default: 'Method of Transport')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-methodOfTransport" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="methodOfTransport.methodOfTransportName.label" default="Method Of Transport Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: methodOfTransportInstance, field: "methodOfTransportName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="methodOfTransport.methodOfTransportDescription.label" default="Method Of Transport Description" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: methodOfTransportInstance, field: "methodOfTransportDescription")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
