
<%@ page import="geldb.SolidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'solidSpecimen.label', default: 'Main Specimen')}" />
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
                <td valign="top" class="name"><g:message code="solidSpecimen.collectionMethod.label" default="Collection Method" /></td>

                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "collectionMethod")}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimen.anatomicalSite.label" default="Anatomical Site" /></td>

                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "anatomicalSite")}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimen.barcode.label" default="Barcode" /></td>

                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "barcode")}</td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.exhausted.label" default="Exhausted" /></td>
				
                <g:if test="${solidSpecimenInstance.exhausted == null}">
                    <td valign="top" class="value"><p class="text-danger">Not completed</p></td>
                </g:if>
                <g:else >
                    <td valign="top" class="value"><g:formatBoolean boolean="${solidSpecimenInstance?.exhausted}" true="Yes" false="No"/></td>
                </g:else>
			</tr>
		
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="solidSpecimen.passFail.label" default="Pass/Fail" /></td>--}%
				%{----}%
				%{--<td valign="top" class="value"><g:formatBoolean boolean="${solidSpecimenInstance?.passFail}" true="Pass" false="Fail" /></td>--}%
				%{----}%
			%{--</tr>--}%
		%{----}%
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="solidSpecimen.passFailReason.label" default="Pass Fail Reason" /></td>--}%
				%{----}%
				%{--<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "passFailReason")}</td>--}%
				%{----}%
			%{--</tr>--}%
		
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
				
                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "collectionLocation")}</td>
			</tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimen.methodOfTransportToPathologist.label" default="Method Of Transport To Pathologist" /></td>

                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "methodOfTransportToPathologist")}</td>
            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.collectedBy.label" default="Collected By" /></td>
				
                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "collectedBy")}</td>
			</tr>
		
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="solidSpecimen.preparedBy.label" default="Prepared By" /></td>--}%
				%{----}%
				%{--<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${solidSpecimenInstance?.preparedBy?.id}">${solidSpecimenInstance?.preparedBy?.encodeAsHTML()}</g:link></td>--}%
				%{----}%
			%{--</tr>--}%
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.surgeon.label" default="Surgeon" /></td>
				
                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "surgeon")}</td>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.pathologist.label" default="Pathologist" /></td>
				
                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "pathologist")}</td>
			</tr>

            <g:if test="${solidSpecimenInstance?.collectionMethod?.collectionMethodName == 'Biopsy'}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="solidSpecimen. numberOfBiopsies.label" default="Number of Biopsies" /></td>

                    <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "numberOfBiopsies")}</td>
                </tr>
            </g:if>
		
			<tr class="prop">
                <g:if test="${solidSpecimenInstance?.collectionMethod?.collectionMethodName == 'Biopsy'}">
                    <td valign="top" class="name"><g:message code="solidSpecimen.specimenWeight.label" default="Gauge of Biopsies (mm)" /></td>
                </g:if>
                <g:else >
                    <td valign="top" class="name"><g:message code="solidSpecimen.specimenWeight.label" default="Specimen Weight" /></td>
                </g:else>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "specimenWeight")}</td>
				
			</tr>

            <g:if test="${solidSpecimenInstance?.collectionMethod?.collectionMethodName != 'Biopsy'}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="solidSpecimen.massUnit.label" default="Unit" /></td>

                    <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "massUnit")}</td>
                </tr>
            </g:if>

            <g:if test="${solidSpecimenInstance.postmortem}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="solidSpecimen.postmortem.label" default="Postmortem" /></td>

                    <td valign="top" class="value"><g:link controller="postmortem" action="show" id="${solidSpecimenInstance?.postmortem?.id}">${solidSpecimenInstance?.postmortem?.encodeAsHTML()}</g:link></td>

                </tr>
            </g:if>

            <g:if test="${solidSpecimenInstance.position}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="solidSpecimen.position.label" default="Position" /></td>

                    <td valign="top" class="value"><g:link controller="position" action="show" id="${solidSpecimenInstance?.position?.id}">${solidSpecimenInstance?.position?.encodeAsHTML()}</g:link></td>

                </tr>
            </g:if>

            <g:if test="${solidSpecimenInstance.fFPE_Tissue_Report}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="solidSpecimen.fFPE_Tissue_Report.label" default="Main Specimen Report" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <ul>
                            <g:each in="${solidSpecimenInstance.fFPE_Tissue_Report}" var="f">
                                <li><g:link controller="FFPE_Tissue_Report" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                            </g:each>
                        </ul>
                    </td>

                </tr>
            </g:if>

            <g:if test="${solidSpecimenInstance.aliquot}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="solidSpecimen.aliquot.label" default="Aliquot" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <ul>
                        <g:each in="${solidSpecimenInstance.aliquot}" var="a">
                            <li><g:link controller="aliquot" action="show" id="${a.id.toString().replace('%5B','').replace('%5D','')}">${a?.encodeAsHTML()}</g:link></li>
                        </g:each>
                        </ul>
                    </td>

                </tr>
            </g:if>

            <g:if test="${solidSpecimenInstance.sampleTrackingEvent}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="solidSpecimen.sampleTrackingEvent.label" default="Sample Tracking Event" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <ul>
                        <g:each in="${solidSpecimenInstance.sampleTrackingEvent}" var="t">
                            <li><g:link controller="sampleTrackingEvent" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
                        </g:each>
                        </ul>
                    </td>

                </tr>
            </g:if>

            %{--<tr class="prop">--}%
                %{--<td valign="top" class="name"> Dispatched</td>--}%

                %{--<td valign="top" style="text-align: left;" class="value">--}%
                    %{--<% def dispatchItem = DispatchItem?.listOrderById() %>--}%
                    %{--<ul>--}%
                        %{--<g:each in="${dispatchItem}" var="item">--}%
                            %{--<g:if test="${item.identifiedSample.id == solidSpecimenInstance.id}">--}%
                                %{--<li><g:link controller="dispatchItem" action="show" id="${item.id}">${item?.encodeAsHTML()}</g:link></li>--}%
                            %{--</g:if>--}%
                        %{--</g:each>--}%
                    %{--</ul>--}%
                %{--</td>--}%

            %{--</tr>--}%
		
		</tbody>
	</table>
</section>

<hr/>

<p class="text-primary">Available Actions</p>

<g:if test="${!solidSpecimenInstance.fFPE_Tissue_Report}">
        <a class='btn btn-primary btn-small' <g:link controller="FFPE_Tissue_Report" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'fFPE_Tissue_Report.label', default: 'Main Specimen Report')])}</g:link>
</g:if>

%{--<g:if test="${!solidSpecimenInstance.postmortem}">--}%
        %{--<a class='btn btn-primary btn-small' <g:link controller="postmortem" action="create" params="['specimen.id': solidSpecimenInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'postmortem.label', default: 'Postmortem')])}</g:link>--}%
%{--</g:if>--}%

<hr/>
</body>

</html>
