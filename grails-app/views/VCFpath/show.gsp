
<%@ page import="geldb.VCFpath" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'VCFpath.label', default: 'VCF path')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-VCFpath" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="VCFpath.sequencingReports.label" default="Sequencing Reports" /></td>
				
				<td valign="top" class="value"><g:link controller="sequencingReports" action="show" id="${VCFpathInstance?.sequencingReports?.id}">${VCFpathInstance?.sequencingReports?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="VCFpath.vCFPath.label" default="VCF Path" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: VCFpathInstance, field: "vCFPath")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
