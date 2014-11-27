
<%@ page import="geldb.DNA_Library" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNA_Library.label', default: 'DNA Library')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>

<body>

<section id="list-DNA_Library" class="first">

	<table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <g:sortableColumn property="exhausted" title="${message(code: 'DNA_Library.exhausted.label', default: 'Exhausted')}" />

            <g:sortableColumn property="passFail" title="${message(code: 'DNA_Library.passFail.label', default: 'Pass Fail')}" />

            <g:sortableColumn property="passFailReason" title="${message(code: 'DNA_Library.passFailReason.label', default: 'Pass Fail Reason')}" />

            <g:sortableColumn property="na_extract.aliquot.specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'na_extract.aliquot.specimen.participant.studySubject.studySubjectIdentifier.label', default: "Participant's GeL Id")}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${DNA_LibraryInstanceList}" status="i" var="DNA_LibraryInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${DNA_LibraryInstance.id}">${fieldValue(bean: DNA_LibraryInstance, field: "exhausted")}</g:link></td>

                <td><g:formatBoolean boolean="${DNA_LibraryInstance.passFail}" /></td>

                <td>${fieldValue(bean: DNA_LibraryInstance, field: "passFailReason")}</td>

                <td>${fieldValue(bean: DNA_LibraryInstance.na_extract.aliquot.specimen.participant.studySubject, field: "studySubjectIdentifier").toString().replace('[','').replace(']','')}</td>

            </tr>
        </g:each>
		</tbody>
	</table>
    <div>
        <g:paginate total="${DNA_LibraryInstanceTotal == null ? DNA_Library.count(): DNA_LibraryInstanceTotal}" params="${filterParams}" />
        <filterpane:filterButton text="Filter This List" />
    </div>
</section>
<filterpane:filterPane domain="geldb.DNA_Library"
                       excludeProperties="extractionDate"
                       associatedProperties="na_extract.aliquot.specimen.sapphireIdentifier, na_extract.aliquot.sapphireIdentifier, na_extract.sapphireIdentifier,
                                             na_extract.aliquot.specimen.participant.familyName, na_extract.aliquot.specimen.participant.givenName,na_extract.aliquot.specimen.participant.diagnosis,
                                             na_extract.aliquot.specimen.participant.nHSNumber, na_extract.aliquot.specimen.participant.hospitalNumber,
                                             na_extract.aliquot.specimen.participant.studySubject.studySubjectIdentifier"/>
<hr style="border:1; height:1px" />

</body>

</html>
