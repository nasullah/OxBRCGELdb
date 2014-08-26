
<%@ page import="geldb.DNA_Library" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNA_Library.label', default: 'DNA Library')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-DNA_Library" class="first">

	<table class="table">
		<tbody>
            <tr class="prop">
                <td valign="top" class="name"><g:message code="DNA_Library.na_extract.label" default="DNA Extract" /></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${DNA_LibraryInstance.na_extract}" var="n">
                            <li><g:link controller="DNA_Extract" action="show" id="${n.id}">${n?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Library.localIdentifier.label" default="Local Identifier" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_LibraryInstance, field: "localIdentifier")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Library.size.label" default="Size" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_LibraryInstance, field: "size")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Library.unit.label" default="Unit" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_LibraryInstance, field: "unit")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Library.exhausted.label" default="Exhausted" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${DNA_LibraryInstance?.exhausted}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Library.passFail.label" default="Pass Fail" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${DNA_LibraryInstance?.passFail}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Library.notes.label" default="Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_LibraryInstance, field: "notes")}</td>
				
			</tr>

		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Library.dNA_QC_qPCR.label" default="DNA QC qPCR" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_LibraryInstance, field: "dNA_QC_qPCR")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Library.dNAInputForLibraryPrep.label" default="DNA Input For Library Prep" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_LibraryInstance, field: "dNAInputForLibraryPrep")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Library.fragmentedDNASize.label" default="Fragmented DNA Size" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_LibraryInstance, field: "fragmentedDNASize")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Library.fragmentationProtocol.label" default="Fragmentation Protocol" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_LibraryInstance, field: "fragmentationProtocol")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Library.framentedDNAConcentration.label" default="Fragmented DNA Concentration" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_LibraryInstance, field: "framentedDNAConcentration")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Library.libraryConcentration.label" default="Library Concentration" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: DNA_LibraryInstance, field: "libraryConcentration")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="DNA_Library.libraryPrepBy.label" default="Library Prep By" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${DNA_LibraryInstance?.libraryPrepBy?.id}">${DNA_LibraryInstance?.libraryPrepBy?.encodeAsHTML()}</g:link></td>
				
			</tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="DNA_Library.lane.label" default="Lane" /></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${DNA_LibraryInstance.lane}" var="l">
                            <li><g:link controller="lane" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
