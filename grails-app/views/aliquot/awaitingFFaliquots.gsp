
<%@ page import="geldb.AliquotType; geldb.SolidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Awaiting FF aliquots</title>
</head>

<body>

<section id="list-solidSpecimen" class="first">

    <table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <g:sortableColumn property="sapphireIdentifier" title="${message(code: 'solidSpecimen.histologyNumber.label', default: 'Histology Number')}" />

            <g:sortableColumn property="anatomicalSite" title="${message(code: 'solidSpecimen.anatomicalSite.label', default: 'Anatomical Site')}" />

            <g:sortableColumn property="pathologist" title="${message(code: 'solidSpecimen.pathologist.label', default: 'Reporting Pathologist')}" />

            <g:sortableColumn property="noFFSampleExpected" title="${message(code: 'solidSpecimen.noFFSampleExpected.label', default: 'No associated FF sample expected')}" />

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

                <td>
                    <g:form controller="aliquot" action="awaitingFFaliquots">
                        <g:checkBox name="noFFSampleExpected" value="${solidSpecimenInstance?.noFFSampleExpected}" onclick="submit();"/>
                        <g:hiddenField id="solidSpecimen" name="solidSpecimen" value="${solidSpecimenInstance.id}"/>
                    </g:form>
                </td>

                <td>${fieldValue(bean: solidSpecimenInstance.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

                <td><a class='btn btn-primary btn-xs' <g:link controller="aliquot" action="create" params="['specimen.id': solidSpecimenInstance?.id, 'aliquotType':geldb.AliquotType?.findByAliquotTypeName('Punch Biopsy Frozen')?.id, 'createdOn':solidSpecimenInstance?.collectionDate]"><i class="glyphicon glyphicon-plus"></i> Add FF Aliquot</g:link></td>

            </tr>
        </g:each>
        </tbody>
    </table>
</section>


</body>

</html>