
<%@ page import="geldb.PathologyImage" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'pathologyImage.label', default: 'Pathology Image')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-pathologyImage" class="first">

	<table class="table">
		<tbody>

            <g:if test="${pathologyImageInstance?.solidSpecimenReport?.id !=null}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="pathologyImage.solidSpecimenReport.label" default="Solid Specimen Report" /></td>

                    <td valign="top" class="value"><g:link controller="FFPE_Tissue_Report" action="show" id="${pathologyImageInstance?.solidSpecimenReport?.id}">${pathologyImageInstance?.solidSpecimenReport?.encodeAsHTML()}</g:link></td>

                </tr>
            </g:if>

            <g:if test="${pathologyImageInstance?.gelSuitabilityReport?.id !=null}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="pathologyImage.gelSuitabilityReport.label" default="Gel Suitability Report" /></td>

                    <td valign="top" class="value"><g:link controller="gelSuitabilityReport" action="show" id="${pathologyImageInstance?.gelSuitabilityReport?.id}">${pathologyImageInstance?.gelSuitabilityReport?.encodeAsHTML()}</g:link></td>

                </tr>
            </g:if>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pathologyImage.takenDate.label" default="Taken Date" /></td>

                <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${pathologyImageInstance?.takenDate}" /></td>

            </tr>

			<tr class="prop">
				<td valign="top" class="name"><g:message code="pathologyImage.takenBy.label" default="Taken By" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: pathologyImageInstance, field: "takenBy")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="pathologyImage.type.label" default="Type" /></td>
				
				<td valign="top" class="value">${pathologyImageInstance?.type?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="pathologyImage.samplePointer.label" default="Sample Pointer" /></td>
				
                <td valign="top" class="value"><g:link action="download" id="${pathologyImageInstance.id}">${pathologyImageInstance.samplePointer}</g:link></td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>
