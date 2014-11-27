
<%@ page import="geldb.FluidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'fluidSpecimen.label', default: 'Fluid Specimen')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-fluidSpecimen" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="fluidSampleType" title="${message(code: 'fluidSpecimen.fluidSampleType.label', default: 'Fluid Sample Type')}" />

                <g:sortableColumn property="collectionDate" title="${message(code: 'fluidSpecimen.collectionDate.label', default: 'Collection Date')}" />

				<g:sortableColumn property="passFail" title="${message(code: 'fluidSpecimen.passFail.label', default: 'Pass Fail')}" />
			
				<g:sortableColumn property="fluidSpecimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'fluidSpecimen.participant.studySubject.studySubjectIdentifier.label', default: "Participant's GeL Id")}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${fluidSpecimenInstanceList}" status="i" var="fluidSpecimenInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${fluidSpecimenInstance.id}">${fieldValue(bean: fluidSpecimenInstance, field: "fluidSampleType")}</g:link></td>

                <td><g:formatDate format="yyyy-MM-dd" date="${fluidSpecimenInstance.collectionDate}" /></td>

				<td><g:formatBoolean boolean="${fluidSpecimenInstance.passFail}" /></td>
			
				<td>${fieldValue(bean: fluidSpecimenInstance.participant.studySubject, field: "studySubjectIdentifier").toString().replace('[', '').replace(']','')}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${fluidSpecimenInstanceCount}" />
	</div>
</section>

</body>

</html>
