
<%@ page import="geldb.DNA_Extract" %>
<%@ page import="geldb.DispatchItem" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNA_Extract.label', default: 'DNA/RNA Extract')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-DNA_Extract" class="first">

	<table class="table">
		<tbody>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="DNA_Extract.aliquot.label" default="Aliquot" /></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${DNA_ExtractInstance.aliquot}" var="a">
                            <li><g:link controller="aliquot" action="show" id="${a.id.toString().replace('%5B','').replace('%5D','')}">${a?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="DNA_Extract.extractionType.label" default="Extraction Type" /></td>

                <td valign="top" class="value"><g:link controller="extractionType" action="show" id="${DNA_ExtractInstance?.extractionType?.id}">${DNA_ExtractInstance?.extractionType?.encodeAsHTML()}</g:link></td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Extract.exhausted.label" default="Exhausted" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${DNA_ExtractInstance?.exhausted}" true="Yes" false="No"/></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Extract.passFail.label" default="Pass/Fail" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${DNA_ExtractInstance?.passFail}" true="Pass" false="Fail"/></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Extract.passFailReason.label" default="Pass Fail Reason" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "passFailReason")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Extract.notes.label" default="Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "notes")}</td>
				
			</tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="DNA_Extract.dNAConcentrationNanodrop.label" default="DNA/RNA Concentration (Nanodrop- ng/ul)" /></td>

                <td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "dNAConcentrationNanodrop")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="DNA_Extract.dNAConcentrationQubit.label" default="DNA/RNA Concentration (Qubit- ng/ul)" /></td>

                <td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "dNAConcentrationQubit")}</td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Extract.extractionDate.label" default="Extraction Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${DNA_ExtractInstance?.extractionDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Extract.extractedBy.label" default="Extracted By" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${DNA_ExtractInstance?.extractedBy?.id}">${DNA_ExtractInstance?.extractedBy?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="DNA_Extract.geLSampleIdentifier.label" default="GeL Sample Identifier/DNA Elution" /></td>--}%
				%{----}%
				%{--<td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "geLSampleIdentifier")}</td>--}%
				%{----}%
			%{--</tr>--}%

            <tr class="prop">
                <td valign="top" class="name"><g:message code="DNA_Extract.sapphireIdentifier.label" default="DNA/RNA Elution" /></td>

                <td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "sapphireIdentifier")}</td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Extract.extractionKit.label" default="DNA/RNA Extraction Kit" /></td>

                <td valign="top" class="value"><g:link controller="DNAExtractionKit" action="show" id="${DNA_ExtractInstance?.extractionKit?.id}">${DNA_ExtractInstance?.extractionKit?.encodeAsHTML()}</g:link></td>
				
			</tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="DNA_Extract.experimentName.label" default="Experiment Name" /></td>

                <td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "experimentName")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="DNA_Extract.dNAAmount.label" default="DNA/RNA Volume (ul)" /></td>

                <td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "dNAAmount")}</td>

            </tr>

            <g:if test="${DNA_ExtractInstance?.extractionType?.extractionTypeName == 'DNA Extraction'}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="DNA_Extract.delatQC.label" default="Delta QC" /></td>

                    <td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "delatQC")}</td>

                </tr>
            </g:if>

            <g:if test="${DNA_ExtractInstance?.extractionType?.extractionTypeName == 'RNA Extraction'}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="DNA_Extract.rin.label" default="RIN" /></td>

                    <td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "rin")}</td>

                </tr>
            </g:if>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="DNA_Extract.a260A280.label" default="A260A280" /></td>

                <td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "a260A280")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="DNA_Extract.a260A230.label" default="A260A230" /></td>

                <td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "a260A230")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="DNA_Extract.barcode.label" default="Barcode" /></td>

                <td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "barcode")}</td>

            </tr>

            <g:if test="${DNA_ExtractInstance.position}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="DNA_Extract.position.label" default="Position" /></td>

                    <td valign="top" class="value"><g:link controller="position" action="show" id="${DNA_ExtractInstance?.position?.id}">${DNA_ExtractInstance?.position?.encodeAsHTML()}</g:link></td>

                </tr>
            </g:if>

            <g:if test="${DNA_ExtractInstance.sampleTrackingEvent}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="DNA_Extract.sampleTrackingEvent.label" default="Sample Tracking Event" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <ul>
                            <g:each in="${DNA_ExtractInstance.sampleTrackingEvent}" var="t">
                                <li><g:link controller="sampleTrackingEvent" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
                            </g:each>
                        </ul>
                    </td>

                </tr>
            </g:if>

            <g:if test="${DNA_ExtractInstance.dNA_Library}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="DNA_Extract.dNA_Library.label" default="DNA Library" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <ul>
                        <g:each in="${DNA_ExtractInstance.dNA_Library}" var="d">
                            <li><g:link controller="DNA_Library" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
                        </g:each>
                        </ul>
                    </td>

                </tr>
            </g:if>

            <tr class="prop">
                <td valign="top" class="name"> Dispatched</td>

                <td valign="top" style="text-align: left;" class="value">
                    <% def dispatchItem = DispatchItem?.listOrderById() %>
                    <g:each in="${dispatchItem}" var="item">
                        <g:if test="${item.identifiedSample.id == DNA_ExtractInstance.id}">
                            <g:link controller="dispatchRecord" action="show" id="${item.dispatchedBox.dispatchRecord.id}">${item.dispatchedBox.dispatchRecord}</g:link>
                        </g:if>
                    </g:each>
                </td>

            </tr>
		
		</tbody>
	</table>
</section>

<hr style="border:1; height:1px" />

<p class="text-primary">Available Action</p>

<g:if test="${DNA_ExtractInstance?.position?.id == null}">
    <a class='btn btn-primary btn-small' <g:link controller="position" action="create" params="['containedSamples': DNA_ExtractInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'position.label', default: 'Position')])}</g:link>
</g:if>
<% def elution = DNA_ExtractInstance?.sapphireIdentifier?.toString()?.split('_')
def duplicatedElution = null
if(elution.length > 1){
    duplicatedElution = elution[0] + '_' + elution[1] +'_'
}
%>

<a class='btn btn-primary btn-small' <g:link controller="DNA_Extract" action="create" params="['aliquot': DNA_ExtractInstance?.aliquot?.id,'exhausted': DNA_ExtractInstance?.exhausted,'passFail': DNA_ExtractInstance?.passFail,
                                                                                                       'passFailReason': DNA_ExtractInstance?.passFailReason,'notes': DNA_ExtractInstance?.notes,'extractionType':DNA_ExtractInstance?.extractionType?.id,
                                                                                                       'extractionDate': DNA_ExtractInstance?.extractionDate, 'extractedBy': DNA_ExtractInstance?.extractedBy?.id, 'geLSampleIdentifier': DNA_ExtractInstance?.geLSampleIdentifier, 'extractionKit':DNA_ExtractInstance?.extractionKit?.id,
                                                                                                       'experimentName': DNA_ExtractInstance?.experimentName,'delatQC':DNA_ExtractInstance?.delatQC,'sapphireIdentifier':duplicatedElution
                                                                                                       ]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Duplicate DNA/RNA Extract')])}</g:link>

<hr style="border:1; height:1px" />

</body>

</html>
