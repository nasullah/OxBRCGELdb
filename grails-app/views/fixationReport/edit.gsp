<%@ page import="geldb.FixationReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:if test="${fixationReportInstance.aliquot.aliquotType.aliquotTypeName == 'Punch biopsy, PAXgene'}">
		<title>Edit Fixation Report</title>
	</g:if>
	<g:else>
		<title>Edit Genomic Block Fixation Report</title>
	</g:else>
</head>

<body>

	<section id="edit-fixationReport" class="first">

		<g:hasErrors bean="${fixationReportInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${fixationReportInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${fixationReportInstance?.id}" />
			<g:hiddenField name="version" value="${fixationReportInstance?.version}" />
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
