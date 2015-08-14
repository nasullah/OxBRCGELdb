
<%@ page import="geldb.IdentifiedSample; geldb.DispatchItem; geldb.FluidSpecimen" %>
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
                <td valign="top" class="name"><g:message code="fluidSpecimen.fluidSampleType.label" default="Fluid Sample Type" /></td>

                <td valign="top" class="value">${fluidSpecimenInstance?.fluidSampleType?.encodeAsHTML()}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="fluidSpecimen.primaryContainer.label" default="Primary Container" /></td>

                <td valign="top" class="value">${fluidSpecimenInstance?.primaryContainer?.encodeAsHTML()}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="fluidSpecimen.barcode.label" default="Barcode" /></td>

                <td valign="top" class="value">${fieldValue(bean: fluidSpecimenInstance, field: "barcode")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="fluidSpecimen.timePoint.label" default="Time Point" /></td>

                <td valign="top" class="value">${fieldValue(bean: fluidSpecimenInstance, field: "timePoint")}</td>

            </tr>

			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.exhausted.label" default="Exhausted" /></td>
				
                <g:if test="${fluidSpecimenInstance.exhausted == null}">
                    <td valign="top" class="value"><p class="text-danger">Not completed</p></td>
                </g:if>
                <g:else >
                    <td valign="top" class="value"><g:formatBoolean boolean="${fluidSpecimenInstance?.exhausted}" true="Yes" false="No"/></td>
                </g:else>
			</tr>
		
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="fluidSpecimen.passFail.label" default="Pass/Fail" /></td>--}%
				%{----}%
				%{--<td valign="top" class="value"><g:formatBoolean boolean="${fluidSpecimenInstance?.passFail}" true="Pass" false="Fail"/></td>--}%
				%{----}%
			%{--</tr>--}%
		%{----}%
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="fluidSpecimen.passFailReason.label" default="Pass Fail Reason" /></td>--}%
				%{----}%
				%{--<td valign="top" class="value">${fieldValue(bean: fluidSpecimenInstance, field: "passFailReason")}</td>--}%
				%{----}%
			%{--</tr>--}%
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.notes.label" default="Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fluidSpecimenInstance, field: "notes")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.collectionDate.label" default="Collection Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${fluidSpecimenInstance?.collectionDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.collectionTime.label" default="Collection Time" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: fluidSpecimenInstance, field: "collectionTime")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.collectionLocation.label" default="Collection Location" /></td>
				
				<td valign="top" class="value"><g:link controller="location" action="show" id="${fluidSpecimenInstance?.collectionLocation?.id}">${fluidSpecimenInstance?.collectionLocation?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.collectedBy.label" default="Collected By" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${fluidSpecimenInstance?.collectedBy?.id}">${fluidSpecimenInstance?.collectedBy?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="fluidSpecimen.preparedBy.label" default="Prepared By" /></td>--}%
				%{----}%
				%{--<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${fluidSpecimenInstance?.preparedBy?.id}">${fluidSpecimenInstance?.preparedBy?.encodeAsHTML()}</g:link></td>--}%
				%{----}%
			%{--</tr>--}%
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.fluidSpecimenVolume.label" default="Fluid Specimen Volume" /></td>
				
                <g:if test="${fluidSpecimenInstance.fluidSpecimenVolume == 0}">
                    <td valign="top" class="value"><p class="text-danger">Not completed</p></td>
                </g:if>
                <g:else >
                    <td valign="top" class="value">${fieldValue(bean: fluidSpecimenInstance, field: "fluidSpecimenVolume")}</td>
                </g:else>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="fluidSpecimen.volumeUnit.label" default="Volume Unit" /></td>
				
				<td valign="top" class="value"><g:link controller="units" action="show" id="${fluidSpecimenInstance?.volumeUnit?.id}">${fluidSpecimenInstance?.volumeUnit?.encodeAsHTML()}</g:link></td>
				
			</tr>

            <g:if test="${fluidSpecimenInstance.postmortem}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="fluidSpecimen.postmortem.label" default="Postmortem" /></td>

                    <td valign="top" class="value"><g:link controller="postmortem" action="show" id="${fluidSpecimenInstance?.postmortem?.id}">${fluidSpecimenInstance?.postmortem?.encodeAsHTML()}</g:link></td>

                </tr>
            </g:if>

            <g:if test="${fluidSpecimenInstance.position}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="fluidSpecimen.position.label" default="Position" /></td>

                    <td valign="top" class="value"><g:link controller="position" action="show" id="${fluidSpecimenInstance?.position?.id}">${fluidSpecimenInstance?.position?.encodeAsHTML()}</g:link></td>

                </tr>
		    </g:if>

            <g:if test="${fluidSpecimenInstance.aliquot}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="fluidSpecimen.aliquot.label" default="Aliquot" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <ul>
                        <g:each in="${fluidSpecimenInstance.aliquot}" var="a">
                            <li><g:link controller="aliquot" action="show" id="${a.id.toString().replace('%5B','').replace('%5D','')}">${a?.encodeAsHTML()}</g:link></li>
                        </g:each>
                        </ul>
                    </td>

                </tr>
            </g:if>

            <g:if test="${fluidSpecimenInstance.sampleTrackingEvent}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="fluidSpecimen.sampleTrackingEvent.label" default="Sample Tracking Event" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <ul>
                        <g:each in="${fluidSpecimenInstance.sampleTrackingEvent}" var="t">
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
                            %{--<g:if test="${item.identifiedSample.id == fluidSpecimenInstance.id}">--}%
                                %{--<li><g:link controller="dispatchItem" action="show" id="${item.id}">${item?.encodeAsHTML()}</g:link></li>--}%
                            %{--</g:if>--}%
                        %{--</g:each>--}%
                    %{--</ul>--}%
                %{--</td>--}%

            %{--</tr>--}%
		
		</tbody>
	</table>
</section>

<hr style="border:1; height:1px" />

<p class="text-primary">Available Actions</p>

<a class='btn btn-primary btn-small' <g:link controller="fluidSpecimen" action="create" params="['participant': fluidSpecimenInstance?.participant?.id,'exhausted': fluidSpecimenInstance?.exhausted,'fluidSampleType': fluidSpecimenInstance?.fluidSampleType?.getKey(),
                                                                                                         'primaryContainer': fluidSpecimenInstance?.primaryContainer?.getKey(),'notes': fluidSpecimenInstance?.notes,'collectionLocation': fluidSpecimenInstance?.collectionLocation?.id, 'fluidSpecimenVolume':'0',
                                                                                                         'collectionDate': fluidSpecimenInstance?.collectionDate,'collectionTime': fluidSpecimenInstance?.collectionTime,'collectedBy': fluidSpecimenInstance?.collectedBy?.id, 'timePoint':fluidSpecimenInstance?.timePoint,
                                                                                                         'volumeUnit': fluidSpecimenInstance?.volumeUnit?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'fluidSpecimen.label', default: 'Duplicate Fluid Specimen')])}</g:link>

<g:if test="${!fluidSpecimenInstance.postmortem}">
    <a class='btn btn-primary btn-small' <g:link controller="postmortem" action="create" params="['specimen.id': fluidSpecimenInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'postmortem.label', default: 'Postmortem')])}</g:link>
</g:if>

<hr style="border:1; height:1px" />
</body>

</html>
