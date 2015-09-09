
<%@ page import="geldb.DNAExtractionKit" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNAExtractionKit.label', default: 'DNA Extraction Kit')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-DNAExtractionKit" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNAExtractionKit.extractionKitName.label" default="Extraction Kit Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNAExtractionKitInstance, field: "extractionKitName")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
