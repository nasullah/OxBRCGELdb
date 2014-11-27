
<%@ page import="geldb.SampleTrackingEventType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'sampleTrackingEventType.label', default: 'Sample Tracking Event Type')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-sampleTrackingEventType" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sampleTrackingEventType.sampleTrackingEventTypeName.label" default="Sample Tracking Event Type Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: sampleTrackingEventTypeInstance, field: "sampleTrackingEventTypeName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sampleTrackingEventType.sampleTrackingEventTypeDesc.label" default="Sample Tracking Event Type Desc" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: sampleTrackingEventTypeInstance, field: "sampleTrackingEventTypeDesc")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
