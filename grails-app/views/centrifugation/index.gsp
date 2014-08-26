
<%@ page import="geldb.Centrifugation" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'centrifugation.label', default: 'Centrifugation Report')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-centrifugation" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="centrifugation.derivation.label" default="Derivation" /></th>
			
				<th><g:message code="centrifugation.specimen.label" default="Specimen" /></th>
			
				<g:sortableColumn property="reportDate" title="${message(code: 'centrifugation.reportDate.label', default: 'Report Date')}" />
			
				<th><g:message code="centrifugation.reportStaff.label" default="Report Staff" /></th>
			
				<g:sortableColumn property="comments" title="${message(code: 'centrifugation.comments.label', default: 'Comments')}" />
			
				<g:sortableColumn property="timeReceived" title="${message(code: 'centrifugation.timeReceived.label', default: 'Time Received')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${centrifugationInstanceList}" status="i" var="centrifugationInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${centrifugationInstance.id}">${fieldValue(bean: centrifugationInstance, field: "derivation")}</g:link></td>
			
				<td>${fieldValue(bean: centrifugationInstance, field: "specimen")}</td>
			
				<td><g:formatDate date="${centrifugationInstance.reportDate}" /></td>
			
				<td>${fieldValue(bean: centrifugationInstance, field: "reportStaff")}</td>
			
				<td>${fieldValue(bean: centrifugationInstance, field: "comments")}</td>
			
				<td>${fieldValue(bean: centrifugationInstance, field: "timeReceived")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${centrifugationInstanceCount}" />
	</div>
</section>

</body>

</html>
