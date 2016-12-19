
<%@ page import="geldb.SampleTrackingEvent; geldb.SampleTrackingEventType; geldb.Aliquot" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Aliquots Pending To Be Extracted</title>
</head>

<body>

<section id="index-aliquot" class="first">

    <table class="table table-bordered margin-top-medium">
        <thead>
        <tr>
            <g:sortableColumn property="aliquotType" title="${message(code: 'aliquot.aliquotType.label', default: 'Aliquot Type')}" />

            <g:sortableColumn property="aliquotVolumeMass" title="${message(code: 'aliquot.aliquotVolumeMass.label', default: 'Aliquot Mass')}" />

            <g:sortableColumn property="barcode" title="${message(code: 'aliquot.barcode.label', default: 'Barcode')}" />

            <th>Received Date In Lab</th>

            <g:sortableColumn property="specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'specimen.participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${aliquotInstanceList}" status="i" var="aliquotInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link controller="aliquot" action="show" id="${aliquotInstance.id}">${fieldValue(bean: aliquotInstance, field: "aliquotType")}</g:link></td>

                <td>${fieldValue(bean: aliquotInstance, field: "aliquotVolumeMass")}</td>

                <td>${fieldValue(bean: aliquotInstance, field: "barcode")}</td>

                <td><g:formatDate format="yyyy-MM-dd" date="${SampleTrackingEvent.findBySampleTrackingEventTypeAndIdentifiedSample(SampleTrackingEventType.findBySampleTrackingEventTypeName('Received at MDC lab'), aliquotInstance)?.date}" /></td>

                <td>${fieldValue(bean: aliquotInstance.specimen.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

            </tr>
        </g:each>
        </tbody>
    </table>

</section>

</body>

</html>