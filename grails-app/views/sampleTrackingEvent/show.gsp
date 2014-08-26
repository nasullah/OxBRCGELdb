
<%@ page import="geldb.SampleTrackingEvent" %>
<%@ page import="geldb.SolidSpecimen" %>
<%@ page import="geldb.FluidSpecimen" %>

<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'sampleTrackingEvent.label', default: 'Sample Tracking Event')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-sampleTrackingEvent" class="first">

	<table class="table">
		<tbody>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="sampleTrackingEvent.specimen.label" default="Specimen" /></td>
        <td valign="top" class="value">
            <% def fluidSpecimen = FluidSpecimen.listOrderById() %>
            <% def solidSpecimen = SolidSpecimen.listOrderById() %>
            <g:each in="${solidSpecimen}" var="item">
            <g:if test="${item.id == sampleTrackingEventInstance?.specimen?.id}">
            <g:link controller="solidSpecimen" action="show" id="${sampleTrackingEventInstance?.specimen?.id}">${sampleTrackingEventInstance?.specimen?.encodeAsHTML()}</g:link>
            </g:if>
            </g:each>
            <g:each in="${fluidSpecimen}" var="item">
                <g:if test="${item.id == sampleTrackingEventInstance?.specimen?.id}">
                    <g:link controller="fluidSpecimen" action="show" id="${sampleTrackingEventInstance?.specimen?.id}">${sampleTrackingEventInstance?.specimen?.encodeAsHTML()}</g:link></td>
                </g:if>
            </g:each>

        </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sampleTrackingEvent.sampleTrackingEventType.label" default="Sample Tracking Event Type" /></td>
				
				<td valign="top" class="value">${sampleTrackingEventInstance?.sampleTrackingEventType?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sampleTrackingEvent.date.label" default="Date" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${sampleTrackingEventInstance?.date}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sampleTrackingEvent.time.label" default="Time" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: sampleTrackingEventInstance, field: "time")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
