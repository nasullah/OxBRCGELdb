<%@ page import="geldb.FFPE_Tissue_Report" %>



%{--<div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'solidSpecimen', 'error')} required">--}%
    %{--<label for="solidSpecimen" class="control-label"><g:message code="FFPE_Tissue_Report.solidSpecimen.label" default="Main Specimen" /><span class="required-indicator">*</span></label>--}%
    %{--<div>--}%
        %{--<g:select class="form-control" id="solidSpecimen" name="solidSpecimen.id" from="${geldb.SolidSpecimen.list()}" optionKey="id" required="" value="${FFPE_Tissue_ReportInstance?.solidSpecimen?.id}" class="many-to-one"/>--}%
        %{--<span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'solidSpecimen', 'error')}</span>--}%
    %{--</div>--}%
%{--</div>--}%

<p><b>${FFPE_Tissue_ReportInstance?.solidSpecimen}</b></p>
<g:hiddenField name="solidSpecimen.id" id="solidSpecimen" value="${FFPE_Tissue_ReportInstance?.solidSpecimen?.id}"/>

<div class="row">
    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'reportDate', 'error')} required">
            <label for="reportDate" class="control-label"><g:message code="FFPE_Tissue_Report.reportDate.label" default="Report Date" /><span class="required-indicator">*</span></label>
            <div>
                <bs:datePicker name="reportDate" precision="day"  value="${FFPE_Tissue_ReportInstance?.reportDate}"  />
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'reportDate', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'reportStaff', 'error')} required">
            <label for="reportStaff" class="control-label"><g:message code="FFPE_Tissue_Report.reportStaff.label" default="Reporting Pathologist" /><span class="required-indicator">*</span></label>
            <div>
                <g:select class="form-control" id="reportStaff" name="reportStaff.id" from="${geldb.StaffMember.findAllByStaffRole('Pathologist').sort {it.staffName}}"
                          optionKey="id" required="" value="${FFPE_Tissue_ReportInstance?.reportStaff?.id}" noSelection="['':'- Choose -']"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'reportStaff', 'error')}</span>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'comments', 'error')} ">
            <label for="comments" class="control-label"><g:message code="FFPE_Tissue_Report.comments.label" default="Comments" /></label>
            <div>
                <g:textArea class="form-control" name="comments" cols="40" rows="4" value="${FFPE_Tissue_ReportInstance?.comments}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'comments', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'sampleType', 'error')} required">
            <label for="sampleType" class="control-label"><g:message code="FFPE_Tissue_Report.sampleType.label" default="Sample Type" /><span class="required-indicator">*</span></label>
            <div>
                <g:select class="form-control" id="sampleType" name="sampleType.id" from="${geldb.SampleType.list().sort {it.sampleTypeName}}" optionKey="id" required="" value="${FFPE_Tissue_ReportInstance?.sampleType?.id}" noSelection="['':'- Choose -']"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'sampleType', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'stage', 'error')} ">
            <label for="stage" class="control-label"><g:message code="FFPE_Tissue_Report.stage.label" default="Stage" /></label>
            <div>
                <g:textField class="form-control" name="stage" value="${FFPE_Tissue_ReportInstance?.stage}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'stage', 'error')}</span>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'stagingSystem', 'error')} ">
            <label for="stagingSystem" class="control-label"><g:message code="FFPE_Tissue_Report.stagingSystem.label" default="Staging System" /></label>
            <div>
                <g:textField class="form-control" name="stagingSystem" value="${FFPE_Tissue_ReportInstance?.stagingSystem}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'stagingSystem', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'tumourStatus', 'error')} required">
            <label for="tumourStatus" class="control-label"><g:message code="FFPE_Tissue_Report.tumourStatus.label" default="Tumour Status" /><span class="required-indicator">*</span></label>
            <div>
                <g:select class="form-control" name="tumourStatus" from="${geldb.TumourStatus?.values()}" keys="${geldb.TumourStatus.values()*.name()}" required="" value="${FFPE_Tissue_ReportInstance?.tumourStatus?.name()}" noSelection="['':'- Choose -']"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'tumourStatus', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'tumourType', 'error')} required">
            <label for="tumourType" class="control-label"><g:message code="FFPE_Tissue_Report.tumourType.label" default="Tumour Type" /><span class="required-indicator">*</span></label>
            <div>
                <g:select class="form-control" id="tumourType" name="tumourType.id" from="${geldb.TumourType?.list()?.sort {it.tumourLocation}}" optionKey="id" required="" value="${FFPE_Tissue_ReportInstance?.tumourType?.id}" noSelection="['':'- Choose -']"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'tumourType', 'error')}</span>
            </div>
        </div>
    </div>

    <g:if test="${FFPE_Tissue_ReportInstance?.tissueWorksheet == null}">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'tissueWorksheet', 'error')} ">
                <label for="tissueWorksheet" class="control-label"><g:message code="FFPE_Tissue_ReportInstance.tissueWorksheet.label" default="Upload Tissue Worksheet" /></label>
                <div>
                    <input type="file" id="tissueWorksheetFile" name="tissueWorksheetFile" />
                </div>
            </div>
        </div>
    </g:if>
