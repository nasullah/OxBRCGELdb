
<%@ page import="geldb.Report" %>
<%@ page import="geldb.FluidSpecimen" %>
<%@ page import="geldb.SolidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'report.label', default: 'Report')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-report" class="first">

	<table class="table">
		<tbody>
        <g:if test="${reportInstance?.derivation?.id !=null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="report.derivation.label" default="Derivation" /></td>

                <td valign="top" class="value"><g:link controller="derivation" action="show" id="${reportInstance?.derivation?.id}">${reportInstance?.derivation?.encodeAsHTML()}</g:link></td>

            </tr>
        </g:if>
        <g:if test="${reportInstance?.specimen?.id !=null}">

            <tr class="prop">
                <td valign="top" class="name"><g:message code="report.specimen.label" default="Specimen" /></td>

            <td valign="top" class="value">
                <% def fluidSpecimen = FluidSpecimen?.listOrderById() %>
                <% def solidSpecimen = SolidSpecimen?.listOrderById() %>
                <g:each in="${fluidSpecimen}" var="item">
                    <g:if test="${item.id == reportInstance?.specimen?.id}">
                        <g:link controller="fluidSpecimen" action="show" id="${reportInstance?.specimen?.id}">${reportInstance?.specimen?.encodeAsHTML()}</g:link>
                    </g:if>
                </g:each>
                <g:each in="${solidSpecimen}" var="item">
                    <g:if test="${item.id == reportInstance?.specimen?.id}">
                        <g:link controller="solidSpecimen" action="show" id="${reportInstance?.specimen?.id}">${reportInstance?.specimen?.encodeAsHTML()}</g:link>
                    </g:if>
                </g:each>

            </tr>
        </g:if>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="report.reportDate.label" default="Report Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${reportInstance?.reportDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="report.reportStaff.label" default="Report Staff" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${reportInstance?.reportStaff?.id}">${reportInstance?.reportStaff?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="report.comments.label" default="Comments" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: reportInstance, field: "comments")}</td>
				
			</tr>

		
		</tbody>
	</table>
</section>

</body>

</html>
