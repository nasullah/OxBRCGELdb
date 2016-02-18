<%@ page import="geldb.StaffMember; geldb.GelSuitabilityReport" %>



%{--<div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'aliquot', 'error')} required">--}%
    %{--<label for="aliquot" class="control-label"><g:message code="gelSuitabilityReport.aliquot.label" default="Aliquot" /><span class="required-indicator">*</span></label>--}%
    %{--<div>--}%
        %{--<g:select class="form-control" id="aliquot" name="aliquot.id" from="${geldb.Aliquot.list()}" optionKey="id" required="" value="${gelSuitabilityReportInstance?.aliquot?.id}" class="many-to-one"/>--}%
        %{--<span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'aliquot', 'error')}</span>--}%
    %{--</div>--}%
%{--</div>--}%

<p><b>${gelSuitabilityReportInstance?.aliquot}</b></p>
<g:hiddenField name="aliquot.id" id="aliquot" value="${gelSuitabilityReportInstance?.aliquot?.id}"/>

<div class="row">
    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'reportDate', 'error')} required">
            <label for="reportDate" class="control-label"><g:message code="gelSuitabilityReport.reportDate.label" default="Report Date" /><span class="required-indicator">*</span></label>
            <div>
                <bs:datePicker id="reportDate" name="reportDate" precision="day"  value="${gelSuitabilityReportInstance?.reportDate}"  />
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'reportDate', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'reportStaff', 'error')} required">
            <label for="reportStaff" class="control-label"><g:message code="gelSuitabilityReport.reportStaff.label" default="Report Staff" /><span class="required-indicator">*</span></label>
            <div>
                <g:select class="form-control" id="reportStaff" name="reportStaff.id" from="${geldb.StaffMember.findAllByStaffRole('Pathologist').sort {it.staffName}}" optionKey="id" required="" value="${gelSuitabilityReportInstance?.reportStaff?.id}" noSelection="['':'- Choose -']" onchange="autoFillSlideMarked()" />
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'reportStaff', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'comments', 'error')} ">
            <label for="comments" class="control-label"><g:message code="gelSuitabilityReport.comments.label" default="Comments" /></label>
            <div>
                <g:textArea class="form-control" name="comments" cols="40" rows="4" value="${gelSuitabilityReportInstance?.comments}"/>
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'comments', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'handE_pathreview', 'error')} ">
            <label for="handE_pathreview" class="control-label"><g:message code="gelSuitabilityReport.handE_pathreview.label" default="H and E pathologist review done?" /></label>
            <div>
                <g:radioGroup name="handE_pathreview"
                              values="[true, false, '']"
                              labels="['Yes', 'No', 'Not completed']"
                              value="${gelSuitabilityReportInstance?.handE_pathreview}">
                    ${it.label}  ${it.radio}
                </g:radioGroup>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'sideMarkedDate', 'error')} ">
            <label for="sideMarkedDate" class="control-label"><g:message code="gelSuitabilityReport.sideMarkedDate.label" default="Slide Marked Date?" /></label>
            <div>
                <bs:datePicker id="sideMarkedDate" name="sideMarkedDate" precision="day"  value="${gelSuitabilityReportInstance?.sideMarkedDate}" default="none" noSelection="['': '']" />
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'sideMarkedDate', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'slideMarkedBy', 'error')} ">
            <label for="slideMarkedBy" class="control-label"><g:message code="gelSuitabilityReport.slideMarkedBy.label" default="Slide Marked By" /></label>
            <div>
                <g:select class="form-control" id="slideMarkedBy" name="slideMarkedBy" from="${geldb.StaffMember.findAllByStaffRole('Pathologist').sort {it.staffName}}" optionKey="id" value="${gelSuitabilityReportInstance?.slideMarkedBy}" noSelection="['':'- Choose -']"/>
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'slideMarkedBy', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'percentageTumourContent', 'error')} ">
            <label for="percentageTumourContent" class="control-label"><g:message code="gelSuitabilityReport.percentageTumourContent.label" default="Percentage Tumour Content" /></label>
            <div>
                <g:field class="form-control" name="percentageTumourContent" type="number" value="${gelSuitabilityReportInstance.percentageTumourContent}"/>
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'percentageTumourContent', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'tumourContentVerifiedBy', 'error')} ">
            <label for="tumourContentVerifiedBy" class="control-label"><g:message code="gelSuitabilityReport.tumourContentVerifiedBy.label" default="Tumour Content Verified By" /></label>
            <div>
                <g:select class="form-control" name="tumourContentVerifiedBy" from="${geldb.TumourContentVerification?.values()}" keys="${geldb.TumourContentVerification.values()*.name()}" value="${gelSuitabilityReportInstance?.tumourContentVerifiedBy?.name()}" />
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'tumourContentVerifiedBy', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'tumourContentVerificationOther', 'error')} ">
            <label for="tumourContentVerificationOther" class="control-label"><g:message code="gelSuitabilityReport.tumourContentVerificationOther.label" default="Tumour Content Verification Other" /></label>
            <div>
                <g:textField class="form-control" name="tumourContentVerificationOther" value="${gelSuitabilityReportInstance?.tumourContentVerificationOther}"/>
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'tumourContentVerificationOther', 'error')}</span>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'microdissection', 'error')} ">
            <label for="microdissection" class="control-label"><g:message code="gelSuitabilityReport.microdissection.label" default="Macrodissection" /></label>
            <div>
                <g:radioGroup name="microdissection"
                              values="[true, false, '']"
                              labels="['Yes', 'No', 'Not completed']"
                              value="${gelSuitabilityReportInstance?.microdissection}">
                    ${it.label}  ${it.radio}
                </g:radioGroup>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'microdissectionDetails', 'error')} ">
            <label for="microdissectionDetails" class="control-label"><g:message code="gelSuitabilityReport.microdissectionDetails.label" default="Macrodissection Details" /></label>
            <div>
                <g:textField class="form-control" name="microdissectionDetails" value="${gelSuitabilityReportInstance?.microdissectionDetails}"/>
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'microdissectionDetails', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'cellularity', 'error')} ">
            <label for="cellularity" class="control-label"><g:message code="gelSuitabilityReport.cellularity.label" default="Cellularity" /></label>
            <div>
                <g:select class="form-control" name="cellularity" from="${geldb.Cellularity?.values()}" keys="${geldb.Cellularity.values()*.name()}" value="${gelSuitabilityReportInstance?.cellularity?.name()}" noSelection="['':'- Choose -']"/>
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'cellularity', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'percentageNecrosis', 'error')} ">
            <label for="percentageNecrosis" class="control-label"><g:message code="gelSuitabilityReport.percentageNecrosis.label" default="Percentage Necrosis (Leave blank if unknown)" /></label>
            <div>
                <g:field class="form-control" name="percentageNecrosis" type="number" value="${gelSuitabilityReportInstance.percentageNecrosis}"/>
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'percentageNecrosis', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'dysplasticNonInvasiveElements', 'error')} ">
            <label for="dysplasticNonInvasiveElements" class="control-label"><g:message code="gelSuitabilityReport.dysplasticNonInvasiveElements.label" default="Dysplastic Non Invasive Elements" /></label>
            <div>
                <g:radioGroup name="dysplasticNonInvasiveElements"
                              values="[true, false, '']"
                              labels="['Yes', 'No', 'Not completed']"
                              value="${gelSuitabilityReportInstance?.dysplasticNonInvasiveElements}">
                    ${it.label}  ${it.radio}
                </g:radioGroup>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'dysplasticNonInvasiveNotes', 'error')} ">
            <label for="dysplasticNonInvasiveNotes" class="control-label"><g:message code="gelSuitabilityReport.dysplasticNonInvasiveNotes.label" default="Dysplastic Non Invasive Notes" /></label>
            <div>
                <g:textField class="form-control" name="dysplasticNonInvasiveNotes" value="${gelSuitabilityReportInstance?.dysplasticNonInvasiveNotes}"/>
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'dysplasticNonInvasiveNotes', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'pathologistComments', 'error')} ">
            <label for="pathologistComments" class="control-label"><g:message code="gelSuitabilityReport.pathologistComments.label" default="Pathologist Comments" /></label>
            <div>
                <g:textArea class="form-control" name="pathologistComments" cols="40" rows="4" value="${gelSuitabilityReportInstance?.pathologistComments}"/>
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'pathologistComments', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'suitableForGel', 'error')} ">
            <label for="suitableForGel" class="control-label"><g:message code="gelSuitabilityReport.suitableForGel.label" default="Suitable For Gel" /></label>
            <div>
                <g:radioGroup name="suitableForGel"
                              values="[true, false, '']"
                              labels="['Yes', 'No', 'Not completed']"
                              value="${gelSuitabilityReportInstance?.suitableForGel}">
                    ${it.label}  ${it.radio}
                </g:radioGroup>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'failureReason', 'error')} ">
            <label for="failureReason" class="control-label"><g:message code="gelSuitabilityReport.failureReason.label" default="Failure Reason" /></label>
            <div>
                <g:textField class="form-control" name="failureReason" value="${gelSuitabilityReportInstance?.failureReason}"/>
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'failureReason', 'error')}</span>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'slideScannedOn', 'error')} ">
            <label for="slideScannedOn" class="control-label"><g:message code="gelSuitabilityReport.slideScannedOn.label" default="Slide Scanned On" /></label>
            <div>
                <bs:datePicker name="slideScannedOn" precision="day"  value="${gelSuitabilityReportInstance?.slideScannedOn}" default="none" noSelection="['': '']" />
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'slideScannedOn', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'slideScannedBy', 'error')} ">
            <label for="slideScannedBy" class="control-label"><g:message code="gelSuitabilityReport.slideScannedBy.label" default="Slide Scanned By" /></label>
            <div>
                <g:select class="form-control" id="slideScannedBy" name="slideScannedBy.id" from="${geldb.StaffMember.findAllByStaffRoleNotEqual('Pathologist').sort {it.staffName}}" optionKey="id" value="${gelSuitabilityReportInstance?.slideScannedBy?.id}" noSelection="['':'- Choose -']"/>
                <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'slideScannedBy', 'error')}</span>
            </div>
        </div>
    </div>

    <g:if test="${gelSuitabilityReportInstance?.aliquot?.aliquotType?.aliquotTypeName == 'Sections'}">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'handEcarriedOutOn', 'error')} ">
                <label for="handEcarriedOutOn" class="control-label"><g:message code="gelSuitabilityReport.handEcarriedOutOn.label" default="H and E Carried out On" /></label>
                <div>
                    <bs:datePicker name="handEcarriedOutOn" precision="day"  value="${gelSuitabilityReportInstance?.handEcarriedOutOn}" default="none" noSelection="['': '']" />
                    <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'handEcarriedOutOn', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: gelSuitabilityReportInstance, field: 'handEcarriedOutBy', 'error')} ">
                <label for="slideScannedBy" class="control-label"><g:message code="gelSuitabilityReport.handEcarriedOutBy.label" default="H and E Carried out By" /></label>
                <div>
                    <g:select class="form-control" id="handEcarriedOutBy" name="handEcarriedOutBy.id" from="${geldb.StaffMember.list().sort {it.staffName}}" optionKey="id" required="" value="${gelSuitabilityReportInstance?.handEcarriedOutBy?.id}" noSelection="['':'- Choose -']"/>
                    <span class="help-inline">${hasErrors(bean: gelSuitabilityReportInstance, field: 'handEcarriedOutBy', 'error')}</span>
                </div>
            </div>
        </div>
    </g:if>
</div>

<g:javascript plugin="jquery" library="jquery" />
<script>

    function autoFillSlideMarked(){
        var reportDate = $("#reportDate").val();
        $("#sideMarkedDate").val(reportDate);
        var reportStaff = $("#reportStaff").val();
        $("#slideMarkedBy").val(reportStaff);
    }

</script>