</div>

<div class="row">
    <g:if test="${FFPE_Tissue_ReportInstance?.cellPathReport}">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cellPathReport', 'error')} ">
                <label for="cellPathReport" class="control-label"><g:message code="FFPE_Tissue_Report.cellPathReport.label" default="Cell Path Report" /></label>
                <div>
                    <g:textArea class="form-control" name="cellPathReport" cols="40" rows="4" value="${FFPE_Tissue_ReportInstance?.cellPathReport}"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cellPathReport', 'error')}</span>
                </div>
            </div>
        </div>
    </g:if>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cellPathMacroscopicReport', 'error')} ">
            <label for="cellPathMacroscopicReport" class="control-label"><g:message code="FFPE_Tissue_Report.cellPathMacroscopicReport.label" default="Cell Path Macroscopic Report" /></label>
            <div>
                <g:textArea class="form-control" name="cellPathMacroscopicReport" cols="40" rows="4" value="${FFPE_Tissue_ReportInstance?.cellPathMacroscopicReport}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cellPathMacroscopicReport', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cellPathMicroscopicReport', 'error')} ">
            <label for="cellPathMicroscopicReport" class="control-label"><g:message code="FFPE_Tissue_Report.cellPathMicroscopicReport.label" default="Cell Path Microscopic Report" /></label>
            <div>
                <g:textArea class="form-control" name="cellPathMicroscopicReport" cols="40" rows="4" value="${FFPE_Tissue_ReportInstance?.cellPathMicroscopicReport}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cellPathMicroscopicReport', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cellPathSummaryReport', 'error')} ">
            <label for="cellPathSummaryReport" class="control-label"><g:message code="FFPE_Tissue_Report.cellPathSummaryReport.label" default="Cell Path Summary Report" /></label>
            <div>
                <g:textArea class="form-control" name="cellPathSummaryReport" cols="40" rows="4" value="${FFPE_Tissue_ReportInstance?.cellPathSummaryReport}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cellPathSummaryReport', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cellPathSupplementaryReport', 'error')} ">
            <label for="cellPathSupplementaryReport" class="control-label"><g:message code="FFPE_Tissue_Report.cellPathSupplementaryReport.label" default="Cell Path Supplementary Report"/></label>
            <div>
                <g:textArea class="form-control" name="cellPathSupplementaryReport" cols="40" rows="4" value="${FFPE_Tissue_ReportInstance?.cellPathSupplementaryReport}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cellPathSupplementaryReport', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}" id="snomed0">
            <label for="snomedCode0" class="control-label"><g:message code="snomed.snomedCode.label" default="Snomed Code (use prefix T for Topography and M for Morphology)"/><span class="required-indicator">*</span></label>
            <div>
                <g:textField class="form-control" id="snomedCode0" name="snomedCode0" value="${FFPE_Tissue_ReportInstance?.snomed?.getAt(0)?.snomedCode}" required=""/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}" id="snomed1">
            <label for="snomedCode1" class="control-label"><g:message code="snomed.snomedCode.label" default="Snomed Code (use prefix T for Topography and M for Morphology)" /><span class="required-indicator">*</span></label>
            <div>
                <g:textField class="form-control" id="snomedCode1" name="snomedCode1" value="${FFPE_Tissue_ReportInstance?.snomed?.getAt(1)?.snomedCode}" required=""/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}" id="snomed2">
            <label for="snomedCode2" class="control-label"><g:message code="snomed.snomedCode.label" default="Snomed Code (use prefix T for Topography and M for Morphology)" /><span class="required-indicator">*</span></label>
            <div>
                <g:textField class="form-control" id="snomedCode2" name="snomedCode2" value="${FFPE_Tissue_ReportInstance?.snomed?.getAt(2)?.snomedCode}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}</span>
            </div>
        </div>
    </div>


    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}" id="snomed3">
            <label for="snomedCode3" class="control-label"><g:message code="snomed.snomedCode.label" default="Snomed Code (use prefix T for Topography and M for Morphology)" /><span class="required-indicator">*</span></label>
            <div>
                <g:textField class="form-control" id="snomedCode3" name="snomedCode3" value="${FFPE_Tissue_ReportInstance?.snomed?.getAt(3)?.snomedCode}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}" id="snomed4">
            <label for="snomedCode4" class="control-label"><g:message code="snomed.snomedCode.label" default="Snomed Code (use prefix T for Topography and M for Morphology)" /><span class="required-indicator">*</span></label>
            <div>
                <g:textField class="form-control" id="snomedCode4" name="snomedCode4" value="${FFPE_Tissue_ReportInstance?.snomed?.getAt(4)?.snomedCode}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}" id="snomed5">
            <label for="snomedCode5" class="control-label"><g:message code="snomed.snomedCode.label" default="Snomed Code (use prefix T for Topography and M for Morphology)" /><span class="required-indicator">*</span></label>
            <div>
                <g:textField class="form-control" id="snomedCode5" name="snomedCode5" value="${FFPE_Tissue_ReportInstance?.snomed?.getAt(5)?.snomedCode}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}" id="snomed6">
            <label for="snomedCode6" class="control-label"><g:message code="snomed.snomedCode.label" default="Snomed Code (use prefix T for Topography and M for Morphology)" /><span class="required-indicator">*</span></label>
            <div>
                <g:textField class="form-control" id="snomedCode6" name="snomedCode6" value="${FFPE_Tissue_ReportInstance?.snomed?.getAt(6)?.snomedCode}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}" id="snomed7">
            <label for="snomedCode7" class="control-label"><g:message code="snomed.snomedCode.label" default="Snomed Code (use prefix T for Topography and M for Morphology)" /><span class="required-indicator">*</span></label>
            <div>
                <g:textField class="form-control" id="snomedCode7" name="snomedCode7" value="${FFPE_Tissue_ReportInstance?.snomed?.getAt(7)?.snomedCode}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}" id="snomed8">
            <label for="snomedCode8" class="control-label"><g:message code="snomed.snomedCode.label" default="Snomed Code (use prefix T for Topography and M for Morphology)" /><span class="required-indicator">*</span></label>
            <div>
                <g:textField class="form-control" id="snomedCode8" name="snomedCode8" value="${FFPE_Tissue_ReportInstance?.snomed?.getAt(8)?.snomedCode}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}" id="snomed9">
            <label for="snomedCode9" class="control-label"><g:message code="snomed.snomedCode.label" default="Snomed Code (use prefix T for Topography and M for Morphology)" /><span class="required-indicator">*</span></label>
            <div>
                <g:textField class="form-control" id="snomedCode9" name="snomedCode9" value="${FFPE_Tissue_ReportInstance?.snomed?.getAt(9)?.snomedCode}"/>
                <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance?.snomed, field: 'snomedCode', 'error')}</span>
            </div>
        </div>
    </div>
