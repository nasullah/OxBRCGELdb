
<%@ page import="geldb.AnatomicalSite" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'anatomicalSite.label', default: 'Anatomical Site')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-anatomicalSite" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="anatomicalSite.anatomicalSiteCode.label" default="Anatomical Site Code" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: anatomicalSiteInstance, field: "anatomicalSiteCode")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="anatomicalSite.anatomicalSiteName.label" default="Anatomical Site Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: anatomicalSiteInstance, field: "anatomicalSiteName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="anatomicalSite.anatomicalSiteDescription.label" default="Anatomical Site Description" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: anatomicalSiteInstance, field: "anatomicalSiteDescription")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
