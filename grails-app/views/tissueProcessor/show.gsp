
<%@ page import="geldb.TissueProcessor" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'tissueProcessor.label', default: 'Tissue Processor')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-tissueProcessor" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="tissueProcessor.tissueProcessorName.label" default="Tissue Processor Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: tissueProcessorInstance, field: "tissueProcessorName")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
