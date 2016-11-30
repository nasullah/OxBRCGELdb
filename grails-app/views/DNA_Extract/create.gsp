<%@ page import="geldb.DNA_Extract" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNA_Extract.label', default: 'DNA Extract')}" />
	<title><g:message code="default.create.label" args="[entityName]" /></title>
</head>

<body>

	<section id="create-DNA_Extract" class="first">

		<g:hasErrors bean="${DNA_ExtractInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${DNA_ExtractInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form action="save" class="form-horizontal" role="form" >
			<g:render template="form"/>

			<div class="row">
				<div class="col-lg-6">
					<div class="">
						<label class="control-label">Exhaust Original Aliquot ?</label>
						<div>
							<label class="radio-inline"><input type="radio" name="exhaustAliquot"  value="True" checked="checked">Yes</label>
							<label class="radio-inline"><input type="radio" name="exhaustAliquot"  value="False" >No</label>
						</div>
					</div>
				</div>
			</div>

			<div class="form-actions margin-top-medium">
				<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'save', default: 'Save')}" />
	            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
			</div>
		</g:form>

	</section>
<hr/>
</body>

</html>
