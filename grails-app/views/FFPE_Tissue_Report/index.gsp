
<%@ page import="geldb.FFPE_Tissue_Report" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'FFPE_Tissue_Report.label', default: 'Main Specimen Report')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>

<body>

<div style="background: rgba(80, 110, 56, 0.04);">
    <div class="container">
        <p>
        <h5 class="text-center">Search Options</h5>
        <p>
            <filterpane:filterButton text="Filter This List" />
            <filterpane:filterPane domain="geldb.FFPE_Tissue_Report"
                                   excludeProperties="reportDate, fixationStartDate, fixationStartTime, fixationEndDate, fixationEndTime, morphologySnomed, topographySnomed"
                                   associatedProperties="solidSpecimen.participant.familyName, solidSpecimen.participant.givenName,
                                             solidSpecimen.participant.nHSNumber, solidSpecimen.participant.hospitalNumber,
                                             solidSpecimen.participant.diagnosis, solidSpecimen.participant.studySubject.studySubjectIdentifier, snomed.snomedCode"/>
        <p>
        <p>
    </div>
</div>

<hr style="border:1; height:1px" />

<section id="index-FFPE_Tissue_Report" class="first">

	<table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <g:sortableColumn property="reportDate" title="${message(code: 'FFPE_Tissue_Report.reportDate.label', default: 'Report Date')}" />

            <th><g:message code="FFPE_Tissue_Report.reportStaff.label" default="Report Staff" /></th>

            <th><g:message code="FFPE_Tissue_Report.sampleType.label" default="Sample Type" /></th>

            <g:sortableColumn property="stagingSystem" title="${message(code: 'FFPE_Tissue_Report.stagingSystem.label', default: 'Staging System')}" />

            <g:sortableColumn property="solidSpecimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'solidSpecimen.participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${FFPE_Tissue_ReportInstanceList}" status="i" var="FFPE_Tissue_ReportInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${FFPE_Tissue_ReportInstance.id}">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "reportDate")}</g:link></td>

                <td>${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "reportStaff")}</td>

                <td>${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "sampleType")}</td>

                <td>${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "stagingSystem")}</td>

                <td>${fieldValue(bean: FFPE_Tissue_ReportInstance.solidSpecimen.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

            </tr>
        </g:each>
		</tbody>
	</table>
    <div class="pagination">
        <g:paginate total="${FFPE_Tissue_ReportInstanceTotal == null ? FFPE_Tissue_Report.count(): FFPE_Tissue_ReportInstanceTotal}" params="${filterParams}" />
        <a>Number of records: ${FFPE_Tissue_ReportInstanceTotal == null ? FFPE_Tissue_Report.count(): FFPE_Tissue_ReportInstanceTotal}</a>
    </div>
</section>

</body>

</html>
