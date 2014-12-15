
<%@ page import="geldb.SequencingRun" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'sequencingRun.label', default: 'Sequencing Run')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-sequencingRun" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sequencingRun.runDate.label" default="Run Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${sequencingRunInstance?.runDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sequencingRun.machineName.label" default="Machine Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: sequencingRunInstance, field: "machineName")}</td>
				
			</tr>

            <g:if test="${sequencingRunInstance.loadedFlowCell}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="sequencingRun.loadedFlowCell.label" default="Loaded Flow Cell" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <ul>
                        <g:each in="${sequencingRunInstance.loadedFlowCell}" var="l">
                            <li><g:link controller="flowCell" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>
                        </g:each>
                        </ul>
                    </td>

                </tr>
            </g:if>

            <g:if test="${sequencingRunInstance.sequencingReports}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="sequencingRun.sequencingReports.label" default="Sequencing Reports" /></td>

                    <td valign="top" class="value"><g:link controller="sequencingReports" action="show" id="${sequencingRunInstance?.sequencingReports?.id}">${sequencingRunInstance?.sequencingReports?.encodeAsHTML()}</g:link></td>

                </tr>
             </g:if>
		
		</tbody>
	</table>
</section>

<hr style="border:1; height:1px" />

<p class="text-primary">Available Actions</p>

<a class='btn btn-primary btn-small' <g:link controller="flowCell" action="create" params="['sequencingRun.id': sequencingRunInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'flowCell.label', default: 'Flow Cell')])}</g:link>

<g:if test="${sequencingRunInstance?.sequencingReports ==null}">
    <a class='btn btn-primary btn-small' <g:link controller="sequencingReports" action="create" params="['sequencingRun.id': sequencingRunInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'sequencingReports.label', default: 'Sequencing Reports')])}</g:link>
</g:if>

<hr style="border:1; height:1px" />

</body>

</html>
