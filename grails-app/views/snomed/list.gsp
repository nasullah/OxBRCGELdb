
%{--<%@ page import="geldb.Snomed" %>--}%
%{--<!DOCTYPE html>--}%
%{--<html>--}%

%{--<head>--}%
	%{--<meta name="layout" content="kickstart" />--}%
	%{--<g:set var="entityName" value="${message(code: 'snomed.label', default: 'Snomed')}" />--}%
	%{--<title><g:message code="default.list.label" args="[entityName]" /></title>--}%
%{--</head>--}%

%{--<body>--}%

%{--<section id="list-snomed" class="first">--}%

	%{--<table class="table table-bordered margin-top-medium">--}%
		%{--<thead>--}%
			%{--<tr>--}%
			%{----}%
				%{--<g:sortableColumn property="snomedCode" title="${message(code: 'snomed.snomedCode.label', default: 'Snomed Code')}" />--}%
			%{----}%
				%{--<th><g:message code="snomed.fFPE_Tissue_Report.label" default="F FPE Tissue Report" /></th>--}%
			%{----}%
			%{--</tr>--}%
		%{--</thead>--}%
		%{--<tbody>--}%
		%{--<g:each in="${snomedInstanceList}" status="i" var="snomedInstance">--}%
			%{--<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">--}%
			%{----}%
				%{--<td><g:link action="show" id="${snomedInstance.id}">${fieldValue(bean: snomedInstance, field: "snomedCode")}</g:link></td>--}%
			%{----}%
				%{--<td>${fieldValue(bean: snomedInstance, field: "fFPE_Tissue_Report")}</td>--}%
			%{----}%
			%{--</tr>--}%
		%{--</g:each>--}%
		%{--</tbody>--}%
	%{--</table>--}%
	%{--<div>--}%
		%{--<bs:paginate total="${snomedInstanceCount}" />--}%
	%{--</div>--}%
%{--</section>--}%

%{--</body>--}%

%{--</html>--}%
