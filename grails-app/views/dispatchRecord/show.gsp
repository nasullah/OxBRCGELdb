
<%@ page import="geldb.DispatchRecord" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'dispatchRecord.label', default: 'Dispatch Record')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-dispatchRecord" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchRecord.destination.label" default="Destination" /></td>
				
				<td valign="top" class="value"><g:link controller="destination" action="show" id="${dispatchRecordInstance?.destination?.id}">${dispatchRecordInstance?.destination?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchRecord.sentOn.label" default="Sent On" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${dispatchRecordInstance?.sentOn}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchRecord.receivedOn.label" default="Received On" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${dispatchRecordInstance?.receivedOn}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchRecord.fAO.label" default="For the attention of" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: dispatchRecordInstance, field: "fAO")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchRecord.companyName.label" default="Company Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: dispatchRecordInstance, field: "companyName")}</td>
				
			</tr>

			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchRecord.consignmentNumber.label" default="Consignment Number" /></td>

				<td valign="top" class="value">${fieldValue(bean: dispatchRecordInstance, field: "consignmentNumber")}</td>

			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchRecord.companyAddress.label" default="Company Address" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: dispatchRecordInstance, field: "companyAddress")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchRecord.companyPostalCode.label" default="Company Postal Code" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: dispatchRecordInstance, field: "companyPostalCode")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchRecord.companyCountry.label" default="Company Country" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: dispatchRecordInstance, field: "companyCountry")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchRecord.dispatchedBoxs.label" default="Dispatched Boxs" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${dispatchRecordInstance.dispatchedBoxs}" var="d">
						<li><g:link controller="dispatchedBox" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

<hr style="border:1; height:1px" />

<p class="text-primary">Available Action</p>

<a class='btn btn-primary btn-small' <g:link controller="dispatchedBox" action="create" params="['dispatchRecord.id': dispatchRecordInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'dispatchBox.label', default: 'Dispatch Box')])}</g:link>

<g:if test="${dispatchRecordInstance.dispatchedBoxs.dispatchItems}">
	<a class='btn btn-success btn-small' <g:link controller="dispatchRecord" action="qcTestExport" params="['dispatchRecord': dispatchRecordInstance?.id, 'format': 'csv', 'extension': 'csv']"><i class="glyphicon glyphicon-export"></i> Test Results CSV Export</g:link>
	<a class='btn btn-success btn-small' <g:link controller="dispatchRecord" action="sampleMetadataExport" params="['dispatchRecord': dispatchRecordInstance?.id, 'format': 'csv', 'extension': 'csv']"><i class="glyphicon glyphicon-export"></i> Sample Metadata CSV Export</g:link>
</g:if>

<hr style="border:1; height:1px" />
</body>

</html>
