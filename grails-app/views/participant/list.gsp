
<%@ page import="geldb.Participant" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'participant.label', default: 'Participant')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>

<body>

<section id="list-participant" class="first">

	<table class="table table-bordered margin-top-medium">
        <thead>
        <tr>
            <g:sortableColumn property="hospitalNumber" title="${message(code: 'participant.hospitalNumber.label', default: 'Hospital Number')}" />

            <g:sortableColumn property="familyName" title="${message(code: 'participant.familyName.label', default: 'Family Name')}" />

            <g:sortableColumn property="givenName" title="${message(code: 'participant.givenName.label', default: 'Given Name')}" />

            <g:sortableColumn property="centre" title="${message(code: 'participant.centre.label', default: 'Centre')}" />

            <g:sortableColumn property="participant.studySubject.studySubjectIdentifier" title="${message(code: 'participant.studySubject.studySubjectIdentifier.label', default: 'GeL Id')}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${participantInstanceList}" status="i" var="participantInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${participantInstance.id}">${fieldValue(bean: participantInstance, field: "hospitalNumber")}</g:link></td>

                <td>${fieldValue(bean: participantInstance, field: "familyName")}</td>

                <td>${fieldValue(bean: participantInstance, field: "givenName")}</td>

                <td>${fieldValue(bean: participantInstance, field: "centre")}</td>

                <td>${fieldValue(bean: participantInstance.studySubject, field: "studySubjectIdentifier").toString().replace('[', '').replace(']','')}</td>

            </tr>
        </g:each>
		</tbody>
	</table>
    <div>
        <g:paginate total="${participantInstanceTotal == null ? Participant.count(): participantInstanceTotal}" params="${filterParams}" />
        <filterpane:filterButton text="Filter This List" />
    </div>
</section>
<filterpane:filterPane domain="geldb.Participant"
                       excludeProperties="dateOfBirth"
                       associatedProperties="studySubject.studySubjectIdentifier"/>
<hr style="border:1; height:1px" />
</body>

</html>
