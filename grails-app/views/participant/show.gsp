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

                <g:if test="${participantInstance.gender}">
                    <td valign="top" class="value">${fieldValue(bean: participantInstance, field: "gender")}</td>                </g:if>
                <g:else>
                    <td valign="top" class="value"><p class="text-danger">Please enter gender by clicking the Edit Participant button</p></td>
                </g:else>
				
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

                <g:if test="${participantInstance.diagnosis}">
                    <td valign="top" class="value"><g:link controller="ICD10" action="show" id="${participantInstance?.diagnosis?.id}">${participantInstance?.diagnosis?.encodeAsHTML()}</g:link></td>
                </g:if>
                <g:else>
                    <td valign="top" class="value"><p class="text-danger">Please enter diagnosis by clicking the Edit Participant button</p></td>
                </g:else>

			</tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="participant.centre.label" default="Centre" /></td>

                <td valign="top" class="value"><g:link controller="centre" action="show" id="${participantInstance?.centre?.id}">${participantInstance?.centre?.encodeAsHTML()}</g:link></td>

            </tr>

            <g:if test="${participantInstance.studySubject}">
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
            </g:if>

            %{--<g:if test="${participantInstance.specimen}">--}%
                %{--<tr class="prop">--}%
                    %{--<td valign="top" class="name"><g:message code="participant.specimen.label" default="Specimen" /></td>--}%

                    %{--<td valign="top" style="text-align: left;" class="value">--}%
                        %{--<% def solidSpecimen = SolidSpecimen.listOrderById() %>--}%
                        %{--<% def fluidSpecimen = FluidSpecimen.listOrderById() %>--}%

                        %{--<ul>--}%
                            %{--<g:each in="${solidSpecimen}" var="item">--}%
                                %{--<g:each in="${participantInstance.specimen}" var="s">--}%
                                    %{--<g:if test="${item.id ==s.id}">--}%
                                        %{--<li><g:link controller="solidSpecimen" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>--}%
                                    %{--</g:if>--}%
                                %{--</g:each>--}%
                            %{--</g:each>--}%
                        %{--</ul>--}%
                        %{--<ul>--}%
                            %{--<g:each in="${fluidSpecimen}" var="item">--}%
                                %{--<g:each in="${participantInstance.specimen}" var="s">--}%
                                    %{--<g:if test="${item.id ==s.id}">--}%
                                        %{--<li><g:link controller="fluidSpecimen" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>--}%
                                    %{--</g:if>--}%
                                %{--</g:each>--}%
                            %{--</g:each>--}%
                        %{--</ul>--}%
                    %{--</td>--}%

                %{--</tr>--}%
            %{--</g:if>--}%
		
		</tbody>
	</table>
</section>

<hr style="border:1; height:1px" />

<p class="text-primary">Available Action</p>

<g:if test="${!participantInstance.studySubject}">
    <a class='btn btn-primary btn-small' <g:link controller="studySubject" action="create" params="['participant.id': participantInstance?.id]"><i class="glyphicon glyphicon-plus"></i> Associate Participant with a Study </g:link>
</g:if>
<g:else>
    <a class='btn btn-primary btn-small' <g:link controller="studySubject" action="create" params="['participant.id': participantInstance?.id]"><i class="glyphicon glyphicon-plus"></i> Associate Participant with another Study </g:link>
</g:else>

<hr style="border:1; height:1px" />

</body>

</html>
