<%@ page import="geldb.SamplePhoto" %>


            <div class="${hasErrors(bean: samplePhotoInstance, field: 'solidSpecimenReport', 'error')} required">
                <label for="solidSpecimenReport" class="control-label"><g:message code="samplePhoto.solidSpecimenReport.label" default="Solid Specimen Report" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="solidSpecimenReport" name="solidSpecimenReport.id" from="${geldb.SolidSpecimenReport.list()}" optionKey="id" required="" value="${samplePhotoInstance?.solidSpecimenReport?.id}" class="many-to-one"/>
                    <span class="help-inline">${hasErrors(bean: samplePhotoInstance, field: 'solidSpecimenReport', 'error')}</span>
                </div>
            </div>

			<div class="${hasErrors(bean: samplePhotoInstance, field: 'samplePhoto', 'error')} required">
				<label for="samplePhoto" class="control-label"><g:message code="samplePhoto.samplePhoto.label" default="Sample Photo" /><span class="required-indicator">*</span></label>
				<div>
					<input type="file" id="samplePhoto" name="samplePhoto" />
					<span class="help-inline">${hasErrors(bean: samplePhotoInstance, field: 'samplePhoto', 'error')}</span>
				</div>
			</div>


