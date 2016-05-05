
<%@ page import="geldb.DNA_Extract; geldb.Aliquot; geldb.SolidSpecimen; geldb.FluidSpecimen; geldb.PlateOrBox" %>
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
		%{----}%
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="plateOrBox.well.label" default="Well" /></td>--}%
				%{----}%
				%{--<td valign="top" style="text-align: left;" class="value">--}%
					%{--<ul>--}%
					%{--<g:each in="${plateOrBoxInstance.well.sort{it.letter+it.number}}" var="w">--}%
						%{--<li><g:link controller="position" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></li>--}%
					%{--</g:each>--}%
					%{--</ul>--}%
				%{--</td>--}%
				%{----}%
			%{--</tr>--}%
		
		</tbody>
	</table>

	<table border="1" width="100%">
		<tr>
			<th style="background: rgba(25, 105, 255, 0.33)"><center>Sample Position in Box/Plate</center></th>
		</tr>
	</table>

	<section id="show-well" class="first">
		<table class="table table-bordered margin-top-medium">
			<g:if test="${!plateOrBoxInstance.well.empty}">
				<thead>
				<tr>

					<th>Participant Id</th>

					<th>Letter</th>

					<th>Number</th>

					<th>Sample Type</th>

					<th>Sample Barcode</th>

				</tr>
				</thead>
			</g:if>
			<tbody>
			<g:each in="${plateOrBoxInstance.well.sort{it.letter+it.number}}" var="positionInstance">
				<tr>

					<td>
						<g:if test="${FluidSpecimen.findById(positionInstance?.containedSamples?.first()?.id)}">
							<g:link controller="position" action="show" id="${positionInstance.id}">${FluidSpecimen.findById(positionInstance?.containedSamples?.first()?.id)?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}}</g:link>
						</g:if>
						<g:elseif test="${SolidSpecimen.findById(positionInstance.containedSamples?.first()?.id)}">
							<g:link controller="position" action="show" id="${positionInstance.id}">${SolidSpecimen.findById(positionInstance?.containedSamples?.first()?.id)?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}}</g:link>
						</g:elseif>
						<g:elseif test="${Aliquot.findById(positionInstance.containedSamples?.first()?.id)}">
							<g:link controller="position" action="show" id="${positionInstance.id}">${Aliquot.findById(positionInstance?.containedSamples?.first()?.id)?.specimen?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}}</g:link>
						</g:elseif>
						<g:elseif test="${DNA_Extract.findById(positionInstance.containedSamples?.first()?.id)}">
							<g:link controller="position" action="show" id="${positionInstance.id}">${DNA_Extract.findById(positionInstance?.containedSamples?.first()?.id)?.aliquot?.first()?.specimen?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}}</g:link>
						</g:elseif>
					</td>

					<td>${fieldValue(bean: positionInstance, field: "letter")}</td>

					<td>${fieldValue(bean: positionInstance, field: "number")}</td>

					<td>
						<g:if test="${FluidSpecimen.findById(positionInstance?.containedSamples?.first()?.id)}">
							Fluid Specimen
						</g:if>
						<g:elseif test="${SolidSpecimen.findById(positionInstance.containedSamples?.first()?.id)}">
							Main Specimen
						</g:elseif>
						<g:elseif test="${Aliquot.findById(positionInstance.containedSamples?.first()?.id)}">
							${Aliquot.findById(positionInstance.containedSamples?.first()?.id)?.aliquotType}
						</g:elseif>
						<g:elseif test="${DNA_Extract.findById(positionInstance.containedSamples?.first()?.id)}">
							${DNA_Extract.findById(positionInstance.containedSamples?.first()?.id)?.aliquot?.first()?.aliquotType}
						</g:elseif>
					</td>

					<td>${fieldValue(bean: positionInstance?.containedSamples?.first(), field: "barcode")}</td>

				</tr>
			</g:each>
			</tbody>
		</table>
	</section>
</section>

<p class="text-primary">Available Action</p>

<g:form action="uploadScannerFile" method="post" enctype="multipart/form-data">
	<p>
	</p>
	<p class="text-success">Upload file generated by the scanner</p>
	<input type="file" name="file" id="file" />
	<g:hiddenField name="box" value="${plateOrBoxInstance.id}" />
	<p>
	</p>
	<button type="submit" class="btn btn-success btn-xs" value="Upload"><span class="glyphicon glyphicon-upload"></span> Upload</button>
</g:form>

<hr/>

</body>

</html>
