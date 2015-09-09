
<%@ page import="geldb.PathologyImage" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'pathologyImage.label', default: 'Pathology Image')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-pathologyImage" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="takenBy" title="${message(code: 'pathologyImage.takenBy.label', default: 'Taken By')}" />
			
				<g:sortableColumn property="takenDate" title="${message(code: 'pathologyImage.takenDate.label', default: 'Taken Date')}" />
			
				<g:sortableColumn property="type" title="${message(code: 'pathologyImage.type.label', default: 'Type')}" />
			
				<g:sortableColumn property="samplePointer" title="${message(code: 'pathologyImage.samplePointer.label', default: 'Sample Pointer')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${pathologyImageInstanceList}" status="i" var="pathologyImageInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${pathologyImageInstance.id}">${fieldValue(bean: pathologyImageInstance, field: "takenBy")}</g:link></td>
			
				<td><g:formatDate format="dd-MM-yyyy" date="${pathologyImageInstance.takenDate}" /></td>
			
				<td>${fieldValue(bean: pathologyImageInstance, field: "type")}</td>
			
				<td>${fieldValue(bean: pathologyImageInstance, field: "samplePointer")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${pathologyImageInstanceCount}" />
	</div>
</section>

</body>

</html>
