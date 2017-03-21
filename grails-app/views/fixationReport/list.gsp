
<%@ page import="geldb.FixationReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'fixationReport.label', default: 'Genomic Block Fixation Report')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
	<r:require module="filterpane" />
</head>

<body>

<hr/>

<filterpane:filterButton text="Filter This List" />
<filterpane:filterPane domain="geldb.FixationReport"
					   excludeProperties="reportDate, fixationStartDateAliquot, fixationStartTimeAliquot, fixationEndDateAliquot, fixationEndTimeAliquot"
					   associatedProperties="aliquot.specimen.participant.familyName, aliquot.specimen.participant.givenName,
								 aliquot.specimen.participant.nHSNumber, aliquot.specimen.participant.hospitalNumber,
								 aliquot.specimen.participant.diagnosis, aliquot.specimen.participant.studySubject.studySubjectIdentifier"/>

<hr/>

<div class="container">
	<div class="text-warning text-center">
		<b>
			<filterpane:isFiltered>Filter applied!</filterpane:isFiltered>
			<filterpane:isNotFiltered>Not filtered!</filterpane:isNotFiltered>
		</b>
	</div>
</div>

<p>Number of records: ${fixationReportInstanceTotal == null ? FixationReport.count(): fixationReportInstanceTotal}</p>

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
	<div class="pagination">
		<bs:paginate total="${fixationReportInstanceTotal == null ? FixationReport.count(): fixationReportInstanceTotal}" params="${filterParams}" />
	</div>
</section>

</body>

</html>
