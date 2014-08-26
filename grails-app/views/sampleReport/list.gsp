
<%@ page import="geldb.SampleReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'sampleReport.label', default: 'Sample Report')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-sampleReport" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="reportDate" title="${message(code: 'sampleReport.reportDate.label', default: 'Report Date')}" />
			
				<g:sortableColumn property="reportStaff" title="${message(code: 'sampleReport.reportStaff.label', default: 'Report Staff')}" />
			
				<g:sortableColumn property="comments" title="${message(code: 'sampleReport.comments.label', default: 'Comments')}" />
			
				<th><g:message code="sampleReport.aliquot.label" default="Aliquot" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${sampleReportInstanceList}" status="i" var="sampleReportInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${sampleReportInstance.id}">${fieldValue(bean: sampleReportInstance, field: "reportDate")}</g:link></td>
			
				<td>${fieldValue(bean: sampleReportInstance, field: "reportStaff")}</td>
			
				<td>${fieldValue(bean: sampleReportInstance, field: "comments")}</td>
			
				<td>${fieldValue(bean: sampleReportInstance, field: "aliquot")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${sampleReportInstanceCount}" />
	</div>
</section>

</body>

</html>
