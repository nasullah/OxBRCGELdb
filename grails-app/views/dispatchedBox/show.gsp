
<%@ page import="geldb.Aliquot; geldb.DNA_Extract; geldb.DispatchedBox" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'dispatchedBox.label', default: 'Dispatched Box')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-dispatchedBox" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchedBox.dispatchRecord.label" default="Dispatch Record" /></td>
				
				<td valign="top" class="value"><g:link controller="dispatchRecord" action="show" id="${dispatchedBoxInstance?.dispatchRecord?.id}">${dispatchedBoxInstance?.dispatchRecord?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchedBox.barcode.label" default="Barcode" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: dispatchedBoxInstance, field: "barcode")}</td>
				
			</tr>

			<tr class="prop">
				<td valign="top" class="name">Number of items</td>

				<td valign="top" class="value"><a class="text-danger">${dispatchItemList?.size()}</a></td>

			</tr>
		
		</tbody>
	</table>

	<% def dnaList = DNA_Extract.findAllByIdInList(dispatchItemList.identifiedSample.id) %>
	<g:if test="${!dnaList?.empty}">
		<table border="1" width="100%">
			<tr>
				<th style="background: rgba(25, 105, 255, 0.33)"><center>Dispatch Items (DNA Samples)</center></th>
			</tr>
		</table>
	</g:if>

	<section id="show-dispatchItemsDNA" class="first">
		<table class="table table-bordered margin-top-medium">
			<g:if test="${!dnaList?.empty}">
				<thead>
				<tr>

					<g:sortableColumn property="positionIfPlated" title="Position" />

					<th>Sample Type</th>

					<th>Pass/Fail</th>

					<th>DNA Yield</th>

					<th>Elution</th>

					<th>Extraction Date</th>

					<th>Barcode</th>

					<g:sortableColumn property="aliquot.specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'aliquot.specimen.participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

				</tr>
				</thead>
			</g:if>
			<tbody>
			<g:each in="${dispatchItemList}" var="dispatchItemInstance">
				<% def dnaInstance = dnaList.find {d -> d.id == dispatchItemInstance.identifiedSample.id} %>
				<g:if test="${dnaInstance}">
					<tr>
						<td>
							<g:link controller="dispatchItem" action="show" id="${dispatchItemInstance?.id}">${dispatchItemInstance.positionIfPlated}</g:link>
						</td>

						<td>
							${dispatchItemInstance?.identifiedSample?.aliquot?.first()?.aliquotType}
						</td>

						<td>
							<g:if test="${dispatchItemInstance?.identifiedSample?.passFail}">
								Pass
							</g:if>
							<g:else>
								Fail
							</g:else>
						</td>

						<td>
							<% def dnaQuantity = (dispatchItemInstance?.identifiedSample?.dNAConcentrationQubit * dispatchItemInstance?.identifiedSample?.dNAAmount)/1000 %>
							${dnaQuantity.trunc(1)}
						</td>

						<td>
							${dispatchItemInstance?.identifiedSample?.sapphireIdentifier}
						</td>

						<td>
							${dispatchItemInstance?.identifiedSample?.extractionDate?.format('yyyy-MM-dd')}
						</td>

						<td>
							${dispatchItemInstance?.identifiedSample?.barcode}
						</td>

						<td>
							${dispatchItemInstance?.identifiedSample?.aliquot?.first()?.specimen?.participant?.studySubject?.studySubjectIdentifier?.findResult {it.size() ? it : null}}
						</td>

					</tr>
				</g:if>
			</g:each>
			</tbody>
		</table>
	</section>

	<% def aliquotList = Aliquot.findAllByIdInList(dispatchItemList.identifiedSample.id) %>
	<g:if test="${!aliquotList?.empty}">
		<table border="1" width="100%">
			<tr>
				<th style="background: rgba(25, 105, 255, 0.33)"><center>Dispatch Items (Omics Samples)</center></th>
			</tr>
		</table>
	</g:if>

	<section id="show-dispatchItemsAliquot" class="first">
		<table class="table table-bordered margin-top-medium">
			<g:if test="${!aliquotList?.empty}">
				<thead>
				<tr>

					<th>Position</th>

					<th>Sample Type</th>

					<th>Created On</th>

					<th>Barcode</th>

					<th>Participant Id</th>

				</tr>
				</thead>
			</g:if>
			<tbody>
			<g:each in="${dispatchItemList}" var="dispatchItemInstance">
				<% def aliquotInstance = aliquotList.find {d -> d.id == dispatchItemInstance.identifiedSample.id} %>
				<g:if test="${aliquotInstance}">
					<tr>
						<td>
							<g:link controller="dispatchItem" action="show" id="${dispatchItemInstance?.id}">${dispatchItemInstance.positionIfPlated}</g:link>
						</td>

						<td>
							${dispatchItemInstance?.identifiedSample?.aliquotType}
						</td>

						<td>
							${dispatchItemInstance?.identifiedSample?.createdOn?.format('yyyy-MM-dd')}
						</td>

						<td>
							${dispatchItemInstance?.identifiedSample?.barcode}
						</td>

						<td>
							${dispatchItemInstance?.identifiedSample?.specimen?.participant?.studySubject?.studySubjectIdentifier?.findResult {it.size() ? it : null}}
						</td>

					</tr>
				</g:if>
			</g:each>
			</tbody>
		</table>
	</section>
</section>

<hr/>

<p class="text-primary">Available Action</p>

<a class='btn btn-primary btn-small' <g:link controller="dispatchItem" action="create" params="['dispatchedBox.id': dispatchedBoxInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'dispatchItem.label', default: 'Dispatch Item')])}</g:link>

<g:form action="uploadFile" method="post" enctype="multipart/form-data">
	<p>
	</p>
	<p class="text-success">Or upload file generated by the scanner</p>
	<input type="file" name="file" id="file" />
	<g:hiddenField name="dispatchedBox" value="${dispatchedBoxInstance.id}" />
	<p>
	</p>
	<button type="submit" class="btn btn-success btn-xs" value="Upload"><span class="glyphicon glyphicon-upload"></span> Upload</button>
</g:form>

<hr/>

</body>

</html>
