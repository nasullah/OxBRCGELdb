
<%@ page import="geldb.Position; geldb.DNA_Extract; geldb.Aliquot; geldb.SolidSpecimen; geldb.FluidSpecimen; geldb.PlateOrBox" %>
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
			<g:if test="${!positionList.empty}">
				<thead>
				<tr>

					<g:sortableColumn property="studySubjectIdentifier" title="GeL Id/Participant Id" />

					<g:sortableColumn property="letter" title="Letter" />

					<g:sortableColumn property="number" title="Number" />

					<th>Sample Type</th>

					<th>Sample Barcode</th>

				</tr>
				</thead>
			</g:if>
			<tbody>
			<g:each in="${positionList}" var="positionInstance">
				<tr>

					<td>
						<g:if test="${Aliquot.findById(positionInstance.containedSamples?.find{s -> s.exhausted != true}?.id)}">
							<g:link controller="position" action="show" id="${positionInstance.id}">${Aliquot.findById(positionInstance.containedSamples?.find{s -> s.exhausted != true}?.id)?.specimen?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}}</g:link>
						</g:if>
						<g:elseif test="${DNA_Extract.findById(positionInstance.containedSamples?.find{s -> s.exhausted != true}?.id)}">
							<g:link controller="position" action="show" id="${positionInstance.id}">${DNA_Extract.findById(positionInstance.containedSamples?.find{s -> s.exhausted != true}?.id)?.aliquot?.first()?.specimen?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}}</g:link>
						</g:elseif>
					</td>

					<td>${fieldValue(bean: positionInstance, field: "letter")}</td>

					<td>${fieldValue(bean: positionInstance, field: "number")}</td>

					<td>
						<g:if test="${Aliquot.findById(positionInstance.containedSamples?.find{s -> s.exhausted != true}?.id)}">
							${Aliquot.findById(positionInstance.containedSamples?.find{s -> s.exhausted != true}?.id)?.aliquotType}
						</g:if>
						<g:elseif test="${DNA_Extract.findById(positionInstance.containedSamples?.find{s -> s.exhausted != true}?.id)}">
							${DNA_Extract.findById(positionInstance.containedSamples?.find{s -> s.exhausted != true}?.id)?.aliquot?.first()?.aliquotType}
						</g:elseif>
					</td>

					<td>${fieldValue(bean: positionInstance?.containedSamples?.find{s -> s.exhausted != true}, field: "barcode")}</td>

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

<sec:ifAnyGranted roles="ROLE_ADMIN">
	<h2>Audit</h2>
	<section id="list-participant" class="first">

		<table class="table table-bordered margin-top-medium">
			<thead>
			<tr>
				<g:sortableColumn property="dateCreated" title="Date & Time" />

				<g:sortableColumn property="actor" title="Username" />

				<g:sortableColumn property="eventName" title="Event" />

				<g:sortableColumn property="persistedObjectId" title="Record" />

				<g:sortableColumn property="oldValue" title="Old Value" />

				<g:sortableColumn property="newValue" title="New Value" />

			</tr>
			</thead>
			<tbody>
			<g:each in="${listAuditLogData}" status="i" var="auditLogInstance">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

					<td><g:formatDate date="${auditLogInstance.dateCreated}" /></td>

					<td>${fieldValue(bean: auditLogInstance, field: "actor")}</td>

					<g:if test="${auditLogInstance.className == 'PlateOrBox'}">
						<td>${fieldValue(bean: auditLogInstance, field: "eventName")} Plate or Box</td>
					</g:if>
					<g:elseif test="${auditLogInstance.className == 'Position'}">
						<td>${fieldValue(bean: auditLogInstance, field: "eventName")} Position</td>
					</g:elseif>

					<td>${fieldValue(bean: auditLogInstance, field: "persistedObjectId")}</td>

					<td>${fieldValue(bean: auditLogInstance, field: "oldValue")}</td>

					<td>${fieldValue(bean: auditLogInstance, field: "newValue")}</td>

				</tr>
			</g:each>
			</tbody>
		</table>

	</section>
</sec:ifAnyGranted>

</body>

</html>
