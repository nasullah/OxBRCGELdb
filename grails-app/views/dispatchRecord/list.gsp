
<%@ page import="geldb.DispatchRecord" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'dispatchRecord.label', default: 'Dispatch Record')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-dispatchRecord" class="first">

	<table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <th><g:message code="dispatchRecord.companyName.label" default="Company Name" /></th>

            <g:sortableColumn property="sentOn" title="${message(code: 'dispatchRecord.sentOn.label', default: 'Sent On')}" />

            <g:sortableColumn property="receivedOn" title="${message(code: 'dispatchRecord.receivedOn.label', default: 'Received On')}" />

            <g:sortableColumn property="fAO" title="${message(code: 'dispatchRecord.fAO.label', default: 'FAO')}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${dispatchRecordInstanceList}" status="i" var="dispatchRecordInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${dispatchRecordInstance.id}">${fieldValue(bean: dispatchRecordInstance, field: "companyName")}</g:link></td>

                <td><g:formatDate format="yyyy-MM-dd" date="${dispatchRecordInstance.sentOn}" /></td>

                <td><g:formatDate format="yyyy-MM-dd" date="${dispatchRecordInstance.receivedOn}" /></td>

                <td>${fieldValue(bean: dispatchRecordInstance, field: "fAO")}</td>

            </tr>
        </g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${dispatchRecordInstanceCount}" />
	</div>
</section>

</body>

</html>
