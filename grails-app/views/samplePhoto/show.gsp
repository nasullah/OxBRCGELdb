
<%@ page import="geldb.SamplePhoto" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'samplePhoto.label', default: 'SamplePhoto')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-samplePhoto" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="samplePhoto.samplePhoto.label" default="Sample Photo" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="samplePhoto.solidSpecimenReport.label" default="Solid Specimen Report" /></td>
				
				<td valign="top" class="value"><g:link controller="solidSpecimenReport" action="show" id="${samplePhotoInstance?.solidSpecimenReport?.id}">${samplePhotoInstance?.solidSpecimenReport?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
