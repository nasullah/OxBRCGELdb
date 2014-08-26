
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
			
				<g:sortableColumn property="localIdentifier" title="${message(code: 'DNA_Extract.localIdentifier.label', default: 'Local Identifier')}" />
			
				<g:sortableColumn property="size" title="${message(code: 'DNA_Extract.size.label', default: 'Size')}" />
			
				<g:sortableColumn property="unit" title="${message(code: 'DNA_Extract.unit.label', default: 'Unit')}" />
			
				<g:sortableColumn property="exhausted" title="${message(code: 'DNA_Extract.exhausted.label', default: 'Exhausted')}" />
			
				<g:sortableColumn property="passFail" title="${message(code: 'DNA_Extract.passFail.label', default: 'Pass Fail')}" />
			
				<g:sortableColumn property="notes" title="${message(code: 'DNA_Extract.notes.label', default: 'Notes')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${DNA_ExtractInstanceList}" status="i" var="DNA_ExtractInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${DNA_ExtractInstance.id}">${fieldValue(bean: DNA_ExtractInstance, field: "localIdentifier")}</g:link></td>
			
				<td>${fieldValue(bean: DNA_ExtractInstance, field: "size")}</td>
			
				<td>${fieldValue(bean: DNA_ExtractInstance, field: "unit")}</td>
			
				<td><g:formatBoolean boolean="${DNA_ExtractInstance.exhausted}" /></td>
			
				<td><g:formatBoolean boolean="${DNA_ExtractInstance.passFail}" /></td>
			
				<td>${fieldValue(bean: DNA_ExtractInstance, field: "notes")}</td>
			
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
                       associatedProperties="aliquot.specimen.participant.familyName, aliquot.specimen.participant.diagnosis,
                                             aliquot.specimen.participant.identifierType, aliquot.specimen.participant.identifierValue "/>
<hr style="border:1; height:1px" />

</body>

</html>