</div>

%{--<div class="row">--}%
    %{--<div class="col-lg-6">--}%
        %{--<div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'topographySnomed', 'error')} ">--}%
            %{--<label for="topographySnomed" class="control-label"><g:message code="FFPE_Tissue_Report.topographySnomed.label" default="Topography Snomed" /><span class="required-indicator">*</span></label>--}%
            %{--<div>--}%
                %{--<g:textField class="form-control" name="topographySnomed" value="${FFPE_Tissue_ReportInstance?.topographySnomed}" required="" />--}%
                %{--<span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'topographySnomed', 'error')}</span>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%

    %{--<div class="col-lg-6">--}%
        %{--<div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'morphologySnomed', 'error')} ">--}%
            %{--<label for="morphologySnomed" class="control-label"><g:message code="FFPE_Tissue_Report.morphologySnomed.label" default="Morphology Snomed" /><span class="required-indicator">*</span></label>--}%
            %{--<div>--}%
                %{--<g:textField class="form-control" name="morphologySnomed" value="${FFPE_Tissue_ReportInstance?.morphologySnomed}" required="" />--}%
                %{--<span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'morphologySnomed', 'error')}</span>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
%{--</div>--}%

<fieldset class="" id="fixed"><legend><g:message code="FFPE_Tissue_Report.fixed.label" default="Fixed Specimen Only" /></legend>
    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationType', 'error')} required">
                <label for="fixationType" class="control-label"><g:message code="FFPE_Tissue_Report.fixationType.label" default="Fixation Type" /></label>
                <div>
                    <g:select class="form-control" id="fixationType" name="fixationType" from="${geldb.FixationType?.values()}" keys="${geldb.FixationType.values()*.name()}" value="${FFPE_Tissue_ReportInstance?.fixationType?.name()}" noSelection="['':'- Choose -']"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationType', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationPeriod', 'error')} ">
                <label for="fixationPeriod" class="control-label"><g:message code="FFPE_Tissue_Report.fixationPeriod.label" default="Fixation Period" /></label>
                <div>
                    <g:select class="form-control" id="fixationPeriod" name="fixationPeriod" from="${geldb.Time12Hourly?.values()}" keys="${geldb.Time12Hourly.values()*.name()}" value="${FFPE_Tissue_ReportInstance?.fixationPeriod?.name()}" noSelection="['':'- Choose -']"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationPeriod', 'error')}</span>
                </div>
            </div>
        </div>

        %{--<div class="col-lg-6">--}%
            %{--<div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'processingSchedule', 'error')} ">--}%
                %{--<label for="processingSchedule" class="control-label"><g:message code="FFPE_Tissue_Report.processingSchedule.label" default="Processing Schedule" /></label>--}%
                %{--<div>--}%
                    %{--<g:select class="form-control" id ="processingSchedule" name="processingSchedule" from="${geldb.ProcessingSchedule?.values()?.sort()}" keys="${geldb.ProcessingSchedule.values()*.name()}" value="${FFPE_Tissue_ReportInstance?.processingSchedule?.name()}" noSelection="['': '']"/>--}%
                    %{--<span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'processingSchedule', 'error')}</span>--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationStartDate', 'error')} required">
                <label for="fixationStartDate" class="control-label"><g:message code="FFPE_Tissue_Report.fixationStartDate.label" default="Fixation Start Date" /></label>
                <div>
                    <bs:datePicker id="fixationStartDate" name="fixationStartDate" precision="day"  value="${FFPE_Tissue_ReportInstance?.fixationStartDate}" default="none" noSelection="['': '']" />
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationStartDate', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationStartTime', 'error')} ">
                <label for="fixationStartTime" class="control-label"><g:message code="FFPE_Tissue_Report.fixationStartTime.label" default="Fixation Start Time" /></label>
                <div>
                    <g:field type="time" class="form-control" name="fixationStartTime" value="${FFPE_Tissue_ReportInstance?.fixationStartTime}"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationStartTime', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationEndDate', 'error')} ">
                <label for="fixationEndDate" class="control-label"><g:message code="FFPE_Tissue_Report.fixationEndDate.label" default="Fixation End Date" /></label>
                <div>
                    <bs:datePicker name="fixationEndDate" precision="day" id="fixationEndDate" value="${FFPE_Tissue_ReportInstance?.fixationEndDate}" default="none" noSelection="['': '']" />
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationEndDate', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationEndTime', 'error')} ">
                <label for="fixationEndTime" class="control-label"><g:message code="FFPE_Tissue_Report.fixationEndTime.label" default="Fixation End Time" /></label>
                <div>
                    <g:field type="time" class="form-control" name="fixationEndTime" value="${FFPE_Tissue_ReportInstance?.fixationEndTime}"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationEndTime', 'error')}</span>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationTimeUnknown', 'error')} ">
                <label for="fixationTimeUnknown" class="control-label"><g:message code="FFPE_Tissue_Report.fixationTimeUnknown.label" default="Fixation Time Unknown" /></label>
                <div>
                    <g:radioGroup name="fixationTimeUnknown"
                                  values="[true, false]"
                                  labels="['Yes', 'No']"
                                  value="${FFPE_Tissue_ReportInstance?.fixationTimeUnknown}">
                        ${it.label}  ${it.radio} &nbsp; &nbsp;
                    </g:radioGroup>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationComments', 'error')} ">
                <label for="fixationComments" class="control-label"><g:message code="FFPE_Tissue_Report.fixationComments.label" default="Fixation Comments" /></label>
                <div>
                    <g:textField class="form-control" id="fixationComments" name="fixationComments" value="${FFPE_Tissue_ReportInstance?.fixationComments}"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'fixationComments', 'error')}</span>
                </div>
            </div>
        </div>
    </div>
