
<%@ page import="geldb.Participant" %>
<%@ page import="geldb.PrimarySampleType" %>
<%@ page import="geldb.FluidSpecimen" %>
<%@ page import="geldb.FluidSampleType" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'participant.label', default: 'Participant')}" />
    <title>Awaiting Blood Sample</title>

</head>

<body>

<section id="list-participant" class="first">

    <table class="table table-bordered margin-top-medium">
        <thead>
        <tr>
            <g:sortableColumn property="hospitalNumber" title="${message(code: 'participant.hospitalNumber.label', default: 'Hospital Number')}" />

            <g:sortableColumn property="familyName" title="${message(code: 'participant.familyName.label', default: 'Family Name')}" />

            <g:sortableColumn property="givenName" title="${message(code: 'participant.givenName.label', default: 'Given Name')}" />

            <g:sortableColumn property="studySubject.studySubjectIdentifier" title="${message(code: 'studySubject.studySubjectIdentifier.label', default: 'GeL Id/Participant Id')}" />

            <th><g:message code="specimen.label" default="Action" /></th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${participantList}" status="i" var="participantInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${participantInstance.id}">${fieldValue(bean: participantInstance, field: "hospitalNumber")}</g:link></td>

                <td>${fieldValue(bean: participantInstance, field: "familyName")}</td>

                <td>${fieldValue(bean: participantInstance, field: "givenName")}</td>

                <td>${fieldValue(bean: participantInstance.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

                <td><a class='btn btn-primary btn-xs' <g:link controller="fluidSpecimen" action="create" params="['participant.id': participantInstance?.id, 'fluidSampleType':'Blood_whole_BLD']"><i class="glyphicon glyphicon-plus"></i> Add Blood</g:link></td>

            </tr>
        </g:each>
        </tbody>
    </table>

</section>

</body>

</html>