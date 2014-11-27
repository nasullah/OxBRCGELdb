
<%@ page import="geldb.DNAExtractionStatus" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNAExtractionStatus.label', default: 'DNA Extraction Status')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-DNAExtractionStatus" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="status" title="${message(code: 'DNAExtractionStatus.status.label', default: 'Status')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${DNAExtractionStatusInstanceList}" status="i" var="DNAExtractionStatusInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${DNAExtractionStatusInstance.id}">${fieldValue(bean: DNAExtractionStatusInstance, field: "status")}</g:link></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${DNAExtractionStatusInstanceCount}" />
	</div>
</section>

</body>

</html>
