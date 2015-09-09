<%@ page import="geldb.ExtractionType" %>



			<div class="row">
				<div class="col-lg-6">
					<div class="${hasErrors(bean: extractionTypeInstance, field: 'extractionTypeName', 'error')} ">
						<label for="extractionTypeName" class="control-label"><g:message code="extractionType.extractionTypeName.label" default="Extraction Type Name" /></label>
						<div>
							<g:textField class="form-control" name="extractionTypeName" value="${extractionTypeInstance?.extractionTypeName}"/>
							<span class="help-inline">${hasErrors(bean: extractionTypeInstance, field: 'extractionTypeName', 'error')}</span>
						</div>
					</div>
				</div>
			</div>

