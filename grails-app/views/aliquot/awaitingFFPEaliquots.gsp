
<%@ page import="geldb.SolidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Awaiting FFPE aliquots</title>
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

            <th><g:message code="specimen.label" default="Action" /></th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${solidSpecimenInstanceList}" status="i" var="solidSpecimenInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link controller="solidSpecimen" action="show" id="${solidSpecimenInstance.id}">${fieldValue(bean: solidSpecimenInstance, field: "histologyNumber")}</g:link></td>

                <td>${fieldValue(bean: solidSpecimenInstance, field: "anatomicalSite")}</td>

                <td>${fieldValue(bean: solidSpecimenInstance, field: "pathologist")}</td>

                <td>${fieldValue(bean: solidSpecimenInstance.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

                <td><a class='btn btn-primary btn-xs' <g:link controller="aliquot" action="create" params="['specimen.id': solidSpecimenInstance?.id, 'aliquotType':geldb.AliquotType?.findByAliquotTypeName('Punch Biopsy FFPE, NBF')?.id]"><i class="glyphicon glyphicon-plus"></i> Add FFPE Aliquot</g:link></td>

            </tr>
        </g:each>
        </tbody>
    </table>
</section>


</body>

</html>