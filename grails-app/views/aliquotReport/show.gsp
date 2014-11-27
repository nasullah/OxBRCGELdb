
<%@ page import="geldb.AliquotReport" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'aliquotReport.label', default: 'Aliquot Report')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-aliquotReport" class="first">

	<table class="table">
		<tbody>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquotReport.aliquot.label" default="Aliquot" /></td>

                <td valign="top" class="value"><g:link controller="aliquot" action="show" id="${aliquotReportInstance?.aliquot?.id}">${aliquotReportInstance?.aliquot?.encodeAsHTML()}</g:link></td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.reportDate.label" default="Report Date" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${aliquotReportInstance?.reportDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.reportStaff.label" default="Report Staff" /></td>
				
				<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${aliquotReportInstance?.reportStaff?.id}">${aliquotReportInstance?.reportStaff?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.comments.label" default="Comments" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: aliquotReportInstance, field: "comments")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.percentageOfTumourInSample.label" default="Percentage Of Tumour In Sample" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: aliquotReportInstance, field: "percentageOfTumourInSample")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.cellularity.label" default="Cellularity" /></td>
				
				<td valign="top" class="value">${aliquotReportInstance?.cellularity?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.dysplasticNonInvasiveElements.label" default="Dysplastic Non Invasive Elements" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${aliquotReportInstance?.dysplasticNonInvasiveElements}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.sysplasticNonInvasiveNotes.label" default="Sysplastic Non Invasive Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: aliquotReportInstance, field: "sysplasticNonInvasiveNotes")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.tumourContentVerifiedBy.label" default="Tumour Content Verified By" /></td>
				
				<td valign="top" class="value">${aliquotReportInstance?.tumourContentVerifiedBy?.encodeAsHTML()}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.tumourContentVerificationOther.label" default="Tumour Content Verification Other" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: aliquotReportInstance, field: "tumourContentVerificationOther")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.percentageNecrosis.label" default="Percentage Necrosis" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: aliquotReportInstance, field: "percentageNecrosis")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.microMacroDissectionUsedToEnrichSample.label" default="Micro Macro Dissection Used To Enrich Sample" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${aliquotReportInstance?.microMacroDissectionUsedToEnrichSample}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.detailsOfMacroMicrodissection.label" default="Details of Macro Micro Dissection" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: aliquotReportInstance, field: "detailsOfMacroMicrodissection")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.suitableForExtraction.label" default="Suitable For Extraction" /></td>
				
				<td valign="top" class="value"><g:link controller="DNAExtractionStatus" action="show" id="${aliquotReportInstance?.suitableForExtraction?.id}">${aliquotReportInstance?.suitableForExtraction?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="aliquotReport.aliquotPhoto.label" default="Aliquot Photo" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${aliquotReportInstance.aliquotPhoto}" var="a">
						<li><g:link controller="aliquotPhoto" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

<hr style="border:1; height:1px" />

<p class="text-primary">Available Action</p>

<a class='btn btn-primary btn-small' <g:link controller="aliquotPhoto" action="create" params="['aliquot.id': aliquotReportInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'aliquotPhoto.label', default: 'Aliquot Photo')])}</g:link>

<hr style="border:1; height:1px" />

</body>

</html>
