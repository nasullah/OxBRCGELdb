
<%@ page import="geldb.DispatchItem" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'dispatchItem.label', default: 'Dispatch Item')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-dispatchItem" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="dispatchItem.dispatchedBox.label" default="Dispatched Box" /></th>
			
				<g:sortableColumn property="positionIfPlated" title="${message(code: 'dispatchItem.positionIfPlated.label', default: 'Position If Plated')}" />
			
				<g:sortableColumn property="volume_ul" title="${message(code: 'dispatchItem.volume_ul.label', default: 'Volumeul')}" />
			
				<th><g:message code="dispatchItem.identifiedSample.label" default="Identified Sample" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${dispatchItemInstanceList}" status="i" var="dispatchItemInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${dispatchItemInstance.id}">${fieldValue(bean: dispatchItemInstance, field: "dispatchedBox")}</g:link></td>
			
				<td>${fieldValue(bean: dispatchItemInstance, field: "positionIfPlated")}</td>
			
				<td>${fieldValue(bean: dispatchItemInstance, field: "volume_ul")}</td>
			
				<td>${fieldValue(bean: dispatchItemInstance, field: "identifiedSample")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${dispatchItemInstanceCount}" />
	</div>
</section>

</body>

</html>
