
<%@ page import="geldb.AnatomicalSite" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'anatomicalSite.label', default: 'Anatomical Site')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-anatomicalSite" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="anatomicalSiteCode" title="${message(code: 'anatomicalSite.anatomicalSiteCode.label', default: 'Anatomical Site Code')}" />
			
				<g:sortableColumn property="anatomicalSiteName" title="${message(code: 'anatomicalSite.anatomicalSiteName.label', default: 'Anatomical Site Name')}" />
			
				<g:sortableColumn property="anatomicalSiteDescription" title="${message(code: 'anatomicalSite.anatomicalSiteDescription.label', default: 'Anatomical Site Description')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${anatomicalSiteInstanceList}" status="i" var="anatomicalSiteInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${anatomicalSiteInstance.id}">${fieldValue(bean: anatomicalSiteInstance, field: "anatomicalSiteCode")}</g:link></td>
			
				<td>${fieldValue(bean: anatomicalSiteInstance, field: "anatomicalSiteName")}</td>
			
				<td>${fieldValue(bean: anatomicalSiteInstance, field: "anatomicalSiteDescription")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${anatomicalSiteInstanceCount}" />
	</div>
</section>

</body>

</html>
