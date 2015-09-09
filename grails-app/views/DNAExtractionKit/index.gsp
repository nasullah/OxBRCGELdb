
<%@ page import="geldb.DNAExtractionKit" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNAExtractionKit.label', default: 'DNA Extraction Kit')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-DNAExtractionKit" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="extractionKitName" title="${message(code: 'DNAExtractionKit.extractionKitName.label', default: 'Extraction Kit Name')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${DNAExtractionKitInstanceList}" status="i" var="DNAExtractionKitInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${DNAExtractionKitInstance.id}">${fieldValue(bean: DNAExtractionKitInstance, field: "extractionKitName")}</g:link></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${DNAExtractionKitInstanceCount}" />
	</div>
</section>

</body>

</html>
