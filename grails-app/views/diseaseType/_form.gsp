<%@ page import="geldb.DiseaseType" %>



			%{--<div class="${hasErrors(bean: diseaseTypeInstance, field: 'participant', 'error')} required">--}%
				%{--<label for="participant" class="control-label"><g:message code="diseaseType.participant.label" default="Participant" /><span class="required-indicator">*</span></label>--}%
				%{--<div>--}%
					%{--<g:select class="form-control" id="participant" name="participant.id" from="${geldb.Participant.list()}" optionKey="id" required="" value="${diseaseTypeInstance?.participant?.id}" class="many-to-one"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: diseaseTypeInstance, field: 'participant', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			<br/>
			<p><b>Participant- ${diseaseTypeInstance?.participant}</b></p>
			<g:hiddenField name="participant.id" id="participant" value="${diseaseTypeInstance?.participant?.id}"  />

			<div class="row">
				<div class="col-lg-6">
					<div class="${hasErrors(bean: diseaseTypeInstance, field: 'expectedDiseaseType', 'error')} required">
						<label for="expectedDiseaseType" class="control-label"><g:message code="diseaseType.expectedDiseaseType.label" default="Expected Disease Type" /><span class="required-indicator">*</span></label>
						<div>
							<g:select class="form-control" id="expectedDiseaseType" name="expectedDiseaseType.id" from="${geldb.AnatomicalSite.list()}" optionKey="id" required="" value="${diseaseTypeInstance?.expectedDiseaseType?.id}" noSelection="['':'- Choose -']" />
							<span class="help-inline">${hasErrors(bean: diseaseTypeInstance, field: 'expectedDiseaseType', 'error')}</span>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="${hasErrors(bean: diseaseTypeInstance, field: 'recordedDate', 'error')} required">
						<label for="recordedDate" class="control-label"><g:message code="diseaseType.recordedDate.label" default="Recorded Date" /><span class="required-indicator">*</span></label>
						<div>
							<bs:datePicker name="recordedDate" precision="day"  value="${diseaseTypeInstance?.recordedDate}"  />
							<span class="help-inline">${hasErrors(bean: diseaseTypeInstance, field: 'recordedDate', 'error')}</span>
						</div>
					</div>
				</div>
			</div>

