
<%@ page import="geldb.Derivation" %>
<%@ page import="geldb.Centrifugation" %>

<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'derivation.label', default: 'Derivation')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-derivation" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="derivation.aliquot.label" default="Parent Aliquot" /></td>
				
				<td valign="top" class="value"><g:link controller="aliquot" action="show" id="${derivationInstance?.aliquot?.id}">${derivationInstance?.aliquot?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="derivation.derivationDate.label" default="Derivation Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${derivationInstance?.derivationDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="derivation.derivationTime.label" default="Derivation Time" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: derivationInstance, field: "derivationTime")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="derivation.derivedBy.label" default="Derived By" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${derivationInstance?.derivedBy?.id}">${derivationInstance?.derivedBy?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="derivation.derivationProcess.label" default="Derivation Process" /></td>
				
				<td valign="top" class="value">${derivationInstance?.derivationProcess?.encodeAsHTML()}</td>
				
			</tr>
		
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="derivation.notes.label" default="Notes" /></td>--}%
				%{----}%
				%{--<td valign="top" class="value">${fieldValue(bean: derivationInstance, field: "notes")}</td>--}%
				%{----}%
			%{--</tr>--}%

            <g:each in="${derivationInstance.derivedAliquots}" var="d">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="aliquot.aliquotType.label" default="Aliquot Type" /></td>

                    <td valign="top" class="value"><g:link controller="aliquotType" action="show" id="${d?.aliquotType?.id}">${d?.aliquotType?.encodeAsHTML()}</g:link></td>

                </tr>

                <tr class="prop">

                    <td valign="top" class="name"><g:message code="aliquot.sapphireIdentifier.label" default="Slide Id (Frozen only)" /></td>

                    <td valign="top" class="value">${fieldValue(bean: d, field: "sapphireIdentifier")}</td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="aliquot.barcode.label" default="Barcode" /></td>

                    <td valign="top" class="value">${fieldValue(bean: d, field: "barcode")}</td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="aliquot.exhausted.label" default="Exhausted"/></td>

                    <td valign="top" class="value"><g:formatBoolean boolean="${d.exhausted}" true="Yes" false="No"/></td>

                </tr>
            </g:each>
		
		</tbody>
	</table>
</section>
</body>

</html>
