
<%@ page import="geldb.SequencingReports" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'sequencingReports.label', default: 'Sequencing Reports')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-sequencingReports" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sequencingReports.sequencingRun.label" default="Sequencing Run" /></td>
				
				<td valign="top" class="value"><g:link controller="sequencingRun" action="show" id="${sequencingReportsInstance?.sequencingRun?.id}">${sequencingReportsInstance?.sequencingRun?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sequencingReports.bAMpath.label" default="BAM path" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: sequencingReportsInstance, field: "bAMpath")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sequencingReports.reportPath.label" default="Report Path" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: sequencingReportsInstance, field: "reportPath")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sequencingReports.vCFpath.label" default="VCF path" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${sequencingReportsInstance.vCFpath}" var="v">
						<li><g:link controller="VCFpath" action="show" id="${v.id}">${v?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>
<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="VCFpath" action="create" params="['sequencingReports.id': sequencingReportsInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'VCFpath.label', default: 'VCF Path')])}</g:link>
    </a></div>
</div>
<hr style="border:1; height:1px" />
</body>

</html>
