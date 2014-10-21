
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
                <td valign="top" class="name"><g:message code="solidSpecimen.histologyNumber.label" default="Histology Number" /></td>

                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "histologyNumber")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimen.tumourType.label" default="Tumour Type" /></td>

                <td valign="top" class="value"><g:link controller="tumourType" action="show" id="${solidSpecimenInstance?.tumourType?.id}">${solidSpecimenInstance?.tumourType?.encodeAsHTML()}</g:link></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimen.sampleType.label" default="Sample Type" /></td>

                <td valign="top" class="value"><g:link controller="collectionMethod" action="show" id="${solidSpecimenInstance?.sampleType?.id}">${solidSpecimenInstance?.sampleType?.encodeAsHTML()}</g:link></td>

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
				<td valign="top" class="name"><g:message code="solidSpecimen.passFailReason.label" default="Pass Fail Reason" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "passFailReason")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.notes.label" default="Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "notes")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.collectionDate.label" default="Collection Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${solidSpecimenInstance?.collectionDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.collectionTime.label" default="Collection Time" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "collectionTime")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.collectionLocation.label" default="Collection Location" /></td>
				
				<td valign="top" class="value"><g:link controller="location" action="show" id="${solidSpecimenInstance?.collectionLocation?.id}">${solidSpecimenInstance?.collectionLocation?.encodeAsHTML()}</g:link></td>
				
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
				<td valign="top" class="name"><g:message code="solidSpecimen.surgeon.label" default="Surgeon" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${solidSpecimenInstance?.surgeon?.id}">${solidSpecimenInstance?.surgeon?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.pathologist.label" default="Pathologist" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${solidSpecimenInstance?.pathologist?.id}">${solidSpecimenInstance?.pathologist?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.anatomicalSite.label" default="Anatomical Site" /></td>
				
				<td valign="top" class="value"><g:link controller="anatomicalSite" action="show" id="${solidSpecimenInstance?.anatomicalSite?.id}">${solidSpecimenInstance?.anatomicalSite?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.methodOfTransportToPathologist.label" default="Method Of Transport To Pathologist" /></td>
				
				<td valign="top" class="value"><g:link controller="methodOfTransport" action="show" id="${solidSpecimenInstance?.methodOfTransportToPathologist?.id}">${solidSpecimenInstance?.methodOfTransportToPathologist?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.specimenWeight.label" default="Specimen Weight" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "specimenWeight")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.massUnit.label" default="Mass Unit" /></td>
				
				<td valign="top" class="value"><g:link controller="units" action="show" id="${solidSpecimenInstance?.massUnit?.id}">${solidSpecimenInstance?.massUnit?.encodeAsHTML()}</g:link></td>
				
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
				<td valign="top" class="name"><g:message code="solidSpecimen.fixationReport.label" default="Fixation Report" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${solidSpecimenInstance.fixationReport}" var="f">
						<li><g:link controller="fixationReport" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.solidSpecimenReport.label" default="Solid Specimen Report" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${solidSpecimenInstance.solidSpecimenReport}" var="s">
						<li><g:link controller="solidSpecimenReport" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
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

<g:if test="${!solidSpecimenInstance.fixationReport}">
    <hr style="border:1; height:1px" />
    <div class="one-to-many">
        <div><a class='btn btn-primary btn-small' <g:link controller="fixationReport" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'fixationReport.label', default: 'Fixation Report')])}</g:link>
        </a></div>
    </div>
</g:if>
<g:if test="${!solidSpecimenInstance.solidSpecimenReport}">
    <hr style="border:1; height:1px" />
    <div class="one-to-many">
        <div><a class='btn btn-primary btn-small' <g:link controller="solidSpecimenReport" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'solidSpecimenReport.label', default: 'Solid Specimen Report')])}</g:link>
        </a></div>
    </div>
</g:if>

<hr style="border:1; height:1px" />
</body>

</html>
