
<%@ page import="geldb.SolidSpecimenReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'solidSpecimenReport.label', default: 'Solid Specimen Report')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-solidSpecimenReport" class="first">

	<table class="table">
		<tbody>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimenReport.solidSpecimen.label" default="Solid Specimen" /></td>

                <td valign="top" class="value"><g:link controller="solidSpecimen" action="show" id="${solidSpecimenReportInstance?.solidSpecimen?.id}">${solidSpecimenReportInstance?.solidSpecimen?.encodeAsHTML()}</g:link></td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.reportDate.label" default="Report Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${solidSpecimenReportInstance?.reportDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.reportStaff.label" default="Report Staff" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${solidSpecimenReportInstance?.reportStaff?.id}">${solidSpecimenReportInstance?.reportStaff?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.comments.label" default="Comments" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenReportInstance, field: "comments")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.stage.label" default="Stage" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenReportInstance, field: "stage")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.stagingSystem.label" default="Staging System" /></td>
				
				<td valign="top" class="value"><g:link controller="stagingSystem" action="show" id="${solidSpecimenReportInstance?.stagingSystem?.id}">${solidSpecimenReportInstance?.stagingSystem?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.primaryOrMetastatic.label" default="Primary Or Metastatic" /></td>
				
				<td valign="top" class="value">${solidSpecimenReportInstance?.primaryOrMetastatic?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.handE_created.label" default="H and E created" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${solidSpecimenReportInstance?.handE_created}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.handE_pathreview.label" default="H and E path review" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${solidSpecimenReportInstance?.handE_pathreview}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.vascularClampingTimeAtSurgery.label" default="Vascular Clamping Time At Surgery" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenReportInstance, field: "vascularClampingTimeAtSurgery")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.warmIschemiaTimeIfClampingNotKnown.label" default="Warm Ischemia Time If Clamping Not Known" /></td>
				
				<td valign="top" class="value">${solidSpecimenReportInstance?.warmIschemiaTimeIfClampingNotKnown?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.postmortem.label" default="Postmortem" /></td>
				
				<td valign="top" class="value"><g:link controller="postmortem" action="show" id="${solidSpecimenReportInstance?.postmortem?.id}">${solidSpecimenReportInstance?.postmortem?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.samplePhoto.label" default="Sample Photo" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${solidSpecimenReportInstance.samplePhoto}" var="s">
						<li><g:link controller="samplePhoto" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>
<g:if test="${!solidSpecimenReportInstance.postmortem}">
<hr style="border:1; height:1px" />
    <div class="one-to-many">
        <div><a class='btn btn-primary btn-small' <g:link controller="postmortem" action="create" params="['solidSpecimenReport.id': solidSpecimenReportInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'postmortem.label', default: 'Postmortem')])}</g:link>
        </a></div>
    </div>
</g:if>
<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="samplePhoto" action="create" params="['solidSpecimenReport.id': solidSpecimenReportInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'samplePhoto.label', default: 'Sample Photo')])}</g:link>
    </a></div>
</div>
<hr style="border:1; height:1px" />
</body>

</html>
