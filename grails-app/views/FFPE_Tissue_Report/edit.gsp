<%@ page import="geldb.FFPE_Tissue_Report" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'FFPE_Tissue_Report.label', default: 'Main Specimen Report')}" />
	<title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>

<body>

	<section id="edit-FFPE_Tissue_Report" class="first">

		<g:hasErrors bean="${FFPE_Tissue_ReportInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${FFPE_Tissue_ReportInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${FFPE_Tissue_ReportInstance?.id}" />
			<g:hiddenField name="version" value="${FFPE_Tissue_ReportInstance?.version}" />
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
