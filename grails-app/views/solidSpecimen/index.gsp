
<%@ page import="geldb.SolidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'solidSpecimen.label', default: 'Solid Specimen')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-solidSpecimen" class="first">

	<table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <g:sortableColumn property="sapphireIdentifier" title="${message(code: 'solidSpecimen.histologyNumber.label', default: 'Histology Number')}" />

            <g:sortableColumn property="passFail" title="${message(code: 'solidSpecimen.passFail.label', default: 'Pass Fail')}" />

            <g:sortableColumn property="passFailReason" title="${message(code: 'solidSpecimen.passFailReason.label', default: 'Pass Fail Reason')}" />

            <g:sortableColumn property="notes" title="${message(code: 'solidSpecimen.notes.label', default: 'Notes')}" />

            %{--<th><g:message code="solidSpecimen.participant.label" default="Participant" /></th>--}%

        </tr>
        </thead>
        <tbody>
        <g:each in="${solidSpecimenInstanceList}" status="i" var="solidSpecimenInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${solidSpecimenInstance.id}">${fieldValue(bean: solidSpecimenInstance, field: "histologyNumber")}</g:link></td>

                <td><g:formatBoolean boolean="${solidSpecimenInstance.passFail}" /></td>

                <td>${fieldValue(bean: solidSpecimenInstance, field: "passFailReason")}</td>

                <td>${fieldValue(bean: solidSpecimenInstance, field: "notes")}</td>

                %{--<td>${fieldValue(bean: solidSpecimenInstance, field: "participant")}</td>--}%

            </tr>
        </g:each>
        </tbody>
	</table>
	<div>
		<bs:paginate total="${solidSpecimenInstanceCount}" />
	</div>
</section>

</body>

</html>
