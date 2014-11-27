
<%@ page import="geldb.Period" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'period.label', default: 'Period')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-period" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="period.period.label" default="Period" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: periodInstance, field: "period")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
