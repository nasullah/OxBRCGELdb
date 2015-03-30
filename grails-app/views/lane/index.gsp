
<%@ page import="geldb.Lane" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'lane.label', default: 'Lane')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-lane" class="first">

	<table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <th><g:message code="lane.flowCell.label" default="Flow Cell" /></th>

            <g:sortableColumn property="laneNumber" title="${message(code: 'lane.laneNumber.label', default: 'Lane Number')}" />

            <g:sortableColumn property="loadedLibrary.na_extract.aliquot.specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'loadedLibrary.na_extract.aliquot.specimen.participant.studySubject.studySubjectIdentifier.label', default: "Participant's GeL Id")}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${laneInstanceList}" status="i" var="laneInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${laneInstance.id}">${fieldValue(bean: laneInstance, field: "flowCell")}</g:link></td>

                <td>${fieldValue(bean: laneInstance, field: "laneNumber")}</td>

                <% def gelId = laneInstance.loadedLibrary.na_extract.aliquot.specimen.participant.studySubject %>
                <g:each in="${1..3}" >
                    <% gelId = gelId.first()%>
                </g:each>
                <% gelId =gelId.findResult {it.studySubjectIdentifier ? it : null}%>

                <td>${fieldValue(bean: gelId, field: "studySubjectIdentifier")}</td>
            </tr>
        </g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${laneInstanceCount}" />
	</div>
</section>

</body>

</html>
