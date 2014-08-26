
<%@ page import="geldb.TestDate" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'testDate.label', default: 'TestDate')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-testDate" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="testDate.date.label" default="Date" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${testDateInstance?.date}" /></td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
