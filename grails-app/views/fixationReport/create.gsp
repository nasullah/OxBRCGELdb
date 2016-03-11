<%@ page import="geldb.FixationReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:if test="${fixationReportInstance.aliquot.aliquotType.aliquotTypeName == 'Punch biopsy, PAXgene'}">
		<title>Create Fixation Report</title>
	</g:if>
	<g:else>
		<title>Create Genomic Block Fixation Report</title>
	</g:else>
</head>

<body>

	<section id="create-fixationReport" class="first">

		<g:hasErrors bean="${fixationReportInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${fixationReportInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form action="save" class="form-horizontal" role="form" >
			<g:render template="form"/>

			<div class="form-actions margin-top-medium">
				<g:submitButton name="create" class="btn btn-primary" value="Save" />
	            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
			</div>
		</g:form>

	</section>

<hr/>

</body>

</html>
