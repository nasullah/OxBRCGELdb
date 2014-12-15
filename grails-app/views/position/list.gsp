
<%@ page import="geldb.DNA_Library; geldb.DNA_Extract; geldb.Position" %>
<%@ page import="geldb.SolidSpecimen" %>
<%@ page import="geldb.FluidSpecimen" %>
<%@ page import="geldb.Aliquot" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'position.label', default: 'Position')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<section id="list-position" class="first">

	<table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <th><g:message code="position.plateOrBox.label" default="Box" /></th>

            <g:sortableColumn property="letter" title="${message(code: 'position.letter.label', default: 'Letter')}" />

            <g:sortableColumn property="number" title="${message(code: 'position.number.label', default: 'Number')}" />

            <th><g:message code="position.identifiedSample.label" default="Contained Sample" /></th>

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
                    <g:each in="${positionInstance.containedSamples}" var="pos">
                        <g:if test="${pos.id ==item.id}">
                            <td><g:link controller="solidSpecimen" action="show" id="${positionInstance.containedSamples.id}">${fieldValue(bean: positionInstance, field: "containedSamples")}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>

                <g:each in="${fluidSpecimen}" var="item">
                    <g:each in="${positionInstance.containedSamples}" var="pos">
                        <g:if test="${pos.id ==item.id}">
                            <td><g:link controller="fluidSpecimen" action="show" id="${positionInstance.containedSamples.id}">${fieldValue(bean: positionInstance, field: "containedSamples")}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>

                <g:each in="${aliquots}" var="item">
                    <g:each in="${positionInstance.containedSamples}" var="pos">
                        <g:if test="${pos.id ==item.id}">
                            <td><g:link controller="aliquot" action="show" id="${positionInstance.containedSamples.id}">${fieldValue(bean: positionInstance, field: "containedSamples")}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>

                <g:each in="${DNAExtract}" var="item">
                    <g:each in="${positionInstance.containedSamples}" var="pos">
                        <g:if test="${pos.id ==item.id}">
                            <td><g:link controller="DNA_Extract" action="show" id="${positionInstance.containedSamples.id}">${fieldValue(bean: positionInstance, field: "containedSamples")}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>

                <g:each in="${DNALibrary}" var="item">
                    <g:each in="${positionInstance.containedSamples}" var="pos">
                        <g:if test="${pos.id ==item.id}">
                            <td><g:link controller="DNA_Library" action="show" id="${positionInstance.containedSamples.id}">${fieldValue(bean: positionInstance, field: "containedSamples")}</g:link></td>
                        </g:if>
                    </g:each>
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
