
<%@ page import="geldb.Aliquot" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'aliquot.label', default: 'Available Aliquots')}" />
    <title><g:message code="default.index.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>

<body>

<p>
<p>
    <filterpane:filterButton text="Filter This List" />
    <filterpane:filterPane domain="geldb.Aliquot"
                           associatedProperties="specimen.participant.familyName, specimen.participant.familyName, specimen.participant.diagnosis,
                                             specimen.participant.hospitalNumber, specimen.participant.nHSNumber,
                                             specimen.participant.studySubject.studySubjectIdentifier"/>
<hr style="border:1; height:1px" />

<section id="index-aliquot" class="first">

    <table class="table table-bordered margin-top-medium">
        <thead>
        <tr>
            <g:sortableColumn property="aliquotType" title="${message(code: 'aliquot.aliquotType.label', default: 'Aliquot Type')}" />

            <g:sortableColumn property="blockNumber" title="${message(code: 'aliquot.blockNumber.label', default: 'Aliquot Identifier')}" />

            <g:sortableColumn property="specimen.timePoint" title="${message(code: 'aliquot.specimen.timePoint.label', default: 'Time Point')}" />

            <g:sortableColumn property="aliquotRanking" title="${message(code: 'aliquot.aliquotRanking.label', default: 'Aliquot Ranking')}" />

            <g:sortableColumn property="specimen.collectionDate" title="${message(code: 'aliquot.specimen.collectionDate.label', default: "Specimen Collection Date")}" />

            <g:sortableColumn property="specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'specimen.participant.studySubject.studySubjectIdentifier.label', default: "Participant's GeL Id")}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${aliquotInstanceList}" status="i" var="aliquotInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${aliquotInstance.id}">${fieldValue(bean: aliquotInstance, field: "aliquotType")}</g:link></td>

                <g:if test="${aliquotInstance.blockNumber != null}">
                    <td>${fieldValue(bean: aliquotInstance, field: "blockNumber")}</td>
                </g:if>

                <g:else>
                    <td>${fieldValue(bean: aliquotInstance, field: "sapphireIdentifier")}</td>
                </g:else>

                <g:if test="${geldb.SolidSpecimen.find {aliquot.id == aliquotInstance.id }}">
                    <td></td>
                </g:if>

                <g:else>
                    <td>${fieldValue(bean: aliquotInstance?.specimen, field: "timePoint")}</td>
                </g:else>

                <td>${fieldValue(bean: aliquotInstance, field: "aliquotRanking")}</td>

                <td><g:formatDate format="yyyy-MM-dd" date="${aliquotInstance.specimen.collectionDate}" /></td>

                <td>${fieldValue(bean: aliquotInstance.specimen.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <div>
        <bs:paginate total="${aliquotInstanceCount}" />
    </div>
</section>

</body>

</html>
