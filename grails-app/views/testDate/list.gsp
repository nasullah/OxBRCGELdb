
<%@ page import="geldb.TestDate" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'testDate.label', default: 'TestDate')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-testDate" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="date" title="${message(code: 'testDate.date.label', default: 'Date')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${testDateInstanceList}" status="i" var="testDateInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${testDateInstance.id}">${fieldValue(bean: testDateInstance, field: "date")}</g:link></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${testDateInstanceCount}" />
	</div>
</section>

</body>

</html>
