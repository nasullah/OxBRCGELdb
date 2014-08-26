
<%@ page import="geldb.VCFpath" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'VCFpath.label', default: 'VCF path')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-VCFpath" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="VCFpath.sequencingReports.label" default="Sequencing Reports" /></th>
			
				<g:sortableColumn property="vCFPath" title="${message(code: 'VCFpath.vCFPath.label', default: 'V CFP ath')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${VCFpathInstanceList}" status="i" var="VCFpathInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${VCFpathInstance.id}">${fieldValue(bean: VCFpathInstance, field: "sequencingReports")}</g:link></td>
			
				<td>${fieldValue(bean: VCFpathInstance, field: "vCFPath")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${VCFpathInstanceCount}" />
	</div>
</section>

</body>

</html>
