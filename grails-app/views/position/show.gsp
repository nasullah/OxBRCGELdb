
<%@ page import="geldb.Position" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'position.label', default: 'Position')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-position" class="first">

	<table class="table">
		<tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="position.containedAliquot.label" default="Contained Aliquot" /></td>

                <td valign="top" class="value"><g:link controller="aliquot" action="show" id="${positionInstance?.containedAliquot?.id}">${positionInstance?.containedAliquot?.encodeAsHTML()}</g:link></td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="position.plateOrBox.label" default="Plate Or Box" /></td>
				
				<td valign="top" class="value"><g:link controller="plateOrBox" action="show" id="${positionInstance?.plateOrBox?.id}">${positionInstance?.plateOrBox?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="position.letter.label" default="Letter" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: positionInstance, field: "letter")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="position.number.label" default="Number" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: positionInstance, field: "number")}</td>
				
			</tr>

		
		</tbody>
	</table>
</section>

</body>

</html>
