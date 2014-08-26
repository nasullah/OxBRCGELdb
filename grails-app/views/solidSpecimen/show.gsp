
<%@ page import="geldb.SolidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'solidSpecimen.label', default: 'Solid Specimen')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-solidSpecimen" class="first">

	<table class="table">
		<tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimen.participant.label" default="Participant" /></td>

                <td valign="top" class="value"><g:link controller="participant" action="show" id="${solidSpecimenInstance?.participant?.id}">${solidSpecimenInstance?.participant?.encodeAsHTML()}</g:link></td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.localIdentifier.label" default="Local Identifier" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "localIdentifier")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.size.label" default="Size" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "size")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.unit.label" default="Unit" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "unit")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.exhausted.label" default="Exhausted" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${solidSpecimenInstance?.exhausted}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.passFail.label" default="Pass Fail" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${solidSpecimenInstance?.passFail}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.notes.label" default="Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "notes")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.histologyNumber.label" default="Histology Number" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "histologyNumber")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.collectionDate.label" default="Collection Date" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${solidSpecimenInstance?.collectionDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.collectionTime.label" default="Collection Time" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "collectionTime")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.collectionLocation.label" default="Collection Location" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "collectionLocation")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.collectedBy.label" default="Collected By" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${solidSpecimenInstance?.collectedBy?.id}">${solidSpecimenInstance?.collectedBy?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.preparedBy.label" default="Prepared By" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${solidSpecimenInstance?.preparedBy?.id}">${solidSpecimenInstance?.preparedBy?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.sampleType.label" default="Sample Type" /></td>
				
				<td valign="top" class="value">${solidSpecimenInstance?.sampleType?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.anatomicSite.label" default="Anatomic Site" /></td>
				
				<td valign="top" class="value">${solidSpecimenInstance?.anatomicSite?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.collectionMethod.label" default="Collection Method" /></td>
				
				<td valign="top" class="value">${solidSpecimenInstance?.collectionMethod?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.vasculerClampingTimeAtSurgery.label" default="Vasculer Clamping Time At Surgery" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "vasculerClampingTimeAtSurgery")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.warmIschemiaTimeIfClampingNotKnown.label" default="Warm Ischemia Time If Clamping Not Known" /></td>
				
				<td valign="top" class="value">${solidSpecimenInstance?.warmIschemiaTimeIfClampingNotKnown?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.methodOfTransportToPathologist.label" default="Method Of Transport To Pathologist" /></td>
				
				<td valign="top" class="value">${solidSpecimenInstance?.methodOfTransportToPathologist?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.fixationReport.label" default="Fixation Report" /></td>
				
				<td valign="top" class="value"><g:link controller="fixationReport" action="show" id="${solidSpecimenInstance?.fixationReport?.id}">${solidSpecimenInstance?.fixationReport?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.solidSpecimenReport.label" default="Solid Specimen Report" /></td>
				
				<td valign="top" class="value"><g:link controller="solidSpecimenReport" action="show" id="${solidSpecimenInstance?.solidSpecimenReport?.id}">${solidSpecimenInstance?.solidSpecimenReport?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.aliquot.label" default="Aliquot" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${solidSpecimenInstance.aliquot}" var="a">
						<li><g:link controller="aliquot" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.postmortem.label" default="Postmortem" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${solidSpecimenInstance.postmortem}" var="p">
						<li><g:link controller="postmortem" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.report.label" default="Report" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${solidSpecimenInstance.report}" var="r">
						<li><g:link controller="report" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.trackingEvent.label" default="Tracking Event" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${solidSpecimenInstance.trackingEvent}" var="t">
						<li><g:link controller="sampleTrackingEvent" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>
<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="aliquot" action="create" params="['specimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Aliquot')])}</g:link>
    </a></div>
</div>
%{--<hr style="border:1; height:1px" />--}%
%{--<div class="one-to-many">--}%
%{--<div><a class='btn btn-primary btn-small' <g:link controller="sampleTrackingEvent" action="create" params="['specimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sampleTrackingEvent.label', default: 'Sample Tracking Event')])}</g:link>--}%
%{--</a></div>--}%
%{--</div>--}%
<g:if test="${solidSpecimenInstance?.fixationReport?.id ==null}">
    <hr style="border:1; height:1px" />
    <div class="one-to-many">
        <div><a class='btn btn-primary btn-small' <g:link controller="fixationReport" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'fixationReport.label', default: 'Fixation Report')])}</g:link>
        </a></div>
    </div>
</g:if>
<g:if test="${solidSpecimenInstance?.solidSpecimenReport?.id ==null}">
    <hr style="border:1; height:1px" />
    <div class="one-to-many">
        <div><a class='btn btn-primary btn-small' <g:link controller="solidSpecimenReport" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'solidSpecimenReport.label', default: 'Solid Specimen Report')])}</g:link>
        </a></div>
    </div>
</g:if>
<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="postmortem" action="create" params="['specimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'postmortem.label', default: 'Postmortem')])}</g:link>
    </a></div>
</div>
<hr style="border:1; height:1px" />
</body>

</html>
