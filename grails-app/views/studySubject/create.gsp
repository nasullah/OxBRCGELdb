<%@ page import="geldb.StudySubject" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'studySubject.label', default: 'Study Subject')}" />
	<title>Associate Participant with Study</title>
</head>

<body>

	<section id="create-studySubject" class="first">

		<g:hasErrors bean="${studySubjectInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${studySubjectInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form action="save" class="form-horizontal" role="form" >
			<g:render template="form"/>

			<div class="form-actions margin-top-medium">
				<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'save', default: 'Save')}" />
	            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
			</div>
		</g:form>

	</section>
<hr style="border:1; height:1px" />
</body>

</html>
