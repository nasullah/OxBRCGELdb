
<%@ page import="geldb.StudySubject" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'studySubject.label', default: 'Study Subject')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-studySubject" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="studySubject.participant.label" default="Participant" /></td>
				
				<td valign="top" class="value"><g:link controller="participant" action="show" id="${studySubjectInstance?.participant?.id}">${studySubjectInstance?.participant?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="studySubject.study.label" default="Study" /></td>
				
				<td valign="top" class="value"><g:link controller="study" action="show" id="${studySubjectInstance?.study?.id}">${studySubjectInstance?.study?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="studySubject.studySubjectIdentifier.label" default="Study Subject Identifier" /></td>

                <g:if test="${studySubjectInstance.studySubjectIdentifier}">
                    <td valign="top" class="value">${fieldValue(bean: studySubjectInstance, field: "studySubjectIdentifier")}</td>
                </g:if>
                <g:else>
                    <td valign="top" class="value"><p class="text-danger">Please enter GeL ID by clicking the Edit Study Subject button</p></td>
                </g:else>

			</tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="studySubject.consentFormVersion.label" default="Consent Form Version" /></td>

                <td valign="top" class="value">${fieldValue(bean: studySubjectInstance, field: "consentFormVersion")}</td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="studySubject.consentStatus.label" default="Consent Status" /></td>
				
                <g:if test="${studySubjectInstance.consentStatus == null}">
                    <td valign="top" class="value"><p class="text-danger">Not completed</p></td>
                </g:if>
                <g:else >
                    <td valign="top" class="value"><g:formatBoolean boolean="${studySubjectInstance?.consentStatus}" true="Yes" false="No"/></td>
                </g:else>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="studySubject.recruitmentDate.label" default="Recruitment Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${studySubjectInstance?.recruitmentDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="studySubject.recruitedBy.label" default="Recruited By" /></td>

                <td valign="top" class="value">${fieldValue(bean: studySubjectInstance, field: "recruitedBy")}</td>

            </tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
