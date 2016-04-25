
<%@ page import="geldb.DNA_Extract" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Reserved DNA Samples List</title>
</head>

<body>

<section id="list-DNA_Extract" class="first">

    <table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <g:sortableColumn property="extractionType" title="${message(code: 'DNA_Extract.extractionType.label', default: 'Extraction Type')}" />

            <g:sortableColumn property="extractionDate" title="${message(code: 'DNA_Extract.extractionDate.label', default: 'Extraction Date')}" />

            <g:sortableColumn property="sapphireIdentifier" title="${message(code: 'DNA_Extract.sapphireIdentifier.label', default: 'DNA/RNA Elution')}" />

            <g:sortableColumn property="passFail" title="${message(code: 'DNA_Extract.passFail.label', default: 'Pass Fail')}" />

            <g:sortableColumn property="aliquot.specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'aliquot.specimen.participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

            <th>Summary Report</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${DNA_ExtractInstanceList}" status="i" var="DNA_ExtractInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${DNA_ExtractInstance.id}">${fieldValue(bean: DNA_ExtractInstance, field: "extractionType")}</g:link></td>

                <td><g:formatDate format="yyyy-MM-dd" date="${DNA_ExtractInstance?.extractionDate}" /></td>

                <td>${fieldValue(bean: DNA_ExtractInstance, field: "sapphireIdentifier")}</td>

                <td><g:formatBoolean boolean="${DNA_ExtractInstance.passFail}" true="Pass" false="Fail" /></td>

                <% def gelId = DNA_ExtractInstance.aliquot.specimen.participant.studySubject %>
                <% gelId = gelId.first()%>
                <% gelId =gelId.findResult {it.studySubjectIdentifier ? it : null}%>

                <td>${fieldValue(bean: gelId, field: "studySubjectIdentifier")}</td>

                <g:if test="${gelId}">
                    <td><a class='btn btn-primary btn-xs' <g:link controller="participant" action="summaryReport" params="[gelStudyId : gelId.studySubjectIdentifier]"><i class="glyphicon glyphicon-info-sign"></i> View Summary Report</g:link></td>
                </g:if>
                <g:else>
                    <td></td>
                </g:else>

            </tr>
        </g:each>
        </tbody>
    </table>
</section>

</body>

</html>
