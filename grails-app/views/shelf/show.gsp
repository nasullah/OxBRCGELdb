
<%@ page import="geldb.Shelf" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'shelf.label', default: 'Shelf')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-shelf" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="shelf.freezer.label" default="Freezer" /></td>
				
				<td valign="top" class="value"><g:link controller="freezer" action="show" id="${shelfInstance?.freezer?.id}">${shelfInstance?.freezer?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="shelf.shelfName.label" default="Shelf/Tower Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: shelfInstance, field: "shelfName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="shelf.plateOrBox.label" default="Plate Or Box" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${shelfInstance.plateOrBox}" var="p">
						<li><g:link controller="plateOrBox" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

<hr/>

<p class="text-primary">Available Action</p>

<a class='btn btn-primary btn-xs' <g:link controller="plateOrBox" action="create" params="['shelf.id': shelfInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'plateOrBox.label', default: 'Plate Or Box')])}</g:link>

<hr/>

</body>

</html>
