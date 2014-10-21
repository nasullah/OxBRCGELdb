
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
		
		</tbody>
	</table>
</section>
<g:if test="${flowCellInstance.containedLane.size() <= 1}">
    <hr style="border:1; height:1px" />
    <div class="one-to-many">
        <div><a class='btn btn-primary btn-small' <g:link controller="lane" action="create" params="['flowCell.id': flowCellInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'lane.label', default: 'Lane')])}</g:link>
        </a></div>
    </div>
</g:if>
<hr style="border:1; height:1px" />
</body>

</html>
