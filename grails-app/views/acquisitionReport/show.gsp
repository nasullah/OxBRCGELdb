
%{--<%@ page import="geldb.AcquisitionReport" %>--}%
%{--<!DOCTYPE html>--}%
%{--<html>--}%

%{--<head>--}%
	%{--<meta name="layout" content="kickstart" />--}%
	%{--<g:set var="entityName" value="${message(code: 'acquisitionReport.label', default: 'AcquisitionReport')}" />--}%
	%{--<title><g:message code="default.show.label" args="[entityName]" /></title>--}%
%{--</head>--}%

%{--<body>--}%

%{--<section id="show-acquisitionReport" class="first">--}%

	%{--<table class="table">--}%
		%{--<tbody>--}%

            %{--<tr class="prop">--}%
                %{--<td valign="top" class="name"><g:message code="acquisitionReport.specimen.label" default="Specimen" /></td>--}%

                %{--<td valign="top" class="value"><g:link controller="specimen" action="show" id="${acquisitionReportInstance?.specimen?.id}">${acquisitionReportInstance?.specimen?.encodeAsHTML()}</g:link></td>--}%

            %{--</tr>--}%
		%{----}%
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="acquisitionReport.reportDate.label" default="Report Date" /></td>--}%
				%{----}%
				%{--<td valign="top" class="value"><g:formatDate date="${acquisitionReportInstance?.reportDate}" /></td>--}%
				%{----}%
			%{--</tr>--}%
		%{----}%
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="acquisitionReport.reportStaff.label" default="Report Staff" /></td>--}%
				%{----}%
				%{--<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${acquisitionReportInstance?.reportStaff?.id}">${acquisitionReportInstance?.reportStaff?.encodeAsHTML()}</g:link></td>--}%
				%{----}%
			%{--</tr>--}%
		%{----}%
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="acquisitionReport.comments.label" default="Comments" /></td>--}%
				%{----}%
				%{--<td valign="top" class="value">${fieldValue(bean: acquisitionReportInstance, field: "comments")}</td>--}%
				%{----}%
			%{--</tr>--}%
		%{----}%
		%{--</tbody>--}%
	%{--</table>--}%
%{--</section>--}%

%{--</body>--}%

%{--</html>--}%
