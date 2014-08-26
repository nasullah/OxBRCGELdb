
<%@ page import="geldb.SequencingRun" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'sequencingRun.label', default: 'Sequencing Run')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-sequencingRun" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="runDate" title="${message(code: 'sequencingRun.runDate.label', default: 'Run Date')}" />
			
				<g:sortableColumn property="machineName" title="${message(code: 'sequencingRun.machineName.label', default: 'Machine Name')}" />
			
				<th><g:message code="sequencingRun.sequencingReports.label" default="Sequencing Reports" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${sequencingRunInstanceList}" status="i" var="sequencingRunInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${sequencingRunInstance.id}">${fieldValue(bean: sequencingRunInstance, field: "runDate")}</g:link></td>
			
				<td>${fieldValue(bean: sequencingRunInstance, field: "machineName")}</td>
			
				<td>${fieldValue(bean: sequencingRunInstance, field: "sequencingReports")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${sequencingRunInstanceCount}" />
	</div>
</section>

</body>

</html>
