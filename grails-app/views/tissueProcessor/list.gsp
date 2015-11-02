
<%@ page import="geldb.TissueProcessor" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'tissueProcessor.label', default: 'Tissue Processor')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-tissueProcessor" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="tissueProcessorName" title="${message(code: 'tissueProcessor.tissueProcessorName.label', default: 'Tissue Processor Name')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${tissueProcessorInstanceList}" status="i" var="tissueProcessorInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${tissueProcessorInstance.id}">${fieldValue(bean: tissueProcessorInstance, field: "tissueProcessorName")}</g:link></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${tissueProcessorInstanceCount}" />
	</div>
</section>

</body>

</html>
