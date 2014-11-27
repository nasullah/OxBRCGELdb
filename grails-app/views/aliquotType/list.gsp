
<%@ page import="geldb.AliquotType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'aliquotType.label', default: 'Aliquot Type')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-aliquotType" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="aliquotTypeName" title="${message(code: 'aliquotType.aliquotTypeName.label', default: 'Aliquot Type Name')}" />
			
				<g:sortableColumn property="aliquotTypeDesc" title="${message(code: 'aliquotType.aliquotTypeDesc.label', default: 'Aliquot Type Desc')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${aliquotTypeInstanceList}" status="i" var="aliquotTypeInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${aliquotTypeInstance.id}">${fieldValue(bean: aliquotTypeInstance, field: "aliquotTypeName")}</g:link></td>
			
				<td>${fieldValue(bean: aliquotTypeInstance, field: "aliquotTypeDesc")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${aliquotTypeInstanceCount}" />
	</div>
</section>

</body>

</html>
