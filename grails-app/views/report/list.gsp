
<%@ page import="geldb.Report" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'report.label', default: 'Report')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-report" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="reportDate" title="${message(code: 'report.reportDate.label', default: 'Report Date')}" />
			
				<th><g:message code="report.reportStaff.label" default="Report Staff" /></th>
			
				<g:sortableColumn property="comments" title="${message(code: 'report.comments.label', default: 'Comments')}" />
			
				<th><g:message code="report.derivation.label" default="Derivation" /></th>
			
				<th><g:message code="report.specimen.label" default="Specimen" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${reportInstanceList}" status="i" var="reportInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${reportInstance.id}">${fieldValue(bean: reportInstance, field: "reportDate")}</g:link></td>
			
				<td>${fieldValue(bean: reportInstance, field: "reportStaff")}</td>
			
				<td>${fieldValue(bean: reportInstance, field: "comments")}</td>
			
				<td>${fieldValue(bean: reportInstance, field: "derivation")}</td>
			
				<td>${fieldValue(bean: reportInstance, field: "specimen")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${reportInstanceCount}" />
	</div>
</section>

</body>

</html>
