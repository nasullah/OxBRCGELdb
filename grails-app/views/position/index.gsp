
<%@ page import="geldb.DNA_Library; geldb.DNA_Extract; geldb.Position" %>
<%@ page import="geldb.SolidSpecimen" %>
<%@ page import="geldb.FluidSpecimen" %>
<%@ page import="geldb.Aliquot" %>
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
			
				<th><g:message code="position.identifiedSample.label" default="Contained Item" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${positionInstanceList}" status="i" var="positionInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${positionInstance.id}">${fieldValue(bean: positionInstance, field: "plateOrBox")}</g:link></td>
			
				<td>${fieldValue(bean: positionInstance, field: "letter")}</td>
			
				<td>${fieldValue(bean: positionInstance, field: "number")}</td>

                <% def solidSpecimen = SolidSpecimen.listOrderById() %>
                <% def fluidSpecimen = FluidSpecimen.listOrderById() %>
                <% def aliquots = Aliquot.listOrderById() %>
                <% def DNAExtract = DNA_Extract.listOrderById() %>
                <% def DNALibrary = DNA_Library.listOrderById() %>

                <g:each in="${solidSpecimen}" var="item">
                    <g:if test="${positionInstance?.identifiedSample?.id ==item.id}">
                        <td><g:link controller="solidSpecimen" action="show" id="${positionInstance.identifiedSample.id}">${fieldValue(bean: positionInstance, field: "identifiedSample")}</g:link></td>
                    </g:if>
                </g:each>

                <g:each in="${fluidSpecimen}" var="item">
                    <g:if test="${positionInstance?.identifiedSample?.id ==item.id}">
                        <td><g:link controller="fluidSpecimen" action="show" id="${positionInstance.identifiedSample.id}">${fieldValue(bean: positionInstance, field: "identifiedSample")}</g:link></td>
                    </g:if>
                </g:each>

                <g:each in="${aliquots}" var="item">
                    <g:if test="${positionInstance?.identifiedSample?.id ==item.id}">
                        <td><g:link controller="aliquot" action="show" id="${positionInstance.identifiedSample.id}">${fieldValue(bean: positionInstance, field: "identifiedSample")}</g:link></td>
                    </g:if>
                </g:each>

                <g:each in="${DNAExtract}" var="item">
                    <g:if test="${positionInstance?.identifiedSample?.id ==item.id}">
                        <td><g:link controller="DNA_Extract" action="show" id="${positionInstance.identifiedSample.id}">${fieldValue(bean: positionInstance, field: "identifiedSample")}</g:link></td>
                    </g:if>
                </g:each>

                <g:each in="${DNALibrary}" var="item">
                    <g:if test="${positionInstance?.identifiedSample?.id ==item.id}">
                        <td><g:link controller="DNA_Library" action="show" id="${positionInstance.identifiedSample.id}">${fieldValue(bean: positionInstance, field: "identifiedSample")}</g:link></td>
                    </g:if>
                </g:each>
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
