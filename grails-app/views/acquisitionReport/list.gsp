
%{--<%@ page import="geldb.AcquisitionReport" %>--}%
%{--<!DOCTYPE html>--}%
%{--<html>--}%

%{--<head>--}%
	%{--<meta name="layout" content="kickstart" />--}%
	%{--<g:set var="entityName" value="${message(code: 'acquisitionReport.label', default: 'AcquisitionReport')}" />--}%
	%{--<title><g:message code="default.list.label" args="[entityName]" /></title>--}%
%{--</head>--}%

%{--<body>--}%

%{--<section id="list-acquisitionReport" class="first">--}%

	%{--<table class="table table-bordered margin-top-medium">--}%
		%{--<thead>--}%
			%{--<tr>--}%
			%{----}%
				%{--<g:sortableColumn property="reportDate" title="${message(code: 'acquisitionReport.reportDate.label', default: 'Report Date')}" />--}%
			%{----}%
				%{--<th><g:message code="acquisitionReport.reportStaff.label" default="Report Staff" /></th>--}%
			%{----}%
				%{--<g:sortableColumn property="comments" title="${message(code: 'acquisitionReport.comments.label', default: 'Comments')}" />--}%
			%{----}%
				%{--<th><g:message code="acquisitionReport.specimen.label" default="Specimen" /></th>--}%
			%{----}%
			%{--</tr>--}%
		%{--</thead>--}%
		%{--<tbody>--}%
		%{--<g:each in="${acquisitionReportInstanceList}" status="i" var="acquisitionReportInstance">--}%
			%{--<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">--}%
			%{----}%
				%{--<td><g:link action="show" id="${acquisitionReportInstance.id}">${fieldValue(bean: acquisitionReportInstance, field: "reportDate")}</g:link></td>--}%
			%{----}%
				%{--<td>${fieldValue(bean: acquisitionReportInstance, field: "reportStaff")}</td>--}%
			%{----}%
				%{--<td>${fieldValue(bean: acquisitionReportInstance, field: "comments")}</td>--}%
			%{----}%
				%{--<td>${fieldValue(bean: acquisitionReportInstance, field: "specimen")}</td>--}%
			%{----}%
			%{--</tr>--}%
		%{--</g:each>--}%
		%{--</tbody>--}%
	%{--</table>--}%
	%{--<div>--}%
		%{--<bs:paginate total="${acquisitionReportInstanceCount}" />--}%
	%{--</div>--}%
%{--</section>--}%

%{--</body>--}%

%{--</html>--}%
