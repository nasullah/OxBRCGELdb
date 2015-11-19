<%@ page import="geldb.Participant" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<title>Show Participant ${participantInstance.studySubject.studySubjectIdentifier.findResult{it?.size() ? it : null}}</title>
	<resource:autoComplete/>
</head>

<body>

	<section id="edit-participant" class="first">

		<g:hasErrors bean="${participantInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${participantInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${participantInstance?.id}" />
			<g:hiddenField name="version" value="${participantInstance?.version}" />
			<g:hiddenField name="_method" value="PUT" />
			
			<g:render template="form"/>
			
			<div class="form-actions margin-top-medium">
				<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
	            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
			</div>
		</g:form>

	</section>

</body>

</html>
