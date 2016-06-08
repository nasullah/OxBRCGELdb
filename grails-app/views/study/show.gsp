
<%@ page import="geldb.Study" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'study.label', default: 'Consent Type')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-study" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="study.studyName.label" default="Consent Type" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: studyInstance, field: "studyName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="study.studyIdentifiers.label" default="Study Identifiers" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${studyInstance.studyIdentifiers}" var="s">
						<li><g:link controller="studyIdentifier" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

<hr/>

<p class="text-primary">Available Actions</p>

<div class="one-to-many">
    <div>
		<a class='btn btn-primary btn-xs' <g:link controller="studyIdentifier" action="create" params="['study.id': studyInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'studyIdentifier.label', default: 'Study Identifier')])}</g:link></a>
	</div>
</div>

<hr/>

<sec:ifAnyGranted roles="ROLE_ADMIN">
	<h2>Audit</h2>
	<section id="list-participant" class="first">

		<table class="table table-bordered margin-top-medium">
			<thead>
			<tr>
				<g:sortableColumn property="dateCreated" title="Date & Time" />

				<g:sortableColumn property="actor" title="Username" />

				<g:sortableColumn property="eventName" title="Event" />

				<g:sortableColumn property="persistedObjectId" title="Record" />

				<g:sortableColumn property="oldValue" title="Old Value" />

				<g:sortableColumn property="newValue" title="New Value" />

			</tr>
			</thead>
			<tbody>
			<g:each in="${listAuditLogData}" status="i" var="auditLogInstance">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

					<td><g:formatDate date="${auditLogInstance.dateCreated}" /></td>

					<td>${fieldValue(bean: auditLogInstance, field: "actor")}</td>

					<td>${fieldValue(bean: auditLogInstance, field: "eventName")} Consent Type</td>

					<td>${studyInstance.id}</td>

					<td>${fieldValue(bean: auditLogInstance, field: "oldValue")}</td>

					<td>${fieldValue(bean: auditLogInstance, field: "newValue")}</td>

				</tr>
			</g:each>
			</tbody>
		</table>

	</section>
</sec:ifAnyGranted>

</body>

</html>
