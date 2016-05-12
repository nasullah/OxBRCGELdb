
<%@ page import="geldb.FFPE_Tissue_Report" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'FFPE_Tissue_Report.label', default: 'Main Specimen Report')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-FFPE_Tissue_Report" class="first">

    <table class="table">
        <tbody>


        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.solidSpecimen.label" default="Main Specimen" /></td>

            <td valign="top" class="value"><g:link controller="solidSpecimen" action="show" id="${FFPE_Tissue_ReportInstance?.solidSpecimen?.id}">${FFPE_Tissue_ReportInstance?.solidSpecimen?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.reportDate.label" default="Report Date" /></td>

            <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${FFPE_Tissue_ReportInstance?.reportDate}" /></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.reportStaff.label" default="Reporting Pathologist" /></td>

            <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "reportStaff")}</td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.comments.label" default="Comments" /></td>

            <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "comments")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.sampleType.label" default="Sample Type" /></td>

            <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "sampleType")}</td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.stage.label" default="Stage" /></td>

            <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "stage")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.stagingSystem.label" default="Staging System" /></td>

            <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "stagingSystem")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.tumourStatus.label" default="Tumour Status" /></td>

            <td valign="top" class="value">${FFPE_Tissue_ReportInstance?.tumourStatus?.encodeAsHTML()}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.tumourType.label" default="Tumour Type" /></td>

            <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "tumourType")}</td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.tissueWorksheet.label" default="Tissue Worksheet" /></td>

            <g:if test="${FFPE_Tissue_ReportInstance?.tissueWorksheet != null}">
                <td valign="top" class="value"><g:link action="download" id="${FFPE_Tissue_ReportInstance.id}">${FFPE_Tissue_ReportInstance.tissueWorksheet} <a class="btn btn-danger btn-xs" href="#" onclick="showDeleteModal()"><i class="glyphicon glyphicon-trash"></i> Delete Tissue Worksheet</a></g:link></td>
            </g:if>
            <g:else>
                <td valign="top" class="value">
                    <g:uploadForm class="form-inline" action="upLoadTissueWorkSheet" params="[id:FFPE_Tissue_ReportInstance.id]" role="form">
                        <div class="form-group">
                            <input type="file" id="tissueWorksheetFile" name="tissueWorksheetFile" />
                        </div>
                        <div class="form-group">
                            <button type="submit" name="upload" class="btn btn-success btn-xs"><i class="glyphicon glyphicon-upload"></i> Upload Tissue Worksheet</button>
                        </div>
                    </g:uploadForm>
                </td>
            </g:else>
        </tr>

        <g:if test="${FFPE_Tissue_ReportInstance?.cellPathReport}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.cellPathReport.label" default="Cell Path Report" /></td>

                <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "cellPathReport")}</td>

            </tr>
        </g:if>

        <g:if test="${!FFPE_Tissue_ReportInstance?.cellPathReport}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.cellPathMacroscopicReport.label" default="Cell Path Macroscopic Report" /></td>

                <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "cellPathMacroscopicReport")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.cellPathMicroscopicReport.label" default="Cell Path Microscopic Report" /></td>

                <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "cellPathMicroscopicReport")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.cellPathSummaryReport.label" default="Cell Path Summary Report" /></td>

                <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "cellPathSummaryReport")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.cellPathSupplementaryReport.label" default="Cell Path Supplementary Report" /></td>

                <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "cellPathSupplementaryReport")}</td>

            </tr>
        </g:if>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.snomed.label" default="Snomed Code" /></td>

            <td valign="top" style="text-align: left;" class="value">
                <ul>
                    <g:each in="${FFPE_Tissue_ReportInstance.snomed}" var="f">
                        <li><g:link controller="snomed" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                    </g:each>
                </ul>
            </td>

        </tr>

        %{--<tr class="prop">--}%
            %{--<td valign="top" class="name"><g:message code="FFPE_Tissue_Report.topographySnomed.label" default="Topography Snomed" /></td>--}%

            %{--<td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "topographySnomed")}</td>--}%

        %{--</tr>--}%

        %{--<tr class="prop">--}%
            %{--<td valign="top" class="name"><g:message code="FFPE_Tissue_Report.morphologySnomed.label" default="Morphology Snomed" /></td>--}%

            %{--<td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "morphologySnomed")}</td>--}%

        %{--</tr>--}%

        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.cold_ischaemia.label" default="Cold Ischaemia" /></td>

            <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "cold_ischaemia")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.warm_ischaemia.label" default="Warm Ischaemia" /></td>

            <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "warm_ischaemia")}</td>

        </tr>

        <g:if test="${FFPE_Tissue_ReportInstance?.fixationType}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.fixationType.label" default="Fixation Type" /></td>

                <td valign="top" class="value">${FFPE_Tissue_ReportInstance?.fixationType?.encodeAsHTML()}</td>

            </tr>
        </g:if>

        %{--<g:if test="${FFPE_Tissue_ReportInstance?.processingSchedule}">--}%
            %{--<tr class="prop">--}%
                %{--<td valign="top" class="name"><g:message code="FFPE_Tissue_Report.processingSchedule.label" default="Processing Schedule" /></td>--}%

                %{--<td valign="top" class="value">${FFPE_Tissue_ReportInstance?.processingSchedule?.encodeAsHTML()}</td>--}%

            %{--</tr>--}%
        %{--</g:if>--}%

        <g:if test="${FFPE_Tissue_ReportInstance?.fixationStartDate}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.fixationStartDate.label" default="Fixation Start Date" /></td>

                <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${FFPE_Tissue_ReportInstance?.fixationStartDate}" /></td>

            </tr>
        </g:if>

        <g:if test="${FFPE_Tissue_ReportInstance?.fixationStartTime}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.fixationStartTime.label" default="Fixation Start Time" /></td>

                <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "fixationStartTime")}</td>

            </tr>
        </g:if>

        <g:if test="${FFPE_Tissue_ReportInstance?.fixationEndDate}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.fixationEndDate.label" default="Fixation End Date" /></td>

                <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${FFPE_Tissue_ReportInstance?.fixationEndDate}" /></td>

            </tr>
        </g:if>

        <g:if test="${FFPE_Tissue_ReportInstance?.fixationEndTime}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.fixationEndTime.label" default="Fixation End Time" /></td>

                <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "fixationEndTime")}</td>

            </tr>
        </g:if>

        <g:if test="${FFPE_Tissue_ReportInstance?.fixationPeriod}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.fixationPeriod.label" default="Fixation Period" /></td>

                <td valign="top" class="value">${FFPE_Tissue_ReportInstance?.fixationPeriod?.encodeAsHTML()}</td>

            </tr>
        </g:if>

        <g:if test="${FFPE_Tissue_ReportInstance?.fixationTimeUnknown}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.fixationTimeUnknown.label" default="Fixation Time Unknown" /></td>

                <g:if test="${FFPE_Tissue_ReportInstance?.fixationTimeUnknown == null}">
                    <td valign="top" class="value"></td>
                </g:if>
                <g:else >
                    <td valign="top" class="value"><g:formatBoolean boolean="${FFPE_Tissue_ReportInstance?.fixationTimeUnknown}" true="Yes" false="No"/></td>
                </g:else>
            </tr>
        </g:if>

        <g:if test="${FFPE_Tissue_ReportInstance?.fixationComments}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.fixationComments.label" default="Fixation Comments" /></td>

                <td valign="top" class="value">${fieldValue(bean: FFPE_Tissue_ReportInstance, field: "fixationComments")}</td>

            </tr>
        </g:if>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="FFPE_Tissue_Report.pathologyImages.label" default="Pathology Images" /></td>

            <td valign="top" style="text-align: left;" class="value">
                <ul>
                    <g:each in="${FFPE_Tissue_ReportInstance.pathologyImages}" var="p">
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

<a class='btn btn-primary btn-xs' <g:link controller="pathologyImage" action="create" params="['solidSpecimenReport.id': FFPE_Tissue_ReportInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'pathologyImage.label', default: 'Pathology Image')])}</g:link>

<hr/>

<div class="modal fade" id="deleteFile">
    <div class="modal-dialog" style="position: absolute; left: 0%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">Delete Worksheet File?</h4>
            </div>
            <div class="modal-body">
                <p>Clicking the delete button will permanently delete the file.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn" data-dismiss="modal">Cancel</button>
                <a class="btn btn-danger" <g:link controller="FFPE_Tissue_Report" action="deleteTissueWorksheet" params="['id': FFPE_Tissue_ReportInstance?.id]">${message(code: 'Delete', args: [message(code: 'delete', default: 'Delete')])}</g:link>
            </div>
        </div>
    </div>
</div>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function showDeleteModal(){
        $('#deleteFile').modal()
    }
</script>

</body>

</html>
