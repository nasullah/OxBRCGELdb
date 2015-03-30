
<%@ page import="geldb.DNA_Library; geldb.DNA_Extract; geldb.Position" %>
<%@ page import="geldb.SolidSpecimen" %>
<%@ page import="geldb.FluidSpecimen" %>
<%@ page import="geldb.Aliquot" %>

<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'position.label', default: 'Position')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-position" class="first">

	<table class="table">
		<tbody>


		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="position.plateOrBox.label" default="Plate Or Box" /></td>
				
				<td valign="top" class="value"><g:link controller="plateOrBox" action="show" id="${positionInstance?.plateOrBox?.id}">${positionInstance?.plateOrBox?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="position.letter.label" default="Letter" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: positionInstance, field: "letter")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="position.number.label" default="Number" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: positionInstance, field: "number")}</td>
				
			</tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="position.containedSamples.label" default="Contained Samples" /></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>

                        <% def solidSpecimen = SolidSpecimen.listOrderById() %>
                        <% def fluidSpecimen = FluidSpecimen.listOrderById() %>
                        <% def aliquots = Aliquot.listOrderById() %>
                        <% def DNAExtract = DNA_Extract.listOrderById() %>
                        <% def DNALibrary = DNA_Library.listOrderById() %>

                        <g:each in="${solidSpecimen}" var="item">
                            <g:each in="${positionInstance.containedSamples}" var="pos">
                                <g:if test="${pos.id ==item.id}">
                                    <li><g:link controller="solidSpecimen" action="show" id="${item.id}">${item}</g:link></li>
                                </g:if>
                            </g:each>
                        </g:each>

                        <g:each in="${fluidSpecimen}" var="item">
                            <g:each in="${positionInstance.containedSamples}" var="pos">
                                <g:if test="${pos.id ==item.id}">
                                    <li><g:link controller="fluidSpecimen" action="show" id="${item.id}">${item}</g:link></li>
                                </g:if>
                            </g:each>
                        </g:each>

                        <g:each in="${aliquots}" var="item">
                            <g:each in="${positionInstance.containedSamples}" var="pos">
                                <g:if test="${pos.id == item.id && !item.exhausted}">
                                    <li><g:link controller="aliquot" action="show" id="${item.id}">${item}</g:link></li>
                                </g:if>
                            </g:each>
                        </g:each>

                        <g:each in="${DNAExtract}" var="item">
                            <g:each in="${positionInstance.containedSamples}" var="pos">
                                <g:if test="${pos.id ==item.id && !item.exhausted}">
                                    <li><g:link controller="DNA_Extract" action="show" id="${item.id}">${item}</g:link></li>
                                </g:if>
                            </g:each>
                        </g:each>

                        <g:each in="${DNALibrary}" var="item">
                            <g:each in="${positionInstance.containedSamples}" var="pos">
                                <g:if test="${pos.id ==item.id}">
                                    <li><g:link controller="DNA_Library" action="show" id="${item.id}">${item}</g:link></li>
                                </g:if>
                            </g:each>
                        </g:each>
                    </ul>
                </td>
            </tr>

		</tbody>
	</table>
</section>

</body>

</html>