</fieldset>

<fieldset class="embedded" id="warm_ischaemia" ><legend><g:message code="FFPE_Tissue_Report.warm_ischaemia.label" default="Warm Ischaemia" /></legend>
    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'warm_ischaemia.startDate', 'error')} ">
                <label for="warm_ischaemia.startDate" class="control-label"><g:message code="FFPE_Tissue_Report.warm_ischaemia.startDate.label" default="Start Date (Auto filled)" /></label>
                <div>
                    <bs:datePicker name="warm_ischaemia.startDate" id="warm_ischaemia_startDate" precision="day"  value="${FFPE_Tissue_ReportInstance?.warm_ischaemia?.startDate}" default="none" noSelection="['': '']" />
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'warm_ischaemia.startDate', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'warm_ischaemia.startTime', 'error')} ">
                <label for="warm_ischaemia.startTime" class="control-label"><g:message code="FFPE_Tissue_Report.warm_ischaemia.startTime.label" default="Start Time" /></label>
                <div>
                    <g:field type="time" class="form-control" name="warm_ischaemia.startTime" value="${FFPE_Tissue_ReportInstance?.warm_ischaemia?.startTime}"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'warm_ischaemia.startTime', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'warm_ischaemia.endDate', 'error')} ">
                <label for="warm_ischaemia.endDate" class="control-label"><g:message code="FFPE_Tissue_Report.warm_ischaemia.endDate.label" default="End Date (Auto filled)" /></label>
                <div>
                    <bs:datePicker name="warm_ischaemia.endDate" id="warm_ischaemia_endDate" precision="day"  value="${FFPE_Tissue_ReportInstance?.warm_ischaemia?.endDate}" default="none" noSelection="['': '']" />
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'endDate', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'warm_ischaemia.endTime', 'error')} ">
                <label for="warm_ischaemia.endTime" class="control-label"><g:message code="FFPE_Tissue_Report.warm_ischaemia.endTime.label" default="End Time" /></label>
                <div>
                    <g:field type="time" class="form-control" name="warm_ischaemia.endTime" value="${FFPE_Tissue_ReportInstance?.warm_ischaemia?.endTime}"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'endTime', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'warm_ischaemia.period', 'error')} ">
                <label for="warm_ischaemia.period" class="control-label"><g:message code="FFPE_Tissue_Report.warm_ischaemia.period.label" default="Period" /></label>
                <div>
                    <g:select class="form-control" id="warm_ischaemia_period" name="warm_ischaemia.period.id" from="${geldb.Period.list().sort {it.period}}" optionKey="id" value="${FFPE_Tissue_ReportInstance?.warm_ischaemia?.period?.id}" noSelection="['':'- Choose -']"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'warm_ischaemia.period', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'warm_ischaemia.reportedBy', 'error')} ">
                <label for="warm_ischaemia.reportedBy" class="control-label"><g:message code="FFPE_Tissue_Report.warm_ischaemia.reportedBy.label" default="Reported By" /></label>
                <div>
                    <g:textField class="form-control" id="warm_ischaemia_reportedBy" name="warm_ischaemia.reportedBy" value="${FFPE_Tissue_ReportInstance?.warm_ischaemia?.reportedBy}"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'warm_ischaemia.reportedBy', 'error')}</span>
                </div>
            </div>
        </div>
    </div>
