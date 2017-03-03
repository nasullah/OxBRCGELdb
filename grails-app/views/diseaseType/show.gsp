
<%@ page import="geldb.DiseaseType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'diseaseType.label', default: 'Disease Type')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-diseaseType" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="diseaseType.participant.label" default="Participant" /></td>
				
				<td valign="top" class="value"><g:link controller="participant" action="show" id="${diseaseTypeInstance?.participant?.id}">${diseaseTypeInstance?.participant?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="diseaseType.expectedDiseaseType.label" default="Expected Disease Type" /></td>
				
				<td valign="top" class="value"><g:link controller="anatomicalSite" action="show" id="${diseaseTypeInstance?.expectedDiseaseType?.id}">${diseaseTypeInstance?.expectedDiseaseType?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="diseaseType.recordedDate.label" default="Recorded Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${diseaseTypeInstance?.recordedDate}" /></td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
