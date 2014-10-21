
<%@ page import="geldb.Position" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'position.label', default: 'Position')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-position" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="position.plateOrBox.label" default="Plate Or Box" /></th>
			
				<g:sortableColumn property="letter" title="${message(code: 'position.letter.label', default: 'Letter')}" />
			
				<g:sortableColumn property="number" title="${message(code: 'position.number.label', default: 'Number')}" />
			
				<th><g:message code="position.containedAliquot.label" default="Contained Aliquot" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${positionInstanceList}" status="i" var="positionInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${positionInstance.id}">${fieldValue(bean: positionInstance, field: "plateOrBox")}</g:link></td>
			
				<td>${fieldValue(bean: positionInstance, field: "letter")}</td>
			
				<td>${fieldValue(bean: positionInstance, field: "number")}</td>

				%{--<td>${fieldValue(bean: positionInstance, field: "containedAliquot")}</td>--}%
                <td><g:link controller="aliquot" action="show" id="${positionInstance.containedAliquot.id}">${fieldValue(bean: positionInstance, field: "containedAliquot")}</g:link></td>

            </tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${positionInstanceCount}" />
	</div>
</section>

</body>

</html>
