
<%@ page import="geldb.Specimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'specimen.label', default: 'Specimen')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-specimen" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.localIdentifier.label" default="Local Identifier" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: specimenInstance, field: "localIdentifier")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.size.label" default="Size" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: specimenInstance, field: "size")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.unit.label" default="Unit" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: specimenInstance, field: "unit")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.exhausted.label" default="Exhausted" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${specimenInstance?.exhausted}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.passFail.label" default="Pass Fail" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${specimenInstance?.passFail}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.notes.label" default="Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: specimenInstance, field: "notes")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.participant.label" default="Participant" /></td>
				
				<td valign="top" class="value"><g:link controller="participant" action="show" id="${specimenInstance?.participant?.id}">${specimenInstance?.participant?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.histologyNumber.label" default="Histology Number" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: specimenInstance, field: "histologyNumber")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.collectionDate.label" default="Collection Date" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${specimenInstance?.collectionDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.collectionTime.label" default="Collection Time" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: specimenInstance, field: "collectionTime")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.collectionLocation.label" default="Collection Location" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: specimenInstance, field: "collectionLocation")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.collectedBy.label" default="Collected By" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${specimenInstance?.collectedBy?.id}">${specimenInstance?.collectedBy?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.preparedBy.label" default="Prepared By" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${specimenInstance?.preparedBy?.id}">${specimenInstance?.preparedBy?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.sampleType.label" default="Sample Type" /></td>
				
				<td valign="top" class="value">${specimenInstance?.sampleType?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.aliquot.label" default="Aliquot" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${specimenInstance.aliquot}" var="a">
						<li><g:link controller="aliquot" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.postmortem.label" default="Postmortem" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${specimenInstance.postmortem}" var="p">
						<li><g:link controller="postmortem" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.report.label" default="Report" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${specimenInstance.report}" var="r">
						<li><g:link controller="report" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="specimen.trackingEvent.label" default="Tracking Event" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${specimenInstance.trackingEvent}" var="t">
						<li><g:link controller="sampleTrackingEvent" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
