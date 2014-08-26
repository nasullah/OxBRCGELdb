<%@ page import="geldb.VCFpath" %>




			<div class="${hasErrors(bean: VCFpathInstance, field: 'sequencingReports', 'error')} required">
				<label for="sequencingReports" class="control-label"><g:message code="VCFpath.sequencingReports.label" default="Sequencing Reports" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="sequencingReports" name="sequencingReports.id" from="${geldb.SequencingReports.list()}" optionKey="id" required="" value="${VCFpathInstance?.sequencingReports?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: VCFpathInstance, field: 'sequencingReports', 'error')}</span>
				</div>
			</div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: VCFpathInstance, field: 'vCFPath', 'error')} ">
				<label for="vCFPath" class="control-label"><g:message code="VCFpath.vCFPath.label" default="VCF Path" /></label>
				<div>
					<g:textField class="form-control" name="vCFPath" value="${VCFpathInstance?.vCFPath}"/>
					<span class="help-inline">${hasErrors(bean: VCFpathInstance, field: 'vCFPath', 'error')}</span>
				</div>
			</div>
    </div>
</div>

