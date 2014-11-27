
<%@ page import="geldb.Participant" %>
<%@ page import="geldb.PrimarySampleType" %>
<%@ page import="geldb.FluidSpecimen" %>
<%@ page import="geldb.FluidSampleType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'participant.label', default: 'Participant')}" />
	<title>Follow up Blood Sample Required</title>

</head>

<body>

<section id="list-participant" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="familyName" title="${message(code: 'participant.familyName.label', default: 'Family Name')}" />
			
				<g:sortableColumn property="givenName" title="${message(code: 'participant.givenName.label', default: 'Given Name')}" />

				<g:sortableColumn property="nHSNumber" title="${message(code: 'participant.nHSNumber.label', default: 'NHS Number')}" />

                <g:sortableColumn property="participant.studySubject.studySubjectIdentifier" title="${message(code: 'participant.studySubject.studySubjectIdentifier.label', default: 'GeL Id')}" />

                <g:sortableColumn property="specimen" title="${message(code: 'participant.specimen.label', default: 'Follow up Blood')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${participantList}" status="i" var="participantInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                        <td><g:link action="show" id="${participantInstance.id}">${fieldValue(bean: participantInstance, field: "familyName")}</g:link></td>

                        <td>${fieldValue(bean: participantInstance, field: "givenName")}</td>

                        <td>${fieldValue(bean: participantInstance, field: "nHSNumber")}</td>

                        <td>${fieldValue(bean: participantInstance.studySubject, field: "studySubjectIdentifier").toString().replace('[', '').replace(']','')}</td>

                        <td><g:link controller="fluidSpecimen" action="create" params="['participant.id': participantInstance?.id, 'fluidSampleType':'Blood_whole_BLD']"  >${message(code: 'default.add.label', args: [message(code: 'fluidSpecimen.label', default: 'Follow up Blood')])}</g:link></td>

			</tr>
		</g:each>
		</tbody>
	</table>

</section>

</body>

</html>
