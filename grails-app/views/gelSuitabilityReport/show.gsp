
<%@ page import="geldb.GelSuitabilityReport" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'gelSuitabilityReport.label', default: 'GeL Suitability Report')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-gelSuitabilityReport" class="first">

    <table class="table">
        <tbody>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.aliquot.label" default="Aliquot" /></td>

            <td valign="top" class="value"><g:link controller="aliquot" action="show" id="${gelSuitabilityReportInstance?.aliquot?.id}">${gelSuitabilityReportInstance?.aliquot?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.reportDate.label" default="Report Date" /></td>

            <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${gelSuitabilityReportInstance?.reportDate}" /></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.reportStaff.label" default="Report Staff" /></td>

            <td valign="top" class="value">${fieldValue(bean: gelSuitabilityReportInstance, field: "reportStaff")}</td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.comments.label" default="Comments" /></td>

            <td valign="top" class="value">${fieldValue(bean: gelSuitabilityReportInstance, field: "comments")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.handE_pathreview.label" default="H and E pathologist review" /></td>

            <g:if test="${gelSuitabilityReportInstance.handE_pathreview == null}">
                <td valign="top" class="value"><p class="text-danger">Not completed</p></td>
            </g:if>
            <g:else >
                <td valign="top" class="value"><g:formatBoolean boolean="${gelSuitabilityReportInstance?.handE_pathreview}" false="No" true="Yes"/></td>
            </g:else>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.frozenSectionCut.label" default="Frozen Section Cut" /></td>

            <td valign="top" class="value">${fieldValue(bean: gelSuitabilityReportInstance, field: "frozenSectionCut")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.slideMarkedBy.label" default="Slide Marked By" /></td>

            <g:if test="${gelSuitabilityReportInstance?.slideMarkedBy?.toString()?.isNumber()}">
                <td valign="top" class="value">${geldb.StaffMember.get(gelSuitabilityReportInstance?.slideMarkedBy)}</td>
            </g:if>
            <g:else >
                <td valign="top" class="value">${fieldValue(bean: gelSuitabilityReportInstance, field: "slideMarkedBy")}</td>
            </g:else>
        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.sideMarkedDate.label" default="Slide Marked Date" /></td>

            <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${gelSuitabilityReportInstance?.sideMarkedDate}" /></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.percentageTumourContent.label" default="Percentage Tumour Content" /></td>

            <td valign="top" class="value">${fieldValue(bean: gelSuitabilityReportInstance, field: "percentageTumourContent")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.tumourContentVerifiedBy.label" default="Tumour Content Verified By" /></td>

            <td valign="top" class="value">${gelSuitabilityReportInstance?.tumourContentVerifiedBy?.encodeAsHTML()}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.tumourContentVerificationOther.label" default="Tumour Content Verification Other" /></td>

            <td valign="top" class="value">${fieldValue(bean: gelSuitabilityReportInstance, field: "tumourContentVerificationOther")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.microdissection.label" default="Macrodissection" /></td>

            <g:if test="${gelSuitabilityReportInstance.microdissection == null}">
                <td valign="top" class="value"><p class="text-danger">Not completed</p></td>
            </g:if>
            <g:else >
                <td valign="top" class="value"><g:formatBoolean boolean="${gelSuitabilityReportInstance?.microdissection}" false="No" true="Yes"/></td>
            </g:else>
        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.microdissectionDetails.label" default="Macrodissection Details" /></td>

            <td valign="top" class="value">${fieldValue(bean: gelSuitabilityReportInstance, field: "microdissectionDetails")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.cellularity.label" default="Cellularity" /></td>

            <td valign="top" class="value">${gelSuitabilityReportInstance?.cellularity?.encodeAsHTML()}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.percentageNecrosis.label" default="Percentage Necrosis" /></td>

            <td valign="top" class="value">${fieldValue(bean: gelSuitabilityReportInstance, field: "percentageNecrosis")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.dysplasticNonInvasiveElements.label" default="Dysplastic Non Invasive Elements" /></td>

            <g:if test="${gelSuitabilityReportInstance.dysplasticNonInvasiveElements == null}">
                <td valign="top" class="value"><p class="text-danger">Not completed</p></td>
            </g:if>
            <g:else >
                <td valign="top" class="value"><g:formatBoolean boolean="${gelSuitabilityReportInstance?.dysplasticNonInvasiveElements}" false="No" true="Yes"/></td>
            </g:else>
        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.dysplasticNonInvasiveNotes.label" default="Dysplastic Non Invasive Notes" /></td>

            <td valign="top" class="value">${fieldValue(bean: gelSuitabilityReportInstance, field: "dysplasticNonInvasiveNotes")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.pathologistComments.label" default="Pathologist Comments" /></td>

            <td valign="top" class="value">${fieldValue(bean: gelSuitabilityReportInstance, field: "pathologistComments")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.suitableForGel.label" default="Suitable For Gel" /></td>

            <g:if test="${gelSuitabilityReportInstance.suitableForGel == null}">
                <td valign="top" class="value"><p class="text-danger">Not completed</p></td>
            </g:if>
            <g:else >
                <td valign="top" class="value"><g:formatBoolean boolean="${gelSuitabilityReportInstance?.suitableForGel}" false="No" true="Yes"/></td>
            </g:else>
        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.failureReason.label" default="Failure Reason" /></td>

            <td valign="top" class="value">${fieldValue(bean: gelSuitabilityReportInstance, field: "failureReason")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.slideScannedOn.label" default="Slide Scanned On" /></td>

            <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${gelSuitabilityReportInstance?.slideScannedOn}" /></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.slideScannedBy.label" default="Slide Scanned By" /></td>

            <td valign="top" class="value">${fieldValue(bean: gelSuitabilityReportInstance, field: "slideScannedBy")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.handEcarriedOutOn.label" default="H and E Carried out On" /></td>

            <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${gelSuitabilityReportInstance?.handEcarriedOutOn}" /></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.handEcarriedOutBy.label" default="H and E Carried out By" /></td>

            <td valign="top" class="value">${fieldValue(bean: gelSuitabilityReportInstance, field: "handEcarriedOutBy")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="gelSuitabilityReport.pathologyImages.label" default="Pathology Images" /></td>

            <td valign="top" style="text-align: left;" class="value">
                <ul>
                    <g:each in="${gelSuitabilityReportInstance.pathologyImages}" var="p">
                        <li><g:link controller="pathologyImage" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                    </g:each>
                </ul>
            </td>

        </tr>

        </tbody>
    </table>
</section>

<hr/>

<p class="text-primary">Available Action</p>

<a class='btn btn-primary btn-xs' <g:link controller="pathologyImage" action="create" params="['gelSuitabilityReport.id': gelSuitabilityReportInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'pathologyImage.label', default: 'Pathology Image')])}</g:link>

<hr/>

</body>

</html>
