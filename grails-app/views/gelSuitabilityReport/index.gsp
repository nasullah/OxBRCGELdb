
<%@ page import="geldb.GelSuitabilityReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'gelSuitabilityReport.label', default: 'GeL Suitability Report')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>

<body>

<hr/>

<filterpane:filterButton text="Filter This List" />
<filterpane:filterPane domain="geldb.GelSuitabilityReport"
					   excludeProperties="reportDate, sideMarkedDate, slideScannedOn, handEcarriedOutOn"
					   associatedProperties="aliquot.specimen.participant.familyName, aliquot.specimen.participant.givenName,
                                 aliquot.specimen.participant.nHSNumber, aliquot.specimen.participant.hospitalNumber,
                                 aliquot.specimen.participant.diagnosis, aliquot.specimen.participant.studySubject.studySubjectIdentifier"/>

<hr/>

<a>Number of records: ${gelSuitabilityReportInstanceTotal == null ? GelSuitabilityReport.count(): gelSuitabilityReportInstanceTotal}</a>

<section id="index-gelSuitabilityReport" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="reportDate" title="${message(code: 'gelSuitabilityReport.reportDate.label', default: 'Report Date')}" />
			
				<th><g:message code="gelSuitabilityReport.reportStaff.label" default="Report Staff" /></th>

				<g:sortableColumn property="handE_pathreview" title="${message(code: 'gelSuitabilityReport.handE_pathreview.label', default: 'H and E path review')}" />
			
				<g:sortableColumn property="slideMarkedBy" title="${message(code: 'gelSuitabilityReport.slideMarkedBy.label', default: 'Slide Marked By')}" />

                <g:sortableColumn property="aliquot.specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'aliquot.specimen.participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${gelSuitabilityReportInstanceList}" status="i" var="gelSuitabilityReportInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${gelSuitabilityReportInstance.id}">${fieldValue(bean: gelSuitabilityReportInstance, field: "reportDate")}</g:link></td>
			
				<td>${fieldValue(bean: gelSuitabilityReportInstance, field: "reportStaff")}</td>

				<td><g:formatBoolean boolean="${gelSuitabilityReportInstance.handE_pathreview}" true="Yes" false="No" /></td>
			
				<td>${fieldValue(bean: gelSuitabilityReportInstance, field: "slideMarkedBy")}</td>

                <td>${fieldValue(bean: gelSuitabilityReportInstance.aliquot.specimen.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div class="pagination">
		<bs:paginate total="${gelSuitabilityReportInstanceTotal == null ? GelSuitabilityReport.count(): gelSuitabilityReportInstanceTotal}" params="${filterParams}" />
	</div>
</section>

</body>

</html>
