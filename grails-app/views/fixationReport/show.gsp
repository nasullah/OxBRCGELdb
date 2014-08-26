
<%@ page import="geldb.FixationReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'fixationReport.label', default: 'Fixation Report')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-fixationReport" class="first">

	<table class="table">
		<tbody>

        <g:if test="${fixationReportInstance?.derivation?.id !=null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="fixationReport.derivation.label" default="Derivation" /></td>

                <td valign="top" class="value"><g:link controller="derivation" action="show" id="${fixationReportInstance?.derivation?.id}">${fixationReportInstance?.derivation?.encodeAsHTML()}</g:link></td>

            </tr>
        </g:if>
        <g:if test="${fixationReportInstance?.specimen?.id !=null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="fixationReport.specimen.label" default="Specimen" /></td>

                <td valign="top" class="value"><g:link controller="specimen" action="show" id="${fixationReportInstance?.specimen?.id}">${fixationReportInstance?.specimen?.encodeAsHTML()}</g:link></td>

            </tr>
        </g:if>
        <g:if test="${fixationReportInstance?.solidSpecimen?.id !=null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="fixationReport.solidSpecimen.label" default="Solid Specimen" /></td>

                <td valign="top" class="value"><g:link controller="solidSpecimen" action="show" id="${fixationReportInstance?.solidSpecimen?.id}">${fixationReportInstance?.solidSpecimen?.encodeAsHTML()}</g:link></td>

            </tr>
        </g:if>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.reportDate.label" default="Report Date" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${fixationReportInstance?.reportDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.reportStaff.label" default="Report Staff" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${fixationReportInstance?.reportStaff?.id}">${fixationReportInstance?.reportStaff?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.comments.label" default="Comments" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fixationReportInstance, field: "comments")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.fixationType.label" default="Fixation Type" /></td>
				
				<td valign="top" class="value">${fixationReportInstance?.fixationType?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.fixationStartTime.label" default="Fixation Start Time" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fixationReportInstance, field: "fixationStartTime")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.fixationEndTime.label" default="Fixation End Time" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fixationReportInstance, field: "fixationEndTime")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fixationReport.fixationTimeUnknown.label" default="Fixation Time Unknown" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${fixationReportInstance?.fixationTimeUnknown}" /></td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
