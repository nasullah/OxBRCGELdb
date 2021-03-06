
<%@ page import="geldb.FixationReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:if test="${fixationReportInstance.aliquot.aliquotType.aliquotTypeName == 'Punch biopsy, PAXgene'}">
		<title>Show Fixation Report</title>
	</g:if>
	<g:else>
		<title>Show Genomic Block Fixation Report</title>
	</g:else>
</head>

<body>

<section id="show-fixationReport" class="first">

	<table class="table">
		<tbody>

			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.aliquot.label" default="Aliquot" /></td>

				<td valign="top" class="value"><g:link controller="aliquot" action="show" id="${fixationReportInstance?.aliquot?.id}">${fixationReportInstance?.aliquot?.encodeAsHTML()}</g:link></td>

			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.reportDate.label" default="Recorded Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${fixationReportInstance?.reportDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.reportStaff.label" default="Recorded By" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fixationReportInstance, field: "reportStaff")}</td>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.comments.label" default="Comments" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fixationReportInstance, field: "comments")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.fixationTypeAliquot.label" default="Fixation Type" /></td>
				
				<td valign="top" class="value">${fixationReportInstance?.fixationTypeAliquot?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.processingScheduleAliquot.label" default="Processing Schedule" /></td>
				
				<td valign="top" class="value">${fixationReportInstance?.processingScheduleAliquot?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.fixationStartDateAliquot.label" default="Fixation Start Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${fixationReportInstance?.fixationStartDateAliquot}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.fixationStartTimeAliquot.label" default="Fixation Start Time" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fixationReportInstance, field: "fixationStartTimeAliquot")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.fixationEndDateAliquot.label" default="Fixation End Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${fixationReportInstance?.fixationEndDateAliquot}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.fixationEndTimeAliquot.label" default="Fixation End Time" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fixationReportInstance, field: "fixationEndTimeAliquot")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.fixationPeriodAliquot.label" default="Fixation Period" /></td>
				
				<td valign="top" class="value">${fixationReportInstance?.fixationPeriodAliquot?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.fixationTimeUnknownAliquot.label" default="Fixation Time Unknown" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${fixationReportInstance?.fixationTimeUnknownAliquot}" false="No" true="Yes" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.fixationCommentsAliquot.label" default="Fixation Comments" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fixationReportInstance, field: "fixationCommentsAliquot")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.tissueProcessorUsed.label" default="Tissue Processor Used" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fixationReportInstance, field: "tissueProcessorUsed")}</td>
			</tr>

			<g:if test="${fixationReportInstance.aliquot.aliquotType.aliquotTypeName != 'Punch biopsy, PAXgene'}">
				<tr class="prop">
					<td valign="top" class="name"><g:message code="fixationReport.timeInProcessor.label" default="Time in formalin on processor (time in hours)" /></td>

					<td valign="top" class="value">${fieldValue(bean: fixationReportInstance, field: "timeInProcessor")}</td>

				</tr>
			</g:if>
		
		</tbody>
	</table>
</section>

</body>

</html>
