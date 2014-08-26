
<%@ page import="geldb.Postmortem" %>
<%@ page import="geldb.SolidSpecimen" %>
<%@ page import="geldb.FluidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'postmortem.label', default: 'Postmortem')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-postmortem" class="first">

	<table class="table">
		<tbody>
            <tr class="prop">
                <td valign="top" class="name"><g:message code="sampleTrackingEvent.specimen.label" default="Specimen" /></td>
            <td valign="top" class="value">
                <% def fluidSpecimen = FluidSpecimen.listOrderById() %>
                <% def solidSpecimen = SolidSpecimen.listOrderById() %>
                <g:each in="${solidSpecimen}" var="item">
                    <g:if test="${item.id == postmortemInstance?.specimen?.id}">
                        <g:link controller="solidSpecimen" action="show" id="${postmortemInstance?.specimen?.id}">${postmortemInstance?.specimen?.encodeAsHTML()}</g:link>
                    </g:if>
                </g:each>
                <g:each in="${fluidSpecimen}" var="item">
                    <g:if test="${item.id == postmortemInstance?.specimen?.id}">
                        <g:link controller="fluidSpecimen" action="show" id="${postmortemInstance?.specimen?.id}">${postmortemInstance?.specimen?.encodeAsHTML()}</g:link></td>
                    </g:if>
                </g:each>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="postmortem.delayInHours.label" default="Delay In Hours" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: postmortemInstance, field: "delayInHours")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="postmortem.warmIschemiaTimeMin.label" default="Warm Ischemia Time Min" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: postmortemInstance, field: "warmIschemiaTimeMin")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="postmortem.coldIschemiaTimeMin.label" default="Cold Ischemia Time Min" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: postmortemInstance, field: "coldIschemiaTimeMin")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
