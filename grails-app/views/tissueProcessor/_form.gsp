<%@ page import="geldb.TissueProcessor" %>



			<div class="row">
				<div class="col-lg-6">
					<div class="${hasErrors(bean: tissueProcessorInstance, field: 'tissueProcessorName', 'error')} ">
						<label for="tissueProcessorName" class="control-label"><g:message code="tissueProcessor.tissueProcessorName.label" default="Tissue Processor Name" /><span class="required-indicator">*</span></label>
						<div>
							<g:textField class="form-control" name="tissueProcessorName" value="${tissueProcessorInstance?.tissueProcessorName}" required=""/>
							<span class="help-inline">${hasErrors(bean: tissueProcessorInstance, field: 'tissueProcessorName', 'error')}</span>
						</div>
					</div>
				</div>
			</div>

