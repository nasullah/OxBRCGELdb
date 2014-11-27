
<%@ page import="geldb.AliquotReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'aliquotReport.label', default: 'Aliquot Report')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-aliquotReport" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="reportDate" title="${message(code: 'aliquotReport.reportDate.label', default: 'Report Date')}" />
			
				<th><g:message code="aliquotReport.reportStaff.label" default="Report Staff" /></th>
			
				<g:sortableColumn property="comments" title="${message(code: 'aliquotReport.comments.label', default: 'Comments')}" />
			
				%{--<th><g:message code="aliquotReport.aliquot.label" default="Aliquot" /></th>--}%
			
				<g:sortableColumn property="percentageOfTumourInSample" title="${message(code: 'aliquotReport.percentageOfTumourInSample.label', default: 'Percentage Of Tumour In Sample')}" />
			
				<g:sortableColumn property="cellularity" title="${message(code: 'aliquotReport.cellularity.label', default: 'Cellularity')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${aliquotReportInstanceList}" status="i" var="aliquotReportInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${aliquotReportInstance.id}">${fieldValue(bean: aliquotReportInstance, field: "reportDate")}</g:link></td>
			
				<td>${fieldValue(bean: aliquotReportInstance, field: "reportStaff")}</td>
			
				<td>${fieldValue(bean: aliquotReportInstance, field: "comments")}</td>
			
				%{--<td>${fieldValue(bean: aliquotReportInstance, field: "aliquot")}</td>--}%
			
				<td>${fieldValue(bean: aliquotReportInstance, field: "percentageOfTumourInSample")}</td>
			
				<td>${fieldValue(bean: aliquotReportInstance, field: "cellularity")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${aliquotReportInstanceCount}" />
	</div>
</section>

</body>

</html>
