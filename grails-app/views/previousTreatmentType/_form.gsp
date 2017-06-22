<%@ page import="geldb.PreviousTreatmentType" %>



			<div class="row">
				<div class="col-lg-6">
					<div class="${hasErrors(bean: previousTreatmentTypeInstance, field: 'previousTreatmentTypeName', 'error')} ">
						<label for="previousTreatmentTypeName" class="control-label"><g:message code="previousTreatmentType.previousTreatmentTypeName.label" default="Previous Treatment Type Name" /></label>
						<div>
							<g:textField class="form-control" name="previousTreatmentTypeName" value="${previousTreatmentTypeInstance?.previousTreatmentTypeName}"/>
							<span class="help-inline">${hasErrors(bean: previousTreatmentTypeInstance, field: 'previousTreatmentTypeName', 'error')}</span>
						</div>
					</div>
				</div>
			</div>

