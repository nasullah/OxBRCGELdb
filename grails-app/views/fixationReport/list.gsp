
<%@ page import="geldb.FixationReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'fixationReport.label', default: 'Genomic Block Fixation Report')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-fixationReport" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>

				<g:sortableColumn property="reportDate" title="${message(code: 'fixationReport.reportDate.label', default: 'Recorded Date')}" />

				<th><g:message code="fixationReport.reportStaff.label" default="Recorded Staff" /></th>

				<th><g:message code="fixationReport.fixationTypeAliquot.label" default="Fixation Type" /></th>

				<g:sortableColumn property="aliquot.specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'aliquot.specimen.participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

			</tr>
		</thead>
		<tbody>
		<g:each in="${fixationReportInstanceList}" status="i" var="fixationReportInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

				<td><g:link action="show" id="${fixationReportInstance.id}">${fieldValue(bean: fixationReportInstance, field: "reportDate")}</g:link></td>

				<td>${fieldValue(bean: fixationReportInstance, field: "reportStaff")}</td>

				<td>${fieldValue(bean: fixationReportInstance, field: "fixationTypeAliquot")}</td>

				<td>${fieldValue(bean: fixationReportInstance.aliquot.specimen.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

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
