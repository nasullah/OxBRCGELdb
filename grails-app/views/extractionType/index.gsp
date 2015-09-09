
<%@ page import="geldb.ExtractionType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'extractionType.label', default: 'Extraction Type')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-extractionType" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="extractionTypeName" title="${message(code: 'extractionType.extractionTypeName.label', default: 'Extraction Type Name')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${extractionTypeInstanceList}" status="i" var="extractionTypeInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${extractionTypeInstance.id}">${fieldValue(bean: extractionTypeInstance, field: "extractionTypeName")}</g:link></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${extractionTypeInstanceCount}" />
	</div>
</section>

</body>

</html>
