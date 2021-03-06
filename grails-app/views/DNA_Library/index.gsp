
<%@ page import="geldb.DNA_Library" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNA_Library.label', default: 'Available DNA Library')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>

<body>

<hr/>

<filterpane:filterButton text="Filter This List" />
<filterpane:filterPane domain="geldb.DNA_Library"
					   excludeProperties="extractionDate"
					   associatedProperties="na_extract.aliquot.specimen.participant.familyName, na_extract.aliquot.specimen.participant.givenName,na_extract.aliquot.specimen.participant.diagnosis,
                                 na_extract.aliquot.specimen.participant.nHSNumber, na_extract.aliquot.specimen.participant.hospitalNumber,
                                 na_extract.aliquot.specimen.participant.studySubject.studySubjectIdentifier"/>

<hr/>

<div class="container">
	<div class="text-warning text-center">
		<b>
			<filterpane:isFiltered>Filter applied!</filterpane:isFiltered>
			<filterpane:isNotFiltered>Not filtered!</filterpane:isNotFiltered>
		</b>
	</div>
</div>

<section id="index-DNA_Library" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
		<tr>

			<g:sortableColumn property="sapphireIdentifier" title="${message(code: 'DNA_Library.sapphireIdentifier.label', default: 'DNA Library Identifier')}" />

			<g:sortableColumn property="exhausted" title="${message(code: 'DNA_Library.exhausted.label', default: 'Exhausted')}" />

			<g:sortableColumn property="passFail" title="${message(code: 'DNA_Library.passFail.label', default: 'Pass Fail')}" />

			<g:sortableColumn property="na_extract.aliquot.specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'na_extract.aliquot.specimen.participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

		</tr>
		</thead>
		<tbody>
		<g:each in="${DNA_LibraryInstanceList}" status="i" var="DNA_LibraryInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

				<td><g:link action="show" id="${DNA_LibraryInstance.id}">${fieldValue(bean: DNA_LibraryInstance, field: "sapphireIdentifier")}</g:link></td>

				<td><g:formatBoolean boolean="${DNA_LibraryInstance.exhausted}" false="No" true="Yes" /></td>

				<td><g:formatBoolean boolean="${DNA_LibraryInstance.passFail}" true="Pass" false="Fail" /></td>

				<% def gelId = DNA_LibraryInstance.na_extract.aliquot.specimen.participant.studySubject %>
				<g:each in="${1..2}" >
					<% gelId = gelId.first()%>
				</g:each>
				<% gelId =gelId.findResult {it.studySubjectIdentifier ? it : null}%>

				<td>${fieldValue(bean: gelId, field: "studySubjectIdentifier")}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div class="pagination">
		<g:paginate total="${DNA_LibraryInstanceTotal == null ? DNA_LibraryInstanceCount: DNA_LibraryInstanceTotal}" params="${filterParams}" />
		<a>Number of records: ${DNA_LibraryInstanceTotal == null ? DNA_LibraryInstanceCount: DNA_LibraryInstanceTotal}</a>
	</div>
</section>

</body>

</html>
