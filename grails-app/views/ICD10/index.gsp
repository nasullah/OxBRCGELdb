
<%@ page import="geldb.ICD10" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'ICD10.label', default: 'ICD10')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-ICD10" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="code" title="${message(code: 'ICD10.code.label', default: 'Code')}" />
			
				<g:sortableColumn property="meaning" title="${message(code: 'ICD10.meaning.label', default: 'Meaning')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${ICD10InstanceList}" status="i" var="ICD10Instance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${ICD10Instance.id}">${fieldValue(bean: ICD10Instance, field: "code")}</g:link></td>
			
				<td>${fieldValue(bean: ICD10Instance, field: "meaning")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${ICD10InstanceCount}" />
	</div>
</section>

</body>

</html>
