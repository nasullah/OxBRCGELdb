<%@ page import="geldb.ICD10" %>


            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: ICD10Instance, field: 'code', 'error')} ">
                        <label for="code" class="control-label"><g:message code="ICD10.code.label" default="Code" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="code" required="" value="${ICD10Instance?.code}"/>
                            <span class="help-inline">${hasErrors(bean: ICD10Instance, field: 'code', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: ICD10Instance, field: 'meaning', 'error')} ">
                        <label for="meaning" class="control-label"><g:message code="ICD10.meaning.label" default="Meaning" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="meaning" required="" value="${ICD10Instance?.meaning}"/>
                            <span class="help-inline">${hasErrors(bean: ICD10Instance, field: 'meaning', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>





