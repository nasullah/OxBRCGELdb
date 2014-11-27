
<%@ page import="geldb.DNA_Extract" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNA_Extract.label', default: 'DNA Extract')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>

<body>

<section id="list-DNA_Extract" class="first">

	<table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <g:sortableColumn property="exhausted" title="${message(code: 'DNA_Extract.exhausted.label', default: 'Exhausted')}" />

            <g:sortableColumn property="passFail" title="${message(code: 'DNA_Extract.passFail.label', default: 'Pass Fail')}" />

            <g:sortableColumn property="passFailReason" title="${message(code: 'DNA_Extract.passFailReason.label', default: 'Pass Fail Reason')}" />

            <g:sortableColumn property="DNA_Extract.aliquot.specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'aliquot.specimen.participant.studySubject.studySubjectIdentifier.label', default: "Participant's GeL Id")}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${DNA_ExtractInstanceList}" status="i" var="DNA_ExtractInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${DNA_ExtractInstance.id}">${fieldValue(bean: DNA_ExtractInstance, field: "exhausted")}</g:link></td>

                <td><g:formatBoolean boolean="${DNA_ExtractInstance.passFail}" /></td>

                <td>${fieldValue(bean: DNA_ExtractInstance, field: "passFailReason")}</td>

                <td>${fieldValue(bean: DNA_ExtractInstance.aliquot.specimen.participant.studySubject, field: "studySubjectIdentifier").toString().replace('[','').replace(']','')}</td>

            </tr>
        </g:each>
		</tbody>
	</table>
    <div>
        <g:paginate total="${DNA_ExtractInstanceTotal == null ? DNA_Extract.count(): DNA_ExtractInstanceTotal}" params="${filterParams}" />
        <filterpane:filterButton text="Filter This List" />
    </div>
</section>
<filterpane:filterPane domain="geldb.DNA_Extract"
                       excludeProperties="extractionDate"
                       associatedProperties="aliquot.sapphireIdentifier,aliquot.specimen.sapphireIdentifier, aliquot.specimen.participant.familyName, aliquot.specimen.participant.givenName, aliquot.specimen.participant.diagnosis,
                                             aliquot.specimen.participant.nHSNumber, aliquot.specimen.participant.hospitalNumber,
                                             aliquot.specimen.participant.studySubject.studySubjectIdentifier"/>
<hr style="border:1; height:1px" />

</body>

</html>
