
<%@ page import="geldb.Lane" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'lane.label', default: 'Lane')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-lane" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="lane.flowCell.label" default="Flow Cell" /></td>
				
				<td valign="top" class="value"><g:link controller="flowCell" action="show" id="${laneInstance?.flowCell?.id}">${laneInstance?.flowCell?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="lane.laneNumber.label" default="Lane Number" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: laneInstance, field: "laneNumber")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="lane.loadedLibrary.label" default="Loaded Library" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${laneInstance.loadedLibrary}" var="l">
						<li><g:link controller="DNA_Library" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
