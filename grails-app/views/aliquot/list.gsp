
<%@ page import="geldb.Aliquot" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'aliquot.label', default: 'Aliquot')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>

<body>

<section id="list-aliquot" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="localIdentifier" title="${message(code: 'aliquot.localIdentifier.label', default: 'Local Identifier')}" />
			
				<g:sortableColumn property="size" title="${message(code: 'aliquot.size.label', default: 'Size')}" />
			
				<g:sortableColumn property="unit" title="${message(code: 'aliquot.unit.label', default: 'Unit')}" />
			
				<g:sortableColumn property="exhausted" title="${message(code: 'aliquot.exhausted.label', default: 'Exhausted')}" />
			
				<g:sortableColumn property="passFail" title="${message(code: 'aliquot.passFail.label', default: 'Pass Fail')}" />
			
				<g:sortableColumn property="notes" title="${message(code: 'aliquot.notes.label', default: 'Notes')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${aliquotInstanceList}" status="i" var="aliquotInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${aliquotInstance.id}">${fieldValue(bean: aliquotInstance, field: "localIdentifier")}</g:link></td>
			
				<td>${fieldValue(bean: aliquotInstance, field: "size")}</td>
			
				<td>${fieldValue(bean: aliquotInstance, field: "unit")}</td>
			
				<td><g:formatBoolean boolean="${aliquotInstance.exhausted}" /></td>
			
				<td><g:formatBoolean boolean="${aliquotInstance.passFail}" /></td>
			
				<td>${fieldValue(bean: aliquotInstance, field: "notes")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
    <div>
        <g:paginate total="${aliquotInstanceTotal == null ? Aliquot.count(): aliquotInstanceTotal}" params="${filterParams}" />
        <filterpane:filterButton text="Filter This List" />
    </div>
</section>
<filterpane:filterPane domain="geldb.Aliquot"
                       associatedProperties="specimen.participant.familyName, specimen.participant.diagnosis,
                                             specimen.participant.identifierType, specimen.participant.identifierValue "/>
<hr style="border:1; height:1px" />
</body>

</html>
