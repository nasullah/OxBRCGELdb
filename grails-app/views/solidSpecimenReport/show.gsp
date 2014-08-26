
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

        <g:if test="${solidSpecimenReportInstance?.derivation?.id !=null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimenReport.derivation.label" default="Derivation" /></td>

                <td valign="top" class="value"><g:link controller="derivation" action="show" id="${solidSpecimenReportInstance?.derivation?.id}">${solidSpecimenReportInstance?.derivation?.encodeAsHTML()}</g:link></td>

            </tr>
        </g:if>

        <g:if test="${solidSpecimenReportInstance?.specimen?.id !=null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimenReport.specimen.label" default="Specimen" /></td>

                <td valign="top" class="value"><g:link controller="specimen" action="show" id="${solidSpecimenReportInstance?.specimen?.id}">${solidSpecimenReportInstance?.specimen?.encodeAsHTML()}</g:link></td>

            </tr>
        </g:if>

        <g:if test="${solidSpecimenReportInstance?.solidSpecimen?.id !=null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimenReport.solidSpecimen.label" default="Solid Specimen" /></td>

                <td valign="top" class="value"><g:link controller="solidSpecimen" action="show" id="${solidSpecimenReportInstance?.solidSpecimen?.id}">${solidSpecimenReportInstance?.solidSpecimen?.encodeAsHTML()}</g:link></td>

            </tr>
        </g:if>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.reportDate.label" default="Report Date" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${solidSpecimenReportInstance?.reportDate}" /></td>
				
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
				<td valign="top" class="name"><g:message code="solidSpecimenReport.sampleSitePhoto.label" default="Sample Site Photo" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenReportInstance, field: "sampleSitePhoto")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.percentageOfTumourInSample.label" default="Percentage Of Tumour In Sample" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenReportInstance, field: "percentageOfTumourInSample")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.cellularity.label" default="Cellularity" /></td>
				
				<td valign="top" class="value">${solidSpecimenReportInstance?.cellularity?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.stage.label" default="Stage" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenReportInstance, field: "stage")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.stagingSystem.label" default="Staging System" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenReportInstance, field: "stagingSystem")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.primaryOrMetastatic.label" default="Primary Or Metastatic" /></td>
				
				<td valign="top" class="value">${solidSpecimenReportInstance?.primaryOrMetastatic?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.dysplasticNonInvasiveElements.label" default="Dysplastic Non Invasive Elements" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${solidSpecimenReportInstance?.dysplasticNonInvasiveElements}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.dysplasticNonInvasiveNotes.label" default="Dysplastic Non Invasive Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenReportInstance, field: "dysplasticNonInvasiveNotes")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.tumourContentVerifiedBy.label" default="Tumour Content Verified By" /></td>
				
				<td valign="top" class="value">${solidSpecimenReportInstance?.tumourContentVerifiedBy?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.tumourContentVerificationOther.label" default="Tumour Content Verification Other" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenReportInstance, field: "tumourContentVerificationOther")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.instrumentsUsedByPathologist.label" default="Instruments Used By Pathologist" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${solidSpecimenReportInstance.instrumentsUsedByPathologist}" var="i">
						<li><g:link controller="instrumentsUsedByPathologist" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.handE_created.label" default="H and E created" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${solidSpecimenReportInstance?.handE_created}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.handE_pathreview.label" default="H and E pathreview" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${solidSpecimenReportInstance?.handE_pathreview}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimenReport.failureReason.label" default="Failure Reason" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenReportInstance, field: "failureReason")}</td>
				
			</tr>

		
		</tbody>
	</table>
</section>
<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="instrumentsUsedByPathologist" action="create" params="['solidSpecimenReport.id': solidSpecimenReportInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'instrumentsUsedByPathologist.label', default: 'Instruments Used By Pathologist')])}</g:link>
    </a></div>
</div>
<hr style="border:1; height:1px" />
</body>

</html>
