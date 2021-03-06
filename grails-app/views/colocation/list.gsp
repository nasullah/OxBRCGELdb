
<%@ page import="geldb.Colocation" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'colocation.label', default: 'Colocation')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-colocation" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="colocation.aliquot.label" default="Aliquot" /></th>
			
				<g:sortableColumn property="adjacent" title="${message(code: 'colocation.adjacent.label', default: 'Adjacent')}" />

				<th><g:message code="colocation.pairedAliquot.label" default="Paired Aliquot" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${colocationInstanceList}" status="i" var="colocationInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${colocationInstance.id}">${fieldValue(bean: colocationInstance, field: "aliquot")}</g:link></td>
			
				<td><g:formatBoolean boolean="${colocationInstance.adjacent}" true="Yes" false="No" /></td>

				<td>${fieldValue(bean: colocationInstance, field: "pairedAliquot")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${colocationInstanceCount}" />
	</div>
</section>

</body>

</html>
