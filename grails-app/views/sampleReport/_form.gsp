<%@ page import="geldb.SampleReport" %>



			<div class="${hasErrors(bean: sampleReportInstance, field: 'reportDate', 'error')} required">
				<label for="reportDate" class="control-label"><g:message code="sampleReport.reportDate.label" default="Report Date" /><span class="required-indicator">*</span></label>
				<div>
					<bs:datePicker name="reportDate" precision="day"  value="${sampleReportInstance?.reportDate}"  />
					<span class="help-inline">${hasErrors(bean: sampleReportInstance, field: 'reportDate', 'error')}</span>
				</div>
			</div>
    <div class="row">
        <div class="col-lg-6">
			<div class="${hasErrors(bean: sampleReportInstance, field: 'reportStaff', 'error')} required">
				<label for="reportStaff" class="control-label"><g:message code="sampleReport.reportStaff.label" default="Report Staff" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" name="reportStaff" from="${geldb.StaffMember?.values()}" keys="${geldb.StaffMember.values()*.name()}" required="" value="${sampleReportInstance?.reportStaff?.name()}"/>
					<span class="help-inline">${hasErrors(bean: sampleReportInstance, field: 'reportStaff', 'error')}</span>
				</div>
            </div>
        </div>
        <div class="col-lg-6">
			<div class="${hasErrors(bean: sampleReportInstance, field: 'comments', 'error')} ">
				<label for="comments" class="control-label"><g:message code="sampleReport.comments.label" default="Comments" /></label>
				<div>
					<g:textArea class="form-control" name="comments" cols="40" rows="5" maxlength="100" value="${sampleReportInstance?.comments}"/>
					<span class="help-inline">${hasErrors(bean: sampleReportInstance, field: 'comments', 'error')}</span>
				</div>
			</div>
        </div>
    </div>

			<div class="${hasErrors(bean: sampleReportInstance, field: 'aliquot', 'error')} required">
				<label for="aliquot" class="control-label"><g:message code="sampleReport.aliquot.label" default="Aliquot" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="aliquot" name="aliquot.id" from="${geldb.Aliquot.list()}" optionKey="id" required="" value="${sampleReportInstance?.aliquot?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: sampleReportInstance, field: 'aliquot', 'error')}</span>
				</div>
			</div>

