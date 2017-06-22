
<%@ page import="geldb.PreviousTreatmentType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'previousTreatmentType.label', default: 'Previous Treatment Type')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-previousTreatmentType" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="previousTreatmentTypeName" title="${message(code: 'previousTreatmentType.previousTreatmentTypeName.label', default: 'Previous Treatment Type Name')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${previousTreatmentTypeInstanceList}" status="i" var="previousTreatmentTypeInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${previousTreatmentTypeInstance.id}">${fieldValue(bean: previousTreatmentTypeInstance, field: "previousTreatmentTypeName")}</g:link></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${previousTreatmentTypeInstanceCount}" />
	</div>
</section>

</body>

</html>
