<%@ page import="geldb.PreviousTreatment" %>



			<p><b>Participant- ${previousTreatmentInstance?.participant}</b></p>
			<g:hiddenField name="participant.id" id="participant" value="${previousTreatmentInstance?.participant?.id}"/>

			<div class="row">
				<div class="col-lg-6">
					<div class="${hasErrors(bean: previousTreatmentInstance, field: 'previousTreatmentName', 'error')} ">
						<label for="previousTreatmentName" class="control-label"><g:message code="previousTreatment.previousTreatmentName.label" default="Previous Treatment Name" /></label>
						<div>
							<g:textField class="form-control" name="previousTreatmentName" value="${previousTreatmentInstance?.previousTreatmentName}"/>
							<span class="help-inline">${hasErrors(bean: previousTreatmentInstance, field: 'previousTreatmentName', 'error')}</span>
						</div>
					</div>
				</div>
			</div>


