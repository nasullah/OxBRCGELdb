
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

<section id="list-fluidSpecimen" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="exhausted" title="${message(code: 'fluidSpecimen.exhausted.label', default: 'Exhausted')}" />
			
				<g:sortableColumn property="passFail" title="${message(code: 'fluidSpecimen.passFail.label', default: 'Pass Fail')}" />
			
				<g:sortableColumn property="passFailReason" title="${message(code: 'fluidSpecimen.passFailReason.label', default: 'Pass Fail Reason')}" />
			
				<g:sortableColumn property="notes" title="${message(code: 'fluidSpecimen.notes.label', default: 'Notes')}" />
			
				%{--<th><g:message code="fluidSpecimen.participant.label" default="Participant" /></th>--}%
			
				<g:sortableColumn property="collectionDate" title="${message(code: 'fluidSpecimen.collectionDate.label', default: 'Collection Date')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${fluidSpecimenInstanceList}" status="i" var="fluidSpecimenInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${fluidSpecimenInstance.id}">${fieldValue(bean: fluidSpecimenInstance, field: "exhausted")}</g:link></td>
			
				<td><g:formatBoolean boolean="${fluidSpecimenInstance.passFail}" /></td>
			
				<td>${fieldValue(bean: fluidSpecimenInstance, field: "passFailReason")}</td>
			
				<td>${fieldValue(bean: fluidSpecimenInstance, field: "notes")}</td>
			
				%{--<td>${fieldValue(bean: fluidSpecimenInstance, field: "participant")}</td>--}%
			
				<td><g:formatDate format="yyyy-MM-dd" date="${fluidSpecimenInstance.collectionDate}" /></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
    <div>
        <g:paginate total="${fluidSpecimenInstanceTotal == null ? FluidSpecimen.count(): fluidSpecimenInstanceTotal}" params="${filterParams}" />
        <filterpane:filterButton text="Filter This List" />
    </div>
</section>
<filterpane:filterPane domain="geldb.FluidSpecimen"
                       excludeProperties="collectionDate"
                       associatedProperties="participant.familyName, participant.givenName,
                                             participant.nHSNumber,participant.hospitalNumber "/>
<hr style="border:1; height:1px" />

</body>

</html>
