
<%@ page import="geldb.DispatchItem; geldb.Aliquot; geldb.DNA_Extract; geldb.DispatchedBox" %>
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

					<g:sortableColumn property="aliquot.specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'aliquot.specimen.participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

					<th>Sample Type</th>

					<th>Pass/Fail</th>

					<th>DNA Yield</th>

					<th>Elution</th>

					<th>Extraction Date</th>

					<th>Barcode</th>

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
							${dispatchItemInstance?.identifiedSample?.aliquot?.first()?.specimen?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}}
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

					<g:sortableColumn property="positionIfPlated" title="Position" />

					<g:sortableColumn property="specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'specimen.participant.studySubject.studySubjectIdentifier.label', default: "Participant Id")}" />

					<th>Sample Type</th>

					<th>Created On</th>

					<th>Barcode</th>

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
							${dispatchItemInstance?.identifiedSample?.specimen?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}}
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

					</tr>
				</g:if>
			</g:each>
			</tbody>
		</table>
	</section>
</section>

<hr/>

<p class="text-primary">Available Action</p>

<a class='btn btn-primary btn-xs' <g:link controller="dispatchItem" action="create" params="['dispatchedBox.id': dispatchedBoxInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'dispatchItem.label', default: 'Dispatch Item')])}</g:link>

<g:form action="uploadFile" method="post" enctype="multipart/form-data">
	<p>
	</p>
	<p class="text-success">Or upload file generated by the scanner</p>
	<input type="file" name="file" id="file" />
	<g:hiddenField name="dispatchedBox" value="${dispatchedBoxInstance.id}" />
	<p>
	</p>
	<input type="submit" class="btn btn-success btn-xs" value="Upload CSV File" onclick="this.disabled=true;this.value='CSV file is uploading, please wait...';this.form.submit();">
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

					<g:if test="${auditLogInstance.className == 'DispatchedBox'}">
						<td>${fieldValue(bean: auditLogInstance, field: "eventName")} Dispatched Box</td>
					</g:if>
					<g:elseif test="${auditLogInstance.className == 'DispatchItem'}">
						<td>${fieldValue(bean: auditLogInstance, field: "eventName")} Dispatch Item</td>
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