</fieldset>

<fieldset class="embedded" id="cold_ischaemia"><legend><g:message code="FFPE_Tissue_Report.cold_ischaemia.label" default="Cold Ischaemia" /></legend>
    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cold_ischaemia.startDate', 'error')} ">
                <label for="cold_ischaemia.startDate" class="control-label"><g:message code="FFPE_Tissue_Report.cold_ischaemia.startDate.label" default="Start Date (Auto filled)" /></label>
                <div>
                    <bs:datePicker name="cold_ischaemia.startDate" id="cold_ischaemia_startDate" precision="day"  value="${FFPE_Tissue_ReportInstance?.cold_ischaemia?.startDate}" default="none" noSelection="['': '']" />
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cold_ischaemia.startDate', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cold_ischaemia.startTime', 'error')} ">
                <label for="cold_ischaemia.startTime" class="control-label"><g:message code="FFPE_Tissue_Report.cold_ischaemia.startTime.label" default="Start Time" /></label>
                <div>
                    <g:field type="time" class="form-control" name="cold_ischaemia.startTime" value="${FFPE_Tissue_ReportInstance?.cold_ischaemia?.startTime}"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cold_ischaemia.startTime', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cold_ischaemia.endDate', 'error')} ">
                <label for="cold_ischaemia.endDate" class="control-label"><g:message code="FFPE_Tissue_Report.cold_ischaemia.endDate.label" default="End Date (Auto filled)" /></label>
                <div>
                    <bs:datePicker name="cold_ischaemia.endDate" id="cold_ischaemia_endDate" precision="day"  value="${FFPE_Tissue_ReportInstance?.cold_ischaemia?.endDate}" default="none" noSelection="['': '']" />
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cold_ischaemia.endDate', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cold_ischaemia.endTime', 'error')} ">
                <label for="cold_ischaemia.endTime" class="control-label"><g:message code="FFPE_Tissue_Report.cold_ischaemia.endTime.label" default="End Time" /></label>
                <div>
                    <g:field type="time" class="form-control" name="cold_ischaemia.endTime" value="${FFPE_Tissue_ReportInstance?.cold_ischaemia?.endTime}"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cold_ischaemia.endTime', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cold_ischaemia.period', 'error')} ">
                <label for="cold_ischaemia.period" class="control-label"><g:message code="FFPE_Tissue_Report.cold_ischaemia.period.label" default="Period" /></label>
                <div>
                    <g:select class="form-control" id="cold_ischaemia.period" name="cold_ischaemia.period.id" from="${geldb.Period.list().sort {it.period}}" optionKey="id" value="${FFPE_Tissue_ReportInstance?.cold_ischaemia?.period?.id}" noSelection="['':'- Choose -']"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cold_ischaemia.period', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cold_ischaemia.reportedBy', 'error')} ">
                <label for="cold_ischaemia.reportedBy" class="control-label"><g:message code="FFPE_Tissue_Report.cold_ischaemia.reportedBy.label" default="Reported By" /></label>
                <div>
                    <g:textField class="form-control" name="cold_ischaemia.reportedBy" id="cold_ischaemia_reportedBy" value="${FFPE_Tissue_ReportInstance?.cold_ischaemia?.reportedBy}"/>
                    <span class="help-inline">${hasErrors(bean: FFPE_Tissue_ReportInstance, field: 'cold_ischaemia.reportedBy', 'error')}</span>
                </div>
            </div>
        </div>
    </div>
