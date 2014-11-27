
<%@ page import="geldb.SamplePhoto" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'samplePhoto.label', default: 'SamplePhoto')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-samplePhoto" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="samplePhoto" title="${message(code: 'samplePhoto.samplePhoto.label', default: 'Sample Photo')}" />
			
				<th><g:message code="samplePhoto.solidSpecimenReport.label" default="Solid Specimen Report" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${samplePhotoInstanceList}" status="i" var="samplePhotoInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${samplePhotoInstance.id}">${fieldValue(bean: samplePhotoInstance, field: "samplePhoto")}</g:link></td>
			
				<td>${fieldValue(bean: samplePhotoInstance, field: "solidSpecimenReport")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${samplePhotoInstanceCount}" />
	</div>
</section>

</body>

</html>
