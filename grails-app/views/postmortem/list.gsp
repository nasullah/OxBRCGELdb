
<%@ page import="geldb.Postmortem" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'postmortem.label', default: 'Postmortem')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-postmortem" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="postmortem.specimen.label" default="Specimen" /></th>
			
				<g:sortableColumn property="delayInHours" title="${message(code: 'postmortem.delayInHours.label', default: 'Delay In Hours')}" />
			
				<g:sortableColumn property="warmIschemiaTimeMin" title="${message(code: 'postmortem.warmIschemiaTimeMin.label', default: 'Warm Ischemia Time Min')}" />
			
				<g:sortableColumn property="coldIschemiaTimeMin" title="${message(code: 'postmortem.coldIschemiaTimeMin.label', default: 'Cold Ischemia Time Min')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${postmortemInstanceList}" status="i" var="postmortemInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${postmortemInstance.id}">${fieldValue(bean: postmortemInstance, field: "specimen")}</g:link></td>
			
				<td>${fieldValue(bean: postmortemInstance, field: "delayInHours")}</td>
			
				<td>${fieldValue(bean: postmortemInstance, field: "warmIschemiaTimeMin")}</td>
			
				<td>${fieldValue(bean: postmortemInstance, field: "coldIschemiaTimeMin")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${postmortemInstanceCount}" />
	</div>
</section>

</body>

</html>
