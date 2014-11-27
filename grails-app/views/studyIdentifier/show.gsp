
<%@ page import="geldb.StudyIdentifier" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'studyIdentifier.label', default: 'Study Identifier')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-studyIdentifier" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="studyIdentifier.study.label" default="Study" /></td>
				
				<td valign="top" class="value"><g:link controller="study" action="show" id="${studyIdentifierInstance?.study?.id}">${studyIdentifierInstance?.study?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="studyIdentifier.studyIdentifier.label" default="Study Identifier" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: studyIdentifierInstance, field: "studyIdentifier")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
