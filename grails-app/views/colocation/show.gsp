
<%@ page import="geldb.Colocation" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'colocation.label', default: 'Colocation')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-colocation" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="colocation.adjacent.label" default="Adjacent" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${colocationInstance?.adjacent}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="colocation.notes.label" default="Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: colocationInstance, field: "notes")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="colocation.aliquot.label" default="Aliquot" /></td>
				
				<td valign="top" class="value"><g:link controller="aliquot" action="show" id="${colocationInstance?.aliquot?.id}">${colocationInstance?.aliquot?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="colocation.pairedAliquot.label" default="Paired Aliquot" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${colocationInstance.pairedAliquot}" var="p">
						<li><g:link controller="aliquot" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>
<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="aliquot" action="create" params="['colocationWith.id': colocationInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Aliquot')])}</g:link>
    </a></div>
</div>
<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="aliquot" action="create" params="['colocationWith.id': colocationInstance?.id]">Find Existing Aliquot</g:link>
    </a></div>
</div>
<hr style="border:1; height:1px" />
</body>

</html>
