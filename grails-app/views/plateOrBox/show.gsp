
<%@ page import="geldb.PlateOrBox" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'plateOrBox.label', default: 'Plate or Box')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-plateOrBox" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="plateOrBox.identifier.label" default="Identifier" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: plateOrBoxInstance, field: "identifier")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="plateOrBox.storageLocation.label" default="Storage Location" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: plateOrBoxInstance, field: "storageLocation")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="plateOrBox.numberOfWells.label" default="Number Of Wells" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: plateOrBoxInstance, field: "numberOfWells")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="plateOrBox.plateType.label" default="Plate Type" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: plateOrBoxInstance, field: "plateType")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="plateOrBox.intendedAssay.label" default="Intended Assay" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: plateOrBoxInstance, field: "intendedAssay")}</td>
				
			</tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="plateOrBox.barcode.label" default="Barcode" /></td>

                <td valign="top" class="value">${fieldValue(bean: plateOrBoxInstance, field: "barcode")}</td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="plateOrBox.notes.label" default="Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: plateOrBoxInstance, field: "notes")}</td>
				
			</tr>
		
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="plateOrBox.shelf.label" default="Shelf" /></td>--}%
				%{----}%
				%{--<td valign="top" class="value"><g:link controller="shelf" action="show" id="${plateOrBoxInstance?.shelf?.id}">${plateOrBoxInstance?.shelf?.encodeAsHTML()}</g:link></td>--}%
				%{----}%
			%{--</tr>--}%
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="plateOrBox.well.label" default="Well" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${plateOrBoxInstance.well.sort{it.letter+it.number}}" var="w">
						<li><g:link controller="position" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
