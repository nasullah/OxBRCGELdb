
<%@ page import="geldb.AliquotType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'aliquotType.label', default: 'Aliquot Type')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-aliquotType" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotType.aliquotTypeName.label" default="Aliquot Type Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: aliquotTypeInstance, field: "aliquotTypeName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotType.aliquotTypeDesc.label" default="Aliquot Type Desc" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: aliquotTypeInstance, field: "aliquotTypeDesc")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
