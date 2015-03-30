
<%@ page import="geldb.FluidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'fluidSpecimen.label', default: 'Fluid Specimen')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>

<body>

<p>
<p>
<filterpane:filterButton text="Filter This List" />
<filterpane:filterPane domain="geldb.FluidSpecimen"
                       excludeProperties="collectionDate"
                       associatedProperties="participant.familyName, participant.givenName,
                                             participant.nHSNumber,participant.hospitalNumber,
                                             participant.studySubject.studySubjectIdentifier"/>
<hr style="border:1; height:1px" />

<section id="list-fluidSpecimen" class="first">

	<table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <g:sortableColumn property="fluidSampleType" title="${message(code: 'fluidSpecimen.fluidSampleType.label', default: 'Fluid Sample Type')}" />

            <g:sortableColumn property="collectionDate" title="${message(code: 'fluidSpecimen.collectionDate.label', default: 'Collection Date')}" />

            <g:sortableColumn property="timePoint" title="${message(code: 'fluidSpecimen.timePoint.label', default: 'Time Point')}" />

            <g:sortableColumn property="participant.studySubject.studySubjectIdentifier" title="${message(code: 'fluidSpecimen.participant.studySubject.studySubjectIdentifier.label', default: "Participant's GeL Id")}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${fluidSpecimenInstanceList}" status="i" var="fluidSpecimenInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${fluidSpecimenInstance.id}">${fieldValue(bean: fluidSpecimenInstance, field: "fluidSampleType")}</g:link></td>

                <td><g:formatDate format="yyyy-MM-dd" date="${fluidSpecimenInstance.collectionDate}" /></td>

                <td>${fieldValue(bean: fluidSpecimenInstance, field: "timePoint")}</td>

                <td>${fieldValue(bean: fluidSpecimenInstance.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

            </tr>
        </g:each>
		</tbody>
	</table>
    <div>
        <bs:paginate total="${fluidSpecimenInstanceTotal}" />
    </div>
</section>

</body>

</html>
