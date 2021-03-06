
<%@ page import="geldb.TumourType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'tumourType.label', default: 'Tumour Type')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
	<r:require module="filterpane" />
</head>

<body>

<hr/>

<filterpane:filterButton text="Filter This List" />
<filterpane:filterPane domain="geldb.TumourType"
					   associatedProperties="tumourLocation.tumourLocation"/>

<hr/>

<p>Number of records: ${tumourTypeInstanceTotal == null ? TumourType.count(): tumourTypeInstanceTotal}</p>


<section id="list-tumourType" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<th><g:message code="tumourType.tumourLocation.label" default="Tumour Location" /></th>
			
				<g:sortableColumn property="tumourType" title="${message(code: 'tumourType.tumourType.label', default: 'Tumour Type')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${tumourTypeInstanceList}" status="i" var="tumourTypeInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${tumourTypeInstance.id}">${fieldValue(bean: tumourTypeInstance, field: "tumourLocation")}</g:link></td>
			
				<td>${fieldValue(bean: tumourTypeInstance, field: "tumourType")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${tumourTypeInstanceTotal == null ? TumourType.count(): tumourTypeInstanceTotal}" params="${filterParams}" />
	</div>
</section>

</body>

</html>
