
<%@ page import="geldb.ExtractionType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'extractionType.label', default: 'Extraction Type')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-extractionType" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="extractionType.extractionTypeName.label" default="Extraction Type Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: extractionTypeInstance, field: "extractionTypeName")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
