
<%@ page import="geldb.Centrifugation" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'centrifugation.label', default: 'Centrifugation Report')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-centrifugation" class="first">

	<table class="table">
		<tbody>

        <g:if test="${centrifugationInstance?.derivation?.id !=null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="centrifugation.derivation.label" default="Derivation" /></td>

                <td valign="top" class="value"><g:link controller="derivation" action="show" id="${centrifugationInstance?.derivation?.id}">${centrifugationInstance?.derivation?.encodeAsHTML()}</g:link></td>

            </tr>
        </g:if>
        <g:if test="${centrifugationInstance?.specimen?.id !=null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="centrifugation.specimen.label" default="Specimen" /></td>

                <td valign="top" class="value"><g:link controller="specimen" action="show" id="${centrifugationInstance?.specimen?.id}">${centrifugationInstance?.specimen?.encodeAsHTML()}</g:link></td>

            </tr>
        </g:if>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="centrifugation.reportDate.label" default="Report Date" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${centrifugationInstance?.reportDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="centrifugation.reportStaff.label" default="Report Staff" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${centrifugationInstance?.reportStaff?.id}">${centrifugationInstance?.reportStaff?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="centrifugation.comments.label" default="Comments" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: centrifugationInstance, field: "comments")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="centrifugation.timeReceived.label" default="Time Received" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: centrifugationInstance, field: "timeReceived")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="centrifugation.priorTemporarySampleTemperature.label" default="Prior Temporary Sample Temperature" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: centrifugationInstance, field: "priorTemporarySampleTemperature")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="centrifugation.postTemporarySampleTemperature.label" default="Post Temporary Sample Temperature" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: centrifugationInstance, field: "postTemporarySampleTemperature")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="centrifugation.timePutIntoTemporaryStorage.label" default="Time Put Into Temporary Storage" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: centrifugationInstance, field: "timePutIntoTemporaryStorage")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="centrifugation.timePutIntoLongStorage.label" default="Time Put Into Long Storage" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: centrifugationInstance, field: "timePutIntoLongStorage")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="centrifugation.firstCentrifugation.label" default="First Centrifugation" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: centrifugationInstance, field: "firstCentrifugation")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="centrifugation.secondCentrifugation.label" default="Second Centrifugation" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: centrifugationInstance, field: "secondCentrifugation")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>
<g:if test="${secondCentrifugation ==null}">
    <hr style="border:1; height:1px" />
    <div class="one-to-many">


        <div><a class='btn btn-primary btn-small' <g:link controller="centrifugation" action="edit" id="${centrifugationInstance?.id}">${message(code: 'default.add.label', args: [message(code: 'SampleAcquisition.label', default: 'Add Second Centrifugation')])}</g:link>
        </a></div>
    </div>
    <hr style="border:1; height:1px" />
</g:if>
</body>

</html>
