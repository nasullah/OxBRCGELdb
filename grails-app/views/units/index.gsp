
<%@ page import="geldb.Units" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'units.label', default: 'Units')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-units" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="unitType" title="${message(code: 'units.unitType.label', default: 'Unit Type')}" />
			
				<g:sortableColumn property="unitName" title="${message(code: 'units.unitName.label', default: 'Unit Name')}" />
			
				<g:sortableColumn property="unitDescription" title="${message(code: 'units.unitDescription.label', default: 'Unit Description')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${unitsInstanceList}" status="i" var="unitsInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${unitsInstance.id}">${fieldValue(bean: unitsInstance, field: "unitType")}</g:link></td>
			
				<td>${fieldValue(bean: unitsInstance, field: "unitName")}</td>
			
				<td>${fieldValue(bean: unitsInstance, field: "unitDescription")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${unitsInstanceCount}" />
	</div>
</section>

</body>

</html>
