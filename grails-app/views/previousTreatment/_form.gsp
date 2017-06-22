<%@ page import="geldb.PreviousTreatment" %>



			<p><b>Participant- ${previousTreatmentInstance?.participant}</b></p>
			<g:hiddenField name="participant.id" id="participant" value="${previousTreatmentInstance?.participant?.id}"/>

			<div class="row">
				<div class="col-lg-6">
					<div class="${hasErrors(bean: previousTreatmentInstance, field: 'previousTreatmentType', 'error')} required">
						<label for="previousTreatmentType" class="control-label"><g:message code="previousTreatment.previousTreatmentType.label" default="Previous Treatment Type" /><span class="required-indicator">*</span></label>
						<div>
							<g:select class="form-control" id="previousTreatmentType" name="previousTreatmentType.id" from="${geldb.PreviousTreatmentType.list().sort{it.previousTreatmentTypeName}}" optionKey="id" required="" value="${previousTreatmentInstance?.previousTreatmentType?.id}" noSelection="['':'- Choose -']"/>
							<span class="help-inline">${hasErrors(bean: previousTreatmentInstance, field: 'previousTreatmentType', 'error')}</span>
						</div>
					</div>
				</div>
			</div>


