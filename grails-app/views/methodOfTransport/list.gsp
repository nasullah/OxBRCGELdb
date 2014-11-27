
<%@ page import="geldb.MethodOfTransport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'methodOfTransport.label', default: 'Method of Transport')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-methodOfTransport" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="methodOfTransportName" title="${message(code: 'methodOfTransport.methodOfTransportName.label', default: 'Method Of Transport Name')}" />
			
				<g:sortableColumn property="methodOfTransportDescription" title="${message(code: 'methodOfTransport.methodOfTransportDescription.label', default: 'Method Of Transport Description')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${methodOfTransportInstanceList}" status="i" var="methodOfTransportInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${methodOfTransportInstance.id}">${fieldValue(bean: methodOfTransportInstance, field: "methodOfTransportName")}</g:link></td>
			
				<td>${fieldValue(bean: methodOfTransportInstance, field: "methodOfTransportDescription")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${methodOfTransportInstanceCount}" />
	</div>
</section>

</body>

</html>
