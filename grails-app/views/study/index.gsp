
<%@ page import="geldb.Study" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'study.label', default: 'Study')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-study" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="studyName" title="${message(code: 'study.studyName.label', default: 'Study Name')}" />
			
				<g:sortableColumn property="studyIdentifier" title="${message(code: 'study.studyIdentifier.label', default: 'Study Identifier')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${studyInstanceList}" status="i" var="studyInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${studyInstance.id}">${fieldValue(bean: studyInstance, field: "studyName")}</g:link></td>
			
				<td>${fieldValue(bean: studyInstance, field: "studyIdentifier")}</td>
			
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
