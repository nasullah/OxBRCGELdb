
<%@ page import="geldb.PlateOrBox" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'plateOrBox.label', default: 'Plate or Box')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-plateOrBox" class="first">

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
	<div>
		<bs:paginate total="${plateOrBoxInstanceCount}" />
	</div>
</section>

</body>

</html>
