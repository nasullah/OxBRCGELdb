
<%@ page import="geldb.DNAExtractionStatus" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNAExtractionStatus.label', default: 'DNA Extraction Status')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-DNAExtractionStatus" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNAExtractionStatus.status.label" default="Status" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNAExtractionStatusInstance, field: "status")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
