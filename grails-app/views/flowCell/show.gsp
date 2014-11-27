
<%@ page import="geldb.FlowCell" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'flowCell.label', default: 'Flow Cell')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-flowCell" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="flowCell.sequencingRun.label" default="Sequencing Run" /></td>
				
				<td valign="top" class="value"><g:link controller="sequencingRun" action="show" id="${flowCellInstance?.sequencingRun?.id}">${flowCellInstance?.sequencingRun?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="flowCell.libraryLoadingConcentration.label" default="Library Loading Concentration" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: flowCellInstance, field: "libraryLoadingConcentration")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="flowCell.clusterDensity.label" default="Cluster Density" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: flowCellInstance, field: "clusterDensity")}</td>
				
			</tr>

            <g:if test="${flowCellInstance.containedLane}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="flowCell.containedLane.label" default="Contained Lane" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <ul>
                        <g:each in="${flowCellInstance.containedLane}" var="c">
                            <li><g:link controller="lane" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                        </g:each>
                        </ul>
                    </td>

                </tr>
            </g:if>
		
		</tbody>
	</table>
</section>

<hr style="border:1; height:1px" />

<p class="text-primary">Available Action</p>

<g:if test="${flowCellInstance.containedLane.size() <= 1}">
    <a class='btn btn-primary btn-small' <g:link controller="lane" action="create" params="['flowCell.id': flowCellInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'lane.label', default: 'Lane')])}</g:link>
</g:if>

<hr style="border:1; height:1px" />
</body>

</html>
