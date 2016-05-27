
<%@ page import="geldb.SampleTrackingEventType; geldb.Aliquot" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Aliquots awaiting to be dispatched to MDC </title>
</head>

<body>

<section id="index-aliquot" class="first">

    <table class="table table-bordered margin-top-medium">
        <thead>
        <tr>
            <g:sortableColumn property="aliquotType" title="${message(code: 'aliquot.aliquotType.label', default: 'Aliquot Type')}" />

            <g:sortableColumn property="aliquotRanking" title="${message(code: 'aliquot.aliquotRanking.label', default: 'Aliquot Ranking')}" />

            <g:sortableColumn property="blockNumber" title="${message(code: 'aliquot.blockNumber.label', default: 'Aliquot Identifier')}" />

            <g:sortableColumn property="barcode" title="${message(code: 'aliquot.barcode.label', default: 'Barcode')}" />

            <g:sortableColumn property="specimen.collectionDate" title="${message(code: 'aliquot.specimen.collectionDate.label', default: "Specimen Collection Date")}" />

            <g:sortableColumn property="specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'specimen.participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

            <th>Action</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${aliquotInstanceList}" status="i" var="aliquotInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${aliquotInstance.id}">${fieldValue(bean: aliquotInstance, field: "aliquotType")}</g:link></td>

                <td>${fieldValue(bean: aliquotInstance, field: "aliquotRanking")}</td>

                <g:if test="${aliquotInstance.blockNumber != null}">
                    <td>${fieldValue(bean: aliquotInstance, field: "blockNumber")}</td>
                </g:if>

                <g:else>
                    <td>${fieldValue(bean: aliquotInstance, field: "sapphireIdentifier")}</td>
                </g:else>

                <td>${fieldValue(bean: aliquotInstance, field: "barcode")}</td>

                <td><g:formatDate format="yyyy-MM-dd" date="${aliquotInstance.specimen.collectionDate}" /></td>

                <td>${fieldValue(bean: aliquotInstance.specimen.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

                <td><a class='btn btn-primary btn-xs' <g:link controller="sampleTrackingEvent" action="create" params="['identifiedSample.id': aliquotInstance?.id, 'sampleTrackingEventType.id':SampleTrackingEventType.findBySampleTrackingEventTypeName('Dispatch to MDC lab')?.id]"><i class="glyphicon glyphicon-send"></i> Dispatch to MDC</g:link></td>

            </tr>
        </g:each>
        </tbody>
    </table>

</section>

</body>

</html>