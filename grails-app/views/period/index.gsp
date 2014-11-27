
<%@ page import="geldb.Period" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'period.label', default: 'Period')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-period" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="period" title="${message(code: 'period.period.label', default: 'Period')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${periodInstanceList}" status="i" var="periodInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${periodInstance.id}">${fieldValue(bean: periodInstance, field: "period")}</g:link></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${periodInstanceCount}" />
	</div>
</section>

</body>

</html>
