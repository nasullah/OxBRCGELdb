<%@ page import="geldb.InstrumentsUsedByPathologist" %>



			<div class="${hasErrors(bean: instrumentsUsedByPathologistInstance, field: 'solidSpecimenReport', 'error')} required">
				<label for="solidSpecimenReport" class="control-label"><g:message code="instrumentsUsedByPathologist.solidSpecimenReport.label" default="Solid Specimen Report" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="solidSpecimenReport" name="solidSpecimenReport.id" from="${geldb.SolidSpecimenReport.list()}" optionKey="id" required="" value="${instrumentsUsedByPathologistInstance?.solidSpecimenReport?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: instrumentsUsedByPathologistInstance, field: 'solidSpecimenReport', 'error')}</span>
				</div>
			</div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: instrumentsUsedByPathologistInstance, field: 'instruments', 'error')} required">
				<label for="instruments" class="control-label"><g:message code="instrumentsUsedByPathologist.instruments.label" default="Instruments" /><span class="required-indicator">*</span></label>
				<div>
					<g:textField class="form-control" name="instruments" required="" value="${instrumentsUsedByPathologistInstance?.instruments}"/>
					<span class="help-inline">${hasErrors(bean: instrumentsUsedByPathologistInstance, field: 'instruments', 'error')}</span>
				</div>
			</div>
        </div>
</div>

