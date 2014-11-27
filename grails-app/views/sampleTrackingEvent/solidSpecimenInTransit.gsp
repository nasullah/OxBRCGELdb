
<%@ page import="geldb.SampleTrackingEvent" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'sampleTrackingEvent.label', default: 'Sample')}" />
    <title>List of Samples in Transit</title>
</head>

<body>

<section id="index-sampleTrackingEvent" class="first">

    <table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <g:sortableColumn property="sapphireIdentifier" title="${message(code: 'solidSpecimen.histologyNumber.label', default: 'Sample Number')}" />

            <g:sortableColumn property="collectionDate" title="${message(code: 'fluidSpecimen.collectionDate.label', default: 'Collection Date')}" />

            <g:sortableColumn property="collectionLocation.centre" title="${message(code: 'collectionLocation.centre.label', default: 'Centre')}" />

            <g:sortableColumn property="participant.studySubject.studySubjectIdentifier" title="${message(code: 'participant.studySubject.studySubjectIdentifier.label', default: "Participant's GeL Id")}" />


        </tr>
        </thead>
        <tbody>
        <g:each in="${solidSpecimenInTransit}" status="i" var="solidSpecimenInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${solidSpecimenInstance.id}">${fieldValue(bean: solidSpecimenInstance, field: "histologyNumber")}</g:link></td>

                <td><g:formatDate format="yyyy-MM-dd" date="${solidSpecimenInstance.collectionDate}" /></td>

                <td>${fieldValue(bean: solidSpecimenInstance?.collectionLocation?.centre, field: "centreName").toString().replace('[', '').replace(']','')}</td>

                <td>${fieldValue(bean: solidSpecimenInstance?.participant?.studySubject, field: "studySubjectIdentifier").toString().replace('[', '').replace(']','')}</td>


            </tr>
        </g:each>
        </tbody>
    </table>

</section>

</body>

</html>