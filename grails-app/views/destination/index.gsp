
<%@ page import="geldb.Destination" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'destination.label', default: 'Destination')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-destination" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="companyName" title="${message(code: 'destination.companyName.label', default: 'Company Name')}" />
			
				<g:sortableColumn property="companyPostalCode" title="${message(code: 'destination.companyPostalCode.label', default: 'Company Postal Code')}" />
			
				<g:sortableColumn property="companyCountry" title="${message(code: 'destination.companyCountry.label', default: 'Company Country')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${destinationInstanceList}" status="i" var="destinationInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${destinationInstance.id}">${fieldValue(bean: destinationInstance, field: "companyName")}</g:link></td>
			
				<td>${fieldValue(bean: destinationInstance, field: "companyPostalCode")}</td>
			
				<td>${fieldValue(bean: destinationInstance, field: "companyCountry")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${destinationInstanceCount}" />
	</div>
</section>

</body>

</html>
