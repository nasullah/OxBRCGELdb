
<%@ page import="geldb.SequencingReports" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'sequencingReports.label', default: 'Sequencing Reports')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-sequencingReports" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="sequencingReports.sequencingRun.label" default="Sequencing Run" /></th>
			
				<g:sortableColumn property="bAMpath" title="${message(code: 'sequencingReports.bAMpath.label', default: 'B AM path')}" />
			
				<g:sortableColumn property="reportPath" title="${message(code: 'sequencingReports.reportPath.label', default: 'Report Path')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${sequencingReportsInstanceList}" status="i" var="sequencingReportsInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${sequencingReportsInstance.id}">${fieldValue(bean: sequencingReportsInstance, field: "sequencingRun")}</g:link></td>
			
				<td>${fieldValue(bean: sequencingReportsInstance, field: "bAMpath")}</td>
			
				<td>${fieldValue(bean: sequencingReportsInstance, field: "reportPath")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${sequencingReportsInstanceCount}" />
	</div>
</section>

</body>

</html>
