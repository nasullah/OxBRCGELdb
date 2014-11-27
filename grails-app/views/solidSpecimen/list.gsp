
<%@ page import="geldb.SolidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'solidSpecimen.label', default: 'Solid Specimen')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>

<body>

<section id="list-solidSpecimen" class="first">

	<table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <g:sortableColumn property="sapphireIdentifier" title="${message(code: 'solidSpecimen.histologyNumber.label', default: 'Histology Number')}" />

            <g:sortableColumn property="passFail" title="${message(code: 'solidSpecimen.passFail.label', default: 'Pass Fail')}" />

            <g:sortableColumn property="passFailReason" title="${message(code: 'solidSpecimen.passFailReason.label', default: 'Pass Fail Reason')}" />

            <g:sortableColumn property="solidSpecimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'solidSpecimen.participant.studySubject.studySubjectIdentifier.label', default: "Participant's GeL Id")}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${solidSpecimenInstanceList}" status="i" var="solidSpecimenInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${solidSpecimenInstance.id}">${fieldValue(bean: solidSpecimenInstance, field: "histologyNumber")}</g:link></td>

                <td><g:formatBoolean boolean="${solidSpecimenInstance.passFail}" /></td>

                <td>${fieldValue(bean: solidSpecimenInstance, field: "passFailReason")}</td>

                <td>${fieldValue(bean: solidSpecimenInstance.participant.studySubject, field: "studySubjectIdentifier").toString().replace('[', '').replace(']','')}</td>

            </tr>
        </g:each>
        </tbody>
	</table>
    <div>
        <g:paginate total="${solidSpecimenInstanceTotal == null ? SolidSpecimen.count(): solidSpecimenInstanceTotal}" params="${filterParams}" />
        <filterpane:filterButton text="Filter This List" />
    </div>
</section>
<filterpane:filterPane domain="geldb.SolidSpecimen"
                       excludeProperties="vasculerClampingTimeAtSurgery, collectionDate"
                       associatedProperties="participant.familyName,participant.givenName,
                                             participant.nHSNumber,participant.hospitalNumber,
                                             participant.diagnosis, participant.studySubject.studySubjectIdentifier"/>
<hr style="border:1; height:1px" />

</body>

</html>
