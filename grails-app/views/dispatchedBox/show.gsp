
<%@ page import="geldb.Aliquot; geldb.DNA_Extract; geldb.DispatchedBox" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'dispatchedBox.label', default: 'Dispatched Box')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-dispatchedBox" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchedBox.dispatchRecord.label" default="Dispatch Record" /></td>
				
				<td valign="top" class="value"><g:link controller="dispatchRecord" action="show" id="${dispatchedBoxInstance?.dispatchRecord?.id}">${dispatchedBoxInstance?.dispatchRecord?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchedBox.barcode.label" default="Barcode" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: dispatchedBoxInstance, field: "barcode")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchedBox.dispatchItems.label" default="Dispatch Items" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<g:each in="${dispatchedBoxInstance?.dispatchItems?.sort{it.positionIfPlated}}" var="d">
						<% def dna = DNA_Extract.findById(d.identifiedSample.id) %>
						<% def aliquot = Aliquot.findById(d.identifiedSample.id) %>
						<g:if test="${dna}">
							<g:if test="${dna.checked}">
								<li><g:link controller="dispatchItem" action="show" id="${d.id}" style="color: #00a700">${d?.encodeAsHTML()}</g:link></li>
							</g:if>
							<g:elseif test="${dna.checked == null}">
								<li><g:link controller="dispatchItem" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
							</g:elseif>
							<g:elseif test="${!dna.checked}">
								<li><g:link controller="dispatchItem" action="show" id="${d.id}" style="color: #c01913">${d?.encodeAsHTML()}</g:link></li>
							</g:elseif>
						</g:if>
						<g:elseif test="${aliquot}">
							<li><g:link controller="dispatchItem" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
						</g:elseif>
					</g:each>
				</td>
				
			</tr>

			<tr class="prop">
				<td valign="top" class="name">Number of items</td>

				<td valign="top" class="value"><a class="text-danger">${dispatchedBoxInstance?.dispatchItems?.size()}</a></td>

			</tr>
		
		</tbody>
	</table>
</section>

<hr/>

<p class="text-primary">Available Action</p>

<a class='btn btn-primary btn-small' <g:link controller="dispatchItem" action="create" params="['dispatchedBox.id': dispatchedBoxInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'dispatchItem.label', default: 'Dispatch Item')])}</g:link>

<g:form action="uploadFile" method="post" enctype="multipart/form-data">
	<p>
	</p>
	<p class="text-success">Or upload file generated by the scanner</p>
	<input type="file" name="file" id="file" />
	<g:hiddenField name="dispatchedBox" value="${dispatchedBoxInstance.id}" />
	<p>
	</p>
	<button type="submit" class="btn btn-success btn-xs" value="Upload"><span class="glyphicon glyphicon-upload"></span> Upload</button>
</g:form>

<hr/>

</body>

</html>
