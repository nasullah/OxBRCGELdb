<%@ page import="geldb.AliquotPhoto" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'aliquotPhoto.label', default: 'AliquotPhoto')}" />
	<title><g:message code="default.create.label" args="[entityName]" /></title>
</head>

<body>

	<section id="create-aliquotPhoto" class="first">

		<g:hasErrors bean="${aliquotPhotoInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${aliquotPhotoInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form action="save" class="form-horizontal" role="form"  enctype="multipart/form-data">
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
