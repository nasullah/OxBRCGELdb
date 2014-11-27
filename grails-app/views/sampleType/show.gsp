
<%@ page import="geldb.SampleType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'sampleType.label', default: 'Sample Type')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-sampleType" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sampleType.sampleTypeName.label" default="Sample Type Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: sampleTypeInstance, field: "sampleTypeName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sampleType.sampleTypeDesc.label" default="Sample Type Desc" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: sampleTypeInstance, field: "sampleTypeDesc")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
