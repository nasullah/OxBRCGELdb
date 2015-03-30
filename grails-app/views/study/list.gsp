
<%@ page import="geldb.Study" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'study.label', default: 'Consent Type')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-study" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="studyName" title="${message(code: 'study.studyName.label', default: 'Consent Type')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${studyInstanceList}" status="i" var="studyInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${studyInstance.id}">${fieldValue(bean: studyInstance, field: "studyName")}</g:link></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${studyInstanceCount}" />
	</div>
</section>

</body>

</html>
