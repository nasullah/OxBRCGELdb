
<%@ page import="geldb.AliquotPhoto" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'aliquotPhoto.label', default: 'AliquotPhoto')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-aliquotPhoto" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotPhoto.aliquotReport.label" default="Aliquot Report" /></td>
				
				<td valign="top" class="value"><g:link controller="aliquotReport" action="show" id="${aliquotPhotoInstance?.aliquotReport?.id}">${aliquotPhotoInstance?.aliquotReport?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotPhoto.aliquotPhoto.label" default="Aliquot Photo" /></td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
