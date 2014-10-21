
<%@ page import="geldb.Derivation" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'derivation.label', default: 'Derivation')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-derivation" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="derivation.aliquot.label" default="Aliquot" /></th>
			
				<g:sortableColumn property="derivationDate" title="${message(code: 'derivation.derivationDate.label', default: 'Derivation Date')}" />
			
				<g:sortableColumn property="derivationTime" title="${message(code: 'derivation.derivationTime.label', default: 'Derivation Time')}" />
			
				<th><g:message code="derivation.derivedBy.label" default="Derived By" /></th>
			
				<g:sortableColumn property="derivationProcess" title="${message(code: 'derivation.derivationProcess.label', default: 'Derivation Process')}" />
			
				%{--<g:sortableColumn property="notes" title="${message(code: 'derivation.notes.label', default: 'Notes')}" />--}%
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${derivationInstanceList}" status="i" var="derivationInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${derivationInstance.id}">${fieldValue(bean: derivationInstance, field: "aliquot")}</g:link></td>
			
				<td><g:formatDate date="${derivationInstance.derivationDate}" /></td>
			
				<td>${fieldValue(bean: derivationInstance, field: "derivationTime")}</td>
			
				<td>${fieldValue(bean: derivationInstance, field: "derivedBy")}</td>
			
				<td>${fieldValue(bean: derivationInstance, field: "derivationProcess")}</td>
			
				%{--<td>${fieldValue(bean: derivationInstance, field: "notes")}</td>--}%
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${derivationInstanceCount}" />
	</div>
</section>

</body>

</html>
