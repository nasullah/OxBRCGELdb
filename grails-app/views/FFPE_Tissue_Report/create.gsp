<%@ page import="geldb.FFPE_Tissue_Report" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'FFPE_Tissue_Report.label', default: 'Main Specimen Report')}" />
	<title><g:message code="default.create.label" args="[entityName]" /></title>
</head>

<body>

	<section id="create-FFPE_Tissue_Report" class="first">

		<g:hasErrors bean="${FFPE_Tissue_ReportInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${FFPE_Tissue_ReportInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:uploadForm action="save" class="form-horizontal" role="form" >
			<g:render template="form"/>

			<div class="form-actions margin-top-medium">
				<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'save', default: 'Save')}" />
	            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
			</div>
		</g:uploadForm>

	</section>
<hr style="border:1; height:1px" />
</body>

</html>
