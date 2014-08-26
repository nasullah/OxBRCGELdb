<%@ page import="geldb.SolidSpecimenReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'solidSpecimenReport.label', default: 'Solid Specimen Report')}" />
	<title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>

<body>

	<section id="edit-solidSpecimenReport" class="first">

		<g:hasErrors bean="${solidSpecimenReportInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${solidSpecimenReportInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${solidSpecimenReportInstance?.id}" />
			<g:hiddenField name="version" value="${solidSpecimenReportInstance?.version}" />
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
