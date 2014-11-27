
<%@ page import="geldb.SampleType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'sampleType.label', default: 'Sample Type')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-sampleType" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="sampleTypeName" title="${message(code: 'sampleType.sampleTypeName.label', default: 'Sample Type Name')}" />
			
				<g:sortableColumn property="sampleTypeDesc" title="${message(code: 'sampleType.sampleTypeDesc.label', default: 'Sample Type Desc')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${sampleTypeInstanceList}" status="i" var="sampleTypeInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${sampleTypeInstance.id}">${fieldValue(bean: sampleTypeInstance, field: "sampleTypeName")}</g:link></td>
			
				<td>${fieldValue(bean: sampleTypeInstance, field: "sampleTypeDesc")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${sampleTypeInstanceCount}" />
	</div>
</section>

</body>

</html>
