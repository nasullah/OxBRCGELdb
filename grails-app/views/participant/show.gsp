<%@ page import="geldb.FluidSpecimen; geldb.Participant" %>
<%@ page import="geldb.SolidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'participant.label', default: 'Participant')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-participant" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="participant.familyName.label" default="Family Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: participantInstance, field: "familyName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="participant.givenName.label" default="Given Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: participantInstance, field: "givenName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="participant.dateOfBirth.label" default="Date Of Birth" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${participantInstance?.dateOfBirth}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="participant.gender.label" default="Gender" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: participantInstance, field: "gender")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="participant.nHSNumber.label" default="NHS Number" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: participantInstance, field: "nHSNumber")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="participant.hospitalNumber.label" default="Hospital Number" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: participantInstance, field: "hospitalNumber")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="participant.diagnosis.label" default="Diagnosis" /></td>
				
				<td valign="top" class="value"><g:link controller="ICD10" action="show" id="${participantInstance?.diagnosis?.id}">${participantInstance?.diagnosis?.encodeAsHTML()}</g:link></td>
				
			</tr>

            <g:if test="${participantInstance.specimen !=null}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="participant.specimen.label" default="Specimen" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <% def solidSpecimen = SolidSpecimen.listOrderById() %>
                        <% def fluidSpecimen = FluidSpecimen.listOrderById() %>

                        <ul>
                            <g:each in="${solidSpecimen}" var="item">
                                <g:each in="${participantInstance.specimen}" var="s">
                                    <g:if test="${item.id ==s.id}">
                                        <li><g:link controller="solidSpecimen" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
                                    </g:if>
                                </g:each>
                            </g:each>
                        </ul>
                        <ul>
                            <g:each in="${fluidSpecimen}" var="item">
                                <g:each in="${participantInstance.specimen}" var="s">
                                    <g:if test="${item.id ==s.id}">
                                        <li><g:link controller="fluidSpecimen" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
                                    </g:if>
                                </g:each>
                            </g:each>
                        </ul>
                    </td>

                </tr>
            </g:if>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="participant.studySubject.label" default="Study Subject" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${participantInstance.studySubject}" var="s">
						<li><g:link controller="studySubject" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="studySubject" action="create" params="['participant.id': participantInstance?.id]">Associate Participant with Study </g:link>
    </a></div>
</div>

<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="fluidSpecimen" action="create" params="['participant.id': participantInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'fluidSpecimen.label', default: 'Fluid Specimen')])}</g:link>
    </a></div>
</div>

<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="solidSpecimen" action="create" params="['participant.id': participantInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'solidSpecimen.label', default: 'Solid Specimen')])}</g:link>
    </a></div>
</div>
<hr style="border:1; height:1px" />

</body>

</html>
