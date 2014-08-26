
<%@ page import="geldb.SolidSpecimenReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'solidSpecimenReport.label', default: 'Solid Specimen Report')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-solidSpecimenReport" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="solidSpecimenReport.derivation.label" default="Derivation" /></th>
			
				<th><g:message code="solidSpecimenReport.specimen.label" default="Specimen" /></th>
			
				<g:sortableColumn property="reportDate" title="${message(code: 'solidSpecimenReport.reportDate.label', default: 'Report Date')}" />
			
				<th><g:message code="solidSpecimenReport.reportStaff.label" default="Report Staff" /></th>
			
				<g:sortableColumn property="comments" title="${message(code: 'solidSpecimenReport.comments.label', default: 'Comments')}" />
			
				<g:sortableColumn property="sampleSitePhoto" title="${message(code: 'solidSpecimenReport.sampleSitePhoto.label', default: 'Sample Site Photo')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${solidSpecimenReportInstanceList}" status="i" var="solidSpecimenReportInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${solidSpecimenReportInstance.id}">${fieldValue(bean: solidSpecimenReportInstance, field: "derivation")}</g:link></td>
			
				<td>${fieldValue(bean: solidSpecimenReportInstance, field: "specimen")}</td>
			
				<td><g:formatDate date="${solidSpecimenReportInstance.reportDate}" /></td>
			
				<td>${fieldValue(bean: solidSpecimenReportInstance, field: "reportStaff")}</td>
			
				<td>${fieldValue(bean: solidSpecimenReportInstance, field: "comments")}</td>
			
				<td>${fieldValue(bean: solidSpecimenReportInstance, field: "sampleSitePhoto")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${solidSpecimenReportInstanceCount}" />
	</div>
</section>

</body>

</html>
