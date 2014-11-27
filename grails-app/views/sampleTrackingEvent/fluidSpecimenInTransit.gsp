<%@ page import="geldb.FluidSpecimen" %>
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

            <g:sortableColumn property="fluidSampleType" title="${message(code: 'fluidSpecimen.fluidSampleType.label', default: 'Fluid Sample Type')}" />

            <g:sortableColumn property="collectionDate" title="${message(code: 'fluidSpecimen.collectionDate.label', default: 'Collection Date')}" />

            <g:sortableColumn property="fluidSpecimen.collectionLocation.centre" title="${message(code: 'fluidSpecimen.collectionLocation.centre.label', default: "Centre")}" />

            <g:sortableColumn property="fluidSpecimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'fluidSpecimen.participant.studySubject.studySubjectIdentifier.label', default: "Participant's GeL Id")}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${fluidSpecimenInTransit}" status="i" var="fluidSpecimenInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${fluidSpecimenInstance.id}">${fieldValue(bean: fluidSpecimenInstance, field: "fluidSampleType")}</g:link></td>

                <td><g:formatDate format="yyyy-MM-dd" date="${fluidSpecimenInstance?.collectionDate}" /></td>

                <td>${fieldValue(bean: fluidSpecimenInstance?.collectionLocation?.centre, field: "centreName").toString().replace('[', '').replace(']','')}</td>

                <td>${fieldValue(bean: fluidSpecimenInstance?.participant?.studySubject, field: "studySubjectIdentifier").toString().replace('[', '').replace(']','')}</td>

            </tr>
        </g:each>
        </tbody>
    </table>

</section>

</body>

</html>