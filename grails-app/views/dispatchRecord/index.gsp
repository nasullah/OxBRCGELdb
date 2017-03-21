
<%@ page import="geldb.DispatchRecord" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'dispatchRecord.label', default: 'Dispatch Record')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
	<r:require module="filterpane" />
</head>

<body>

<hr/>

<filterpane:filterButton text="Filter This List" />
<filterpane:filterPane domain="geldb.DispatchRecord"
					   excludeProperties="sentOn, receivedOn"
					   associatedProperties="dispatchedBoxs.barcode, dispatchedBoxs.dispatchItems.identifiedSample.barcode, dispatchedBoxs.dispatchItems.volume_ul,
								   						 dispatchedBoxs.dispatchItems.positionIfPlated"/>

<hr/>

<p>Number of records: ${dispatchRecordInstanceTotal == null ? DispatchRecord.count(): dispatchRecordInstanceTotal}</p>

<section id="index-dispatchRecord" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="dispatchRecord.companyName.label" default="Company Name" /></th>

				<g:sortableColumn property="sentOn" title="${message(code: 'dispatchRecord.sentOn.label', default: 'Sent On')}" />

				<g:sortableColumn property="consignmentNumber" title="${message(code: 'dispatchRecord.consignmentNumber.label', default: 'Consignment Number')}" />

			</tr>
		</thead>
		<tbody>
		<g:each in="${dispatchRecordInstanceList}" status="i" var="dispatchRecordInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${dispatchRecordInstance.id}">${fieldValue(bean: dispatchRecordInstance, field: "companyName")}</g:link></td>
			
				<td><g:formatDate format="yyyy-MM-dd" date="${dispatchRecordInstance.sentOn}" /></td>

				<td>${fieldValue(bean: dispatchRecordInstance, field: "consignmentNumber")}</td>

			</tr>
		</g:each>
		</tbody>
	</table>
	<div class="pagination">
		<bs:paginate total="${dispatchRecordInstanceTotal == null ? DispatchRecord.count(): dispatchRecordInstanceTotal}" params="${filterParams}" />
	</div>
</section>

</body>

</html>
