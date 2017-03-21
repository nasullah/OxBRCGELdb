
<%@ page import="geldb.FFPE_Tissue_Report" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'FFPE_Tissue_Report.label', default: 'Main Specimen Report')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>

<body>

<hr/>

<filterpane:filterButton text="Filter This List" />
<filterpane:filterPane domain="geldb.FFPE_Tissue_Report"
                       excludeProperties="reportDate, fixationStartDate, fixationStartTime, fixationEndDate, fixationEndTime, morphologySnomed, topographySnomed"
                       associatedProperties="solidSpecimen.participant.familyName, solidSpecimen.participant.givenName,
                                 solidSpecimen.participant.nHSNumber, solidSpecimen.participant.hospitalNumber,
                                 solidSpecimen.participant.diagnosis, solidSpecimen.participant.studySubject.studySubjectIdentifier, snomed.snomedCode"/>

<hr/>

<div class="container">
    <div class="text-warning text-center">
        <b>
            <filterpane:isFiltered>Filter applied!</filterpane:isFiltered>
            <filterpane:isNotFiltered>Not filtered!</filterpane:isNotFiltered>
        </b>
    </div>
</div>

<p>Number of records: ${FFPE_Tissue_ReportInstanceTotal == null ? FFPE_Tissue_Report.count(): FFPE_Tissue_ReportInstanceTotal}</p>

<section id="list-FFPE_Tissue_Report" class="first">

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
        <bs:paginate total="${FFPE_Tissue_ReportInstanceTotal == null ? FFPE_Tissue_Report.count(): FFPE_Tissue_ReportInstanceTotal}" params="${filterParams}" />
    </div>
</section>

</body>

</html>
