
<%@ page import="geldb.Derivation" %>
<%@ page import="geldb.FixationReport" %>
<%@ page import="geldb.Centrifugation" %>

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
				<td valign="top" class="name"><g:message code="derivation.derivationDate.label" default="Derivation Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${derivationInstance?.derivationDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="derivation.derivationTime.label" default="Derivation Time" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: derivationInstance, field: "derivationTime")}</td>
				
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
				<td valign="top" class="name"><g:message code="derivation.centrifugation.label" default="Report" /></td>
				
				<td valign="top" class="value"><g:link controller="centrifugation" action="show" id="${derivationInstance?.centrifugation?.id}">${derivationInstance?.centrifugation?.encodeAsHTML()}</g:link></td>
                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${derivationInstance.centrifugation}" var="d">
                            <li><g:link controller="centrifugation" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>
                %{--<td valign="top" style="text-align: left;" class="value">--}%
                    %{--<% def fixationReport = FixationReport.listOrderById() %>--}%
                    %{--<% def centrifugation = Centrifugation.listOrderById() %>--}%

                    %{--<ul>--}%
                        %{--<g:each in="${fixationReport}" var="item">--}%
                            %{--<g:each in="${derivationInstance.report}" var="s">--}%
                                %{--<g:if test="${item.id ==s.id}">--}%
                                    %{--<li><g:link controller="fixationReport" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>--}%
                                %{--</g:if>--}%
                            %{--</g:each>--}%
                        %{--</g:each>--}%
                    %{--</ul>--}%
                    %{--<ul>--}%
                        %{--<g:each in="${centrifugation}" var="item">--}%
                            %{--<g:each in="${derivationInstance.report}" var="s">--}%
                                %{--<g:if test="${item.id ==s.id}">--}%
                                    %{--<li><g:link controller="centrifugation" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>--}%
                                %{--</g:if>--}%
                            %{--</g:each>--}%
                        %{--</g:each>--}%
                    %{--</ul>--}%
                %{--</td>--}%
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
<g:if test="${!derivationInstance.centrifugation}">
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
</g:if>

</body>

</html>
