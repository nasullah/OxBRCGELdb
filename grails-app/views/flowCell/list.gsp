
<%@ page import="geldb.FlowCell" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'flowCell.label', default: 'Flow Cell')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-flowCell" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="flowCell.sequencingRun.label" default="Sequencing Run" /></th>
			
				<g:sortableColumn property="libraryLoadingConcentration" title="${message(code: 'flowCell.libraryLoadingConcentration.label', default: 'Library Loading Concentration')}" />
			
				<g:sortableColumn property="clusterDensity" title="${message(code: 'flowCell.clusterDensity.label', default: 'Cluster Density')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${flowCellInstanceList}" status="i" var="flowCellInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${flowCellInstance.id}">${fieldValue(bean: flowCellInstance, field: "sequencingRun")}</g:link></td>
			
				<td>${fieldValue(bean: flowCellInstance, field: "libraryLoadingConcentration")}</td>
			
				<td>${fieldValue(bean: flowCellInstance, field: "clusterDensity")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${flowCellInstanceCount}" />
	</div>
</section>

</body>

</html>
