
<%@ page import="geldb.FixationReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'fixationReport.label', default: 'Fixation Report')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-fixationReport" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="reportDate" title="${message(code: 'fixationReport.reportDate.label', default: 'Report Date')}" />
			
				<th><g:message code="fixationReport.reportStaff.label" default="Report Staff" /></th>
			
				<g:sortableColumn property="comments" title="${message(code: 'fixationReport.comments.label', default: 'Comments')}" />
			
				<g:sortableColumn property="fixationType" title="${message(code: 'fixationReport.fixationType.label', default: 'Fixation Type')}" />
			
				<g:sortableColumn property="fixationStartDate" title="${message(code: 'fixationReport.fixationStartDate.label', default: 'Fixation Start Date')}" />
			
				<g:sortableColumn property="fixationStartTime" title="${message(code: 'fixationReport.fixationStartTime.label', default: 'Fixation Start Time')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${fixationReportInstanceList}" status="i" var="fixationReportInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${fixationReportInstance.id}">${fieldValue(bean: fixationReportInstance, field: "reportDate")}</g:link></td>
			
				<td>${fieldValue(bean: fixationReportInstance, field: "reportStaff")}</td>
			
				<td>${fieldValue(bean: fixationReportInstance, field: "comments")}</td>
			
				<td>${fieldValue(bean: fixationReportInstance, field: "fixationType")}</td>
			
				<td><g:formatDate date="${fixationReportInstance.fixationStartDate}" /></td>
			
				<td>${fieldValue(bean: fixationReportInstance, field: "fixationStartTime")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${fixationReportInstanceCount}" />
	</div>
</section>

</body>

</html>
