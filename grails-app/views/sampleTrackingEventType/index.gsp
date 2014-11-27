
<%@ page import="geldb.SampleTrackingEventType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'sampleTrackingEventType.label', default: 'Sample Tracking Event Type')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-sampleTrackingEventType" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="sampleTrackingEventTypeName" title="${message(code: 'sampleTrackingEventType.sampleTrackingEventTypeName.label', default: 'Sample Tracking Event Type Name')}" />
			
				<g:sortableColumn property="sampleTrackingEventTypeDesc" title="${message(code: 'sampleTrackingEventType.sampleTrackingEventTypeDesc.label', default: 'Sample Tracking Event Type Desc')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${sampleTrackingEventTypeInstanceList}" status="i" var="sampleTrackingEventTypeInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${sampleTrackingEventTypeInstance.id}">${fieldValue(bean: sampleTrackingEventTypeInstance, field: "sampleTrackingEventTypeName")}</g:link></td>
			
				<td>${fieldValue(bean: sampleTrackingEventTypeInstance, field: "sampleTrackingEventTypeDesc")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${sampleTrackingEventTypeInstanceCount}" />
	</div>
</section>

</body>

</html>
