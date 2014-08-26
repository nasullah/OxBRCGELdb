
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
			
				<g:sortableColumn property="localIdentifier" title="${message(code: 'fluidSpecimen.localIdentifier.label', default: 'Local Identifier')}" />
			
				<g:sortableColumn property="size" title="${message(code: 'fluidSpecimen.size.label', default: 'Size')}" />
			
				<g:sortableColumn property="unit" title="${message(code: 'fluidSpecimen.unit.label', default: 'Unit')}" />
			
				<g:sortableColumn property="exhausted" title="${message(code: 'fluidSpecimen.exhausted.label', default: 'Exhausted')}" />
			
				<g:sortableColumn property="passFail" title="${message(code: 'fluidSpecimen.passFail.label', default: 'Pass Fail')}" />
			
				<g:sortableColumn property="notes" title="${message(code: 'fluidSpecimen.notes.label', default: 'Notes')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${fluidSpecimenInstanceList}" status="i" var="fluidSpecimenInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${fluidSpecimenInstance.id}">${fieldValue(bean: fluidSpecimenInstance, field: "localIdentifier")}</g:link></td>
			
				<td>${fieldValue(bean: fluidSpecimenInstance, field: "size")}</td>
			
				<td>${fieldValue(bean: fluidSpecimenInstance, field: "unit")}</td>
			
				<td><g:formatBoolean boolean="${fluidSpecimenInstance.exhausted}" /></td>
			
				<td><g:formatBoolean boolean="${fluidSpecimenInstance.passFail}" /></td>
			
				<td>${fieldValue(bean: fluidSpecimenInstance, field: "notes")}</td>
			
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
                       associatedProperties="participant.familyName, participant.diagnosis,
                                             participant.identifierType,participant.identifierValue "/>
<hr style="border:1; height:1px" />
</body>

</html>
