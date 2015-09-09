
<%@ page import="geldb.DispatchItem" %>
<%@ page import="geldb.DNA_Library; geldb.DNA_Extract" %>
<%@ page import="geldb.SolidSpecimen" %>
<%@ page import="geldb.FluidSpecimen" %>
<%@ page import="geldb.Aliquot" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'dispatchItem.label', default: 'Dispatch Item')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-dispatchItem" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchItem.dispatchedBox.label" default="Dispatched Box" /></td>
				
				<td valign="top" class="value"><g:link controller="dispatchedBox" action="show" id="${dispatchItemInstance?.dispatchedBox?.id}">${dispatchItemInstance?.dispatchedBox?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchItem.positionIfPlated.label" default="Position If Plated" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: dispatchItemInstance, field: "positionIfPlated")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchItem.volume_ul.label" default="Volume ul" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: dispatchItemInstance, field: "volume_ul")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="dispatchItem.identifiedSample.label" default="Sample" /></td>

                <% def solidSpecimen = SolidSpecimen.listOrderById() %>
                <% def fluidSpecimen = FluidSpecimen.listOrderById() %>
                <% def aliquots = Aliquot.listOrderById() %>
                <% def DNAExtract = DNA_Extract.listOrderById() %>
                <% def DNALibrary = DNA_Library.listOrderById() %>

                <g:each in="${solidSpecimen}" var="item">
                    <g:each in="${dispatchItemInstance.identifiedSample}" var="pos">
                        <g:if test="${pos.id ==item.id}">
                            <td valign="top" class="value"><g:link controller="solidSpecimen" action="show" id="${item.id}">${item}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>

                <g:each in="${fluidSpecimen}" var="item">
                    <g:each in="${dispatchItemInstance.identifiedSample}" var="pos">
                        <g:if test="${pos.id ==item.id}">
                            <td valign="top" class="value"><g:link controller="fluidSpecimen" action="show" id="${item.id}">${item}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>

                <g:each in="${aliquots}" var="item">
                    <g:each in="${dispatchItemInstance.identifiedSample}" var="pos">
                        <g:if test="${pos.id ==item.id}">
                            <td valign="top" class="value"><g:link controller="aliquot" action="show" id="${item.id}">${item}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>

                <g:each in="${DNAExtract}" var="item">
                    <g:each in="${dispatchItemInstance.identifiedSample}" var="pos">
                        <g:if test="${pos.id ==item.id}">
                            <td valign="top" class="value"><g:link controller="DNA_Extract" action="show" id="${item.id}">${item}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>

                <g:each in="${DNALibrary}" var="item">
                    <g:each in="${dispatchItemInstance.identifiedSample}" var="pos">
                        <g:if test="${pos.id ==item.id}">
                            <td valign="top" class="value"><g:link controller="DNA_Library" action="show" id="${item.id}">${item}</g:link></td>
                        </g:if>
                    </g:each>
                </g:each>
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
