
<%@ page import="geldb.SampleTrackingEvent" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'sampleTrackingEvent.label', default: 'Sample Tracking Event')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-sampleTrackingEvent" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="sampleTrackingEvent.specimen.label" default="Specimen" /></th>
			
				<g:sortableColumn property="sampleTrackingEventType" title="${message(code: 'sampleTrackingEvent.sampleTrackingEventType.label', default: 'Sample Tracking Event Type')}" />
			
				<g:sortableColumn property="date" title="${message(code: 'sampleTrackingEvent.date.label', default: 'Date')}" />
			
				<g:sortableColumn property="time" title="${message(code: 'sampleTrackingEvent.time.label', default: 'Time')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${sampleTrackingEventInstanceList}" status="i" var="sampleTrackingEventInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${sampleTrackingEventInstance.id}">${fieldValue(bean: sampleTrackingEventInstance, field: "specimen")}</g:link></td>
			
				<td>${fieldValue(bean: sampleTrackingEventInstance, field: "sampleTrackingEventType")}</td>
			
				<td><g:formatDate date="${sampleTrackingEventInstance.date}" /></td>
			
				<td>${fieldValue(bean: sampleTrackingEventInstance, field: "time")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${sampleTrackingEventInstanceCount}" />
	</div>
</section>

</body>

</html>
