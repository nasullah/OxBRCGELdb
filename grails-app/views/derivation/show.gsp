
<%@ page import="geldb.Derivation" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'derivation.label', default: 'Derivation')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-derivation" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="derivation.aliquot.label" default="Aliquot" /></td>
				
				<td valign="top" class="value"><g:link controller="aliquot" action="show" id="${derivationInstance?.aliquot?.id}">${derivationInstance?.aliquot?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="derivation.derivationTimeDate.label" default="Derivation Time Date" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${derivationInstance?.derivationTimeDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="derivation.derivedBy.label" default="Derived By" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${derivationInstance?.derivedBy?.id}">${derivationInstance?.derivedBy?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="derivation.derivationProcess.label" default="Derivation Process" /></td>
				
				<td valign="top" class="value">${derivationInstance?.derivationProcess?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="derivation.notes.label" default="Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: derivationInstance, field: "notes")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="derivation.derivedAliquots.label" default="Derived Aliquots" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${derivationInstance.derivedAliquots}" var="d">
						<li><g:link controller="aliquot" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="derivation.report.label" default="Report" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${derivationInstance.report}" var="r">
						<li><g:link controller="report" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>
<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="aliquot" action="create" params="['derivedFrom.id': derivationInstance?.id, 'specimen': derivationInstance.aliquot?.specimen?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Aliquot Made From Derivation')])}</g:link>
    </a></div>
</div>
<div>
<hr style="border:1; height:1px" />
    Available Reports
</div>
<hr style="border:1; height:1px" />
<div class="one-to-many">
<div><a class='btn btn-primary btn-small' <g:link controller="fixationReport" action="create" params="['derivation.id': derivationInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'fixationReport.label', default: 'Fixation Report')])}</g:link>
</a></div>
</div>
<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="centrifugation" action="create" params="['derivation.id': derivationInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'centrifugation.label', default: 'Centrifugation Report')])}</g:link>
    </a></div>
</div>
<hr style="border:1; height:1px" />

<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="solidSpecimenReport" action="create" params="['derivation.id': derivationInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'solidSpecimenReport.label', default: 'Solid Specimen Report')])}</g:link>
    </a></div>
</div>

<hr style="border:1; height:1px" />
</body>

</html>
