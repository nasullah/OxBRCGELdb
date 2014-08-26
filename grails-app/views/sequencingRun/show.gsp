
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
				
				<td valign="top" class="value"><g:formatDate date="${sequencingRunInstance?.runDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sequencingRun.machineName.label" default="Machine Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: sequencingRunInstance, field: "machineName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="sequencingRun.sequencingReports.label" default="Sequencing Reports" /></td>
				
				<td valign="top" class="value"><g:link controller="sequencingReports" action="show" id="${sequencingRunInstance?.sequencingReports?.id}">${sequencingRunInstance?.sequencingReports?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
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
		
		</tbody>
	</table>
</section>
<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="flowCell" action="create" params="['sequencingRun.id': sequencingRunInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'flowCell.label', default: 'Flow Cell')])}</g:link>
    </a></div>
</div>
<hr style="border:1; height:1px" />
<g:if test="${sequencingRunInstance?.sequencingReports ==null}">
    <div class="one-to-many">
        <div><a class='btn btn-primary btn-small' <g:link controller="sequencingReports" action="create" params="['sequencingRun.id': sequencingRunInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sequencingReports.label', default: 'Sequencing Reports')])}</g:link>
        </a></div>
    </div>
    <hr style="border:1; height:1px" />
</g:if>
</body>

</html>
