
<%@ page import="geldb.PlateOrBox" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'plateOrBox.label', default: 'Plate or Box')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
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
            <filterpane:filterPane domain="geldb.PlateOrBox"/>
        <p>
        <p>
    </div>
</div>

<hr/>

<div class="container">
    <div class="text-warning text-center">
        <b>
            <filterpane:isFiltered>Filter applied!</filterpane:isFiltered>
            <filterpane:isNotFiltered>Not filtered!</filterpane:isNotFiltered>
        </b>
    </div>
</div>

<p>Number of records: ${plateOrBoxInstanceTotal}</p>

<section id="list-plateOrBox" class="first">

	<table class="table table-bordered margin-top-medium">
        <thead>
        <tr>
            <g:sortableColumn property="identifier" title="${message(code: 'plateOrBox.identifier.label', default: 'Identifier')}" />

            <g:sortableColumn property="shelf.freezer" title="${message(code: 'shelf.freezer.label', default: 'Freezer')}" />

            <g:sortableColumn property="shelf.shelfName" title="${message(code: 'shelf.shelfName.label', default: 'Shelf')}" />

            <g:sortableColumn property="storageLocation" title="${message(code: 'plateOrBox.storageLocation.label', default: 'Storage Location')}" />

            <g:sortableColumn property="numberOfWells" title="${message(code: 'plateOrBox.numberOfWells.label', default: 'Number of Wells')}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${plateOrBoxInstanceList}" status="i" var="plateOrBoxInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" controller="plateOrBox" id="${plateOrBoxInstance?.id}">${fieldValue(bean: plateOrBoxInstance, field: "identifier")}</g:link></td>

                <td>${fieldValue(bean: plateOrBoxInstance?.shelf, field: "freezer")}</td>

                <td>${fieldValue(bean: plateOrBoxInstance?.shelf, field: "shelfName")}</td>

                <td>${fieldValue(bean: plateOrBoxInstance, field: "storageLocation")}</td>

                <td>${fieldValue(bean: plateOrBoxInstance, field: "numberOfWells")}</td>

            </tr>
        </g:each>
		</tbody>
	</table>
    <div class="pagination">
        <bs:paginate total="${plateOrBoxInstanceTotal == null ? PlateOrBox.count(): plateOrBoxInstanceTotal}" params="${filterParams}" />
    </div>
</section>

</body>

</html>
