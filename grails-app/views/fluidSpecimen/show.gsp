
<%@ page import="geldb.FluidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'fluidSpecimen.label', default: 'Fluid Specimen')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-fluidSpecimen" class="first">

	<table class="table">
		<tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="fluidSpecimen.participant.label" default="Participant" /></td>

                <td valign="top" class="value"><g:link controller="participant" action="show" id="${fluidSpecimenInstance?.participant?.id}">${fluidSpecimenInstance?.participant?.encodeAsHTML()}</g:link></td>

            </tr>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.localIdentifier.label" default="Local Identifier" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fluidSpecimenInstance, field: "localIdentifier")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.size.label" default="Size" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fluidSpecimenInstance, field: "size")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.unit.label" default="Unit" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fluidSpecimenInstance, field: "unit")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.exhausted.label" default="Exhausted" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${fluidSpecimenInstance?.exhausted}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.passFail.label" default="Pass Fail" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${fluidSpecimenInstance?.passFail}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.notes.label" default="Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fluidSpecimenInstance, field: "notes")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.histologyNumber.label" default="Histology Number" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fluidSpecimenInstance, field: "histologyNumber")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.collectionDate.label" default="Collection Date" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${fluidSpecimenInstance?.collectionDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.collectionTime.label" default="Collection Time" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fluidSpecimenInstance, field: "collectionTime")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.collectionLocation.label" default="Collection Location" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fluidSpecimenInstance, field: "collectionLocation")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.collectedBy.label" default="Collected By" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${fluidSpecimenInstance?.collectedBy?.id}">${fluidSpecimenInstance?.collectedBy?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.preparedBy.label" default="Prepared By" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${fluidSpecimenInstance?.preparedBy?.id}">${fluidSpecimenInstance?.preparedBy?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.sampleType.label" default="Sample Type" /></td>
				
				<td valign="top" class="value">${fluidSpecimenInstance?.sampleType?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.primaryContainerType.label" default="Primary Container Type" /></td>
				
				<td valign="top" class="value">${fluidSpecimenInstance?.primaryContainerType?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.aliquot.label" default="Aliquot" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${fluidSpecimenInstance.aliquot}" var="a">
						<li><g:link controller="aliquot" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.postmortem.label" default="Postmortem" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${fluidSpecimenInstance.postmortem}" var="p">
						<li><g:link controller="postmortem" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.report.label" default="Report" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${fluidSpecimenInstance.report}" var="r">
						<li><g:link controller="report" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.trackingEvent.label" default="Tracking Event" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${fluidSpecimenInstance.trackingEvent}" var="t">
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
    <div><a class='btn btn-primary btn-small' <g:link controller="aliquot" action="create" params="['specimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Aliquot')])}</g:link>
    </a></div>
</div>

    <hr style="border:1; height:1px" />
     <div class="one-to-many">
        <div><a class='btn btn-primary btn-small' <g:link controller="report" action="create" params="['specimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'fixationReport.label', default: 'Report')])}</g:link>
        </a></div>
    </div>

<hr style="border:1; height:1px" />

<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="postmortem" action="create" params="['specimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'postmortem.label', default: 'Postmortem')])}</g:link>
    </a></div>
</div>
<hr style="border:1; height:1px" />
%{--<div class="one-to-many">--}%
    %{--<div><a class='btn btn-primary btn-small' <g:link controller="sampleTrackingEvent" action="create" params="['specimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sampleTrackingEvent.label', default: 'Sample Tracking Event')])}</g:link>--}%
    %{--</a></div>--}%
%{--</div>--}%
%{--<hr style="border:1; height:1px" />--}%
</body>

</html>
