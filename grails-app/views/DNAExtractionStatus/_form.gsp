<%@ page import="geldb.DNAExtractionStatus" %>


            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNAExtractionStatusInstance, field: 'status', 'error')} ">
                        <label for="status" class="control-label"><g:message code="DNAExtractionStatus.status.label" default="Status" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="status" required="" value="${DNAExtractionStatusInstance?.status}"/>
                            <span class="help-inline">${hasErrors(bean: DNAExtractionStatusInstance, field: 'status', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

