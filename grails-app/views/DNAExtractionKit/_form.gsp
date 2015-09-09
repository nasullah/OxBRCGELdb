<%@ page import="geldb.DNAExtractionKit" %>



			<div class="row">
				<div class="col-lg-6">
					<div class="${hasErrors(bean: DNAExtractionKitInstance, field: 'extractionKitName', 'error')} ">
						<label for="extractionKitName" class="control-label"><g:message code="DNAExtractionKit.extractionKitName.label" default="Extraction Kit Name" /></label>
						<div>
							<g:textField class="form-control" name="extractionKitName" value="${DNAExtractionKitInstance?.extractionKitName}"/>
							<span class="help-inline">${hasErrors(bean: DNAExtractionKitInstance, field: 'extractionKitName', 'error')}</span>
						</div>
					</div>
				</div>
			</div>

