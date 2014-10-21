
<%@ page import="geldb.DNA_Extract" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNA_Extract.label', default: 'DNA Extract')}" />
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
                            <li><g:link controller="aliquot" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Extract.exhausted.label" default="Exhausted" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${DNA_ExtractInstance?.exhausted}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Extract.passFail.label" default="Pass Fail" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${DNA_ExtractInstance?.passFail}" /></td>
				
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
				<td valign="top" class="name"><g:message code="DNA_Extract.dNAConcentration.label" default="DNA Concentration" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "dNAConcentration")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Extract.extractionDate.label" default="Extraction Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${DNA_ExtractInstance?.extractionDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Extract.extractedBy.label" default="Extracted By" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${DNA_ExtractInstance?.extractedBy?.id}">${DNA_ExtractInstance?.extractedBy?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Extract.geLSampleIdentifier.label" default="GeL Sample Identifier" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "geLSampleIdentifier")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Extract.dNAExtractionKit.label" default="DNA Extraction Kit" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_ExtractInstance, field: "dNAExtractionKit")}</td>
				
			</tr>
		
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
		
		</tbody>
	</table>
</section>
<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="DNA_Library" action="create" params="['na_extract': DNA_ExtractInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'DNA_Library.label', default: 'DNA Library')])}</g:link>
    </a></div>
</div>
<hr style="border:1; height:1px" />
</body>

</html>
