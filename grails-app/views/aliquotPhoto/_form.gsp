<%@ page import="geldb.AliquotPhoto" %>



			<div class="${hasErrors(bean: aliquotPhotoInstance, field: 'aliquotReport', 'error')} required">
				<label for="aliquotReport" class="control-label"><g:message code="aliquotPhoto.aliquotReport.label" default="Aliquot Report" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="aliquotReport" name="aliquotReport.id" from="${geldb.AliquotReport.list()}" optionKey="id" required="" value="${aliquotPhotoInstance?.aliquotReport?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: aliquotPhotoInstance, field: 'aliquotReport', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: aliquotPhotoInstance, field: 'aliquotPhoto', 'error')} required">
				<label for="aliquotPhoto" class="control-label"><g:message code="aliquotPhoto.aliquotPhoto.label" default="Aliquot Photo" /><span class="required-indicator">*</span></label>
				<div>
					<input type="file" id="aliquotPhoto" name="aliquotPhoto" />
					<span class="help-inline">${hasErrors(bean: aliquotPhotoInstance, field: 'aliquotPhoto', 'error')}</span>
				</div>
			</div>

