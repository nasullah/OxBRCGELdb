
<%@ page import="geldb.AliquotPhoto" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'aliquotPhoto.label', default: 'AliquotPhoto')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-aliquotPhoto" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="aliquotPhoto.aliquotReport.label" default="Aliquot Report" /></th>
			
				<g:sortableColumn property="aliquotPhoto" title="${message(code: 'aliquotPhoto.aliquotPhoto.label', default: 'Aliquot Photo')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${aliquotPhotoInstanceList}" status="i" var="aliquotPhotoInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${aliquotPhotoInstance.id}">${fieldValue(bean: aliquotPhotoInstance, field: "aliquotReport")}</g:link></td>
			
				<td>${fieldValue(bean: aliquotPhotoInstance, field: "aliquotPhoto")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${aliquotPhotoInstanceCount}" />
	</div>
</section>

</body>

</html>
