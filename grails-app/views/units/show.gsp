
<%@ page import="geldb.Units" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'units.label', default: 'Units')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-units" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="units.unitType.label" default="Unit Type" /></td>
				
				<td valign="top" class="value">${unitsInstance?.unitType?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="units.unitName.label" default="Unit Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: unitsInstance, field: "unitName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="units.unitDescription.label" default="Unit Description" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: unitsInstance, field: "unitDescription")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
