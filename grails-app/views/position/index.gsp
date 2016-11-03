
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
    <r:require module="filterpane" />
</head>

<body>

<p>
<p>
<div style="background: rgba(80, 110, 56, 0.04);">
    <div class="container">
        <p>
        <h5 class="text-center">Search Options</h5>
        <p>
            <filterpane:filterButton text="Filter This List" />
            <filterpane:filterPane domain="geldb.Position"
                                   associatedProperties="plateOrBox.identifier, plateOrBox.shelf.shelfName,
                                                 plateOrBox.shelf.shelfName, plateOrBox.shelf.freezer.freezerName"/>
        <p>
        <p>
    </div>
</div>

<hr/>

<section id="index-position" class="first">

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
                            <td><g:link controller="solidSpecimen" action="show" id="${item.id}">${item}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>

                <g:each in="${fluidSpecimen}" var="item">
                    <g:each in="${positionInstance.containedSamples}" var="pos">
                        <g:if test="${pos.id ==item.id}">
                            <td><g:link controller="fluidSpecimen" action="show" id="${item.id}">${item}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>

                <g:each in="${aliquots}" var="item">
                    <g:each in="${positionInstance.containedSamples}" var="pos">
                        <g:if test="${pos.id ==item.id && !item.exhausted}">
                            <td><g:link controller="aliquot" action="show" id="${item.id}">${item}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>

                <g:each in="${DNAExtract}" var="item">
                    <g:each in="${positionInstance.containedSamples}" var="pos">
                        <g:if test="${pos.id ==item.id && !item.exhausted}">
                            <td><g:link controller="DNA_Extract" action="show" id="${item.id}">${item}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>

                <g:each in="${DNALibrary}" var="item">
                    <g:each in="${positionInstance.containedSamples}" var="pos">
                        <g:if test="${pos.id ==item.id}">
                            <td><g:link controller="DNA_Library" action="show" id="${item.id}">${item}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>

                <g:if test="${!positionInstance.containedSamples}">
                    <td></td>
                </g:if>

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
