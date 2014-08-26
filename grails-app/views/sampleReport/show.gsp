
<%@ page import="geldb.SampleReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'sampleReport.label', default: 'Sample Report')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-sampleReport" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sampleReport.reportDate.label" default="Report Date" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${sampleReportInstance?.reportDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sampleReport.reportStaff.label" default="Report Staff" /></td>
				
				<td valign="top" class="value">${sampleReportInstance?.reportStaff?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sampleReport.comments.label" default="Comments" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: sampleReportInstance, field: "comments")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sampleReport.aliquot.label" default="Aliquot" /></td>
				
				<td valign="top" class="value"><g:link controller="aliquot" action="show" id="${sampleReportInstance?.aliquot?.id}">${sampleReportInstance?.aliquot?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