</fieldset>

<hr/>

<button type="button" id="addcode" class="btn btn-primary btn-xs" value="add" onClick= 'addSnomed()'><span class="glyphicon glyphicon-plus"></span> Add More Snomed Code</button>
<button type="button" id="coldIschaemiaButton" class="btn btn-primary btn-xs" value="showColdIschaemia" onClick= 'showColdIschaemia()'><span class="glyphicon glyphicon-plus"></span> Add Cold Ischaemia</button>
<button type="button"  id="warmIschaemiaButton" class="btn btn-primary btn-xs" value="showWarmIschaemia" onClick= 'showWarmIschaemia()'><span class="glyphicon glyphicon-plus"></span> Add Warm Ischaemia</button>

<g:javascript plugin="jquery" library="jquery" />
<script>

    if ( $("#fixationType").val() != '' || $("#fixationStartDate").val() != '' || $("#fixationEndDate").val() != '' || $("#fixationPeriod").val() != '' ) {
        $("#fixed").show();
    } else{
        $("#fixed").hide();
    }

    if ($("#warm_ischaemia input#warm_ischaemia_reportedBy").val() != '' || $("#warm_ischaemia input#warm_ischaemia_startDate").val() != '' || $("#warm_ischaemia input#warm_ischaemia_endDate").val() != '' ){
        showWarmIschaemia();
    } else {
        $("#warm_ischaemia").hide();
        $("#warmIschaemiaButton").show();
    }

    if ($("#cold_ischaemia input#cold_ischaemia_reportedBy").val() != '' || $("#cold_ischaemia input#cold_ischaemia_startDate").val() != '' || $("#cold_ischaemia input#cold_ischaemia_endDate").val() != '' ){
        showColdIschaemia()
    } else {
        $("#cold_ischaemia").hide();
        $("#coldIschaemiaButton").show();
    }

    function showColdIschaemia(){
        autoFillColdIschaemiaDates();
        $("#cold_ischaemia").show();
        $("#coldIschaemiaButton").hide();
    }

    function showWarmIschaemia(){
        autoFillWarmIschaemiaDates();
        $("#warm_ischaemia").show();
        $("#warmIschaemiaButton").hide();
    }

    function autoFillColdIschaemiaDates(){
        var baseUrl = "${createLink(controller:'FFPE_Tissue_Report', action:'sampleCollectionDate')}";
        var solidSpecimen = $('#solidSpecimen').val();
        var url = baseUrl + "?solidSpecimen="+solidSpecimen;
        $.ajax({
            url:url,
            type: 'POST',
            dataType: 'xml',
            async:true,
            success: function(res) {
                if (res){
                    var collectionDate = $(res).find("timestamp").text();
                    collectionDate = collectionDate.substring(0, 10);
                    $("#cold_ischaemia input#cold_ischaemia_startDate").val(collectionDate);
                    $("#cold_ischaemia input#cold_ischaemia_endDate").val(collectionDate);
                }
            }
        });
    }

    function autoFillWarmIschaemiaDates(){
        var baseUrl = "${createLink(controller:'FFPE_Tissue_Report', action:'sampleCollectionDate')}";
        var solidSpecimen = $('#solidSpecimen').val();
        var url = baseUrl + "?solidSpecimen="+solidSpecimen;
        $.ajax({
            url:url,
            type: 'POST',
            dataType: 'xml',
            async:true,
            success: function(res) {
                if (res){
                    var collectionDate = $(res).find("timestamp").text();
                    collectionDate = collectionDate.substring(0, 10);
                    $("#warm_ischaemia input#warm_ischaemia_startDate").val(collectionDate);
                    $("#warm_ischaemia input#warm_ischaemia_endDate").val(collectionDate);
                }
            }
        });
    }

    hideSnomed();
    var count = 2;

    function hideSnomed(){
//        if ($("#snomedCode0").val() == ""){
//            $("#snomed0").hide();
//        }
//        if ($("#snomedCode1").val() == ""){
//            $("#snomed1").hide();
//        }
        if ($("#snomedCode2").val() == ""){
            $("#snomed2").hide();
        }
        if ($("#snomedCode3").val() == ""){
            $("#snomed3").hide();
        }
        if ($("#snomedCode4").val() == ""){
            $("#snomed4").hide();
        }
        if ($("#snomedCode5").val() == ""){
            $("#snomed5").hide();
        }
        if ($("#snomedCode6").val() == ""){
            $("#snomed6").hide();
        }
        if ($("#snomedCode7").val() == ""){
            $("#snomed7").hide();
        }
        if ($("#snomedCode8").val() == ""){
            $("#snomed8").hide();
        }
        if ($("#snomedCode9").val() == ""){
            $("#snomed9").hide();
        }
    }

    function addSnomed(){
        $("#snomed"+count).show();
        count++;
        if (count >9){
            $("#addcode").hide();
        }
    }

</script>