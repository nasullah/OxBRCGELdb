
<%@ page import="geldb.StudyIdentifier" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'studyIdentifier.label', default: 'Study Identifier')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-studyIdentifier" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="studyIdentifier.study.label" default="Study" /></th>
			
				<g:sortableColumn property="studyIdentifier" title="${message(code: 'studyIdentifier.studyIdentifier.label', default: 'Study Identifier')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${studyIdentifierInstanceList}" status="i" var="studyIdentifierInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${studyIdentifierInstance.id}">${fieldValue(bean: studyIdentifierInstance, field: "study")}</g:link></td>
			
				<td>${fieldValue(bean: studyIdentifierInstance, field: "studyIdentifier")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${studyIdentifierInstanceCount}" />
	</div>
</section>

</body>

</html>
