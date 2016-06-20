
<%@ page import="geldb.SolidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Awaiting MainSpecimen Reports</title>
</head>

<body>

<section id="list-solidSpecimen" class="first">

    <table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <g:sortableColumn property="sapphireIdentifier" title="${message(code: 'solidSpecimen.histologyNumber.label', default: 'Histology Number')}" />

            <g:sortableColumn property="anatomicalSite" title="${message(code: 'solidSpecimen.anatomicalSite.label', default: 'Anatomical Site')}" />

            <g:sortableColumn property="pathologist" title="${message(code: 'solidSpecimen.pathologist.label', default: 'Reporting Pathologist')}" />

            <g:sortableColumn property="participant.studySubject.studySubjectIdentifier" title="${message(code: 'participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

            <th>Summary Report</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${solidSpecimenInstanceList}" status="i" var="solidSpecimenInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${solidSpecimenInstance.id}">${fieldValue(bean: solidSpecimenInstance, field: "histologyNumber")}</g:link></td>

                <td>${fieldValue(bean: solidSpecimenInstance, field: "anatomicalSite")}</td>

                <td>${fieldValue(bean: solidSpecimenInstance, field: "pathologist")}</td>

                <td>${fieldValue(bean: solidSpecimenInstance.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

                <td><a class='btn btn-primary btn-xs' <g:link controller="FFPE_Tissue_Report" action="create" params="['solidSpecimen.id' : solidSpecimenInstance.id]"><i class="glyphicon glyphicon-plus"></i> Add Main Specimen Report</g:link></td>

            </tr>
        </g:each>
        </tbody>
    </table>
</section>


</body>

</html>
