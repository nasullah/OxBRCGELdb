<%@ page import="geldb.Snomed" %>




            %{--<div class="${hasErrors(bean: snomedInstance, field: 'fFPE_Tissue_Report', 'error')} required">--}%
                %{--<label for="fFPE_Tissue_Report" class="control-label"><g:message code="snomed.fFPE_Tissue_Report.label" default="Main Specimen Report" /><span class="required-indicator">*</span></label>--}%
                %{--<div>--}%
                    %{--<g:select class="form-control" id="fFPE_Tissue_Report" name="fFPE_Tissue_Report.id" from="${geldb.FFPE_Tissue_Report.list()}" optionKey="id" required="" value="${snomedInstance?.fFPE_Tissue_Report?.id}" class="many-to-one"/>--}%
                    %{--<span class="help-inline">${hasErrors(bean: snomedInstance, field: 'fFPE_Tissue_Report', 'error')}</span>--}%
                %{--</div>--}%
            %{--</div>--}%

            <p><b>${snomedInstance?.fFPE_Tissue_Report}</b></p>
            <g:hiddenField name="fFPE_Tissue_Report.id" id="fFPE_Tissue_Report" value="${snomedInstance?.fFPE_Tissue_Report?.id}"/>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: snomedInstance, field: 'snomedCode', 'error')} ">
                        <label for="snomedCode" class="control-label"><g:message code="snomed.snomedCode.label" default="Snomed Code" /></label>
                        <div>
                            <g:textField class="form-control" name="snomedCode" value="${snomedInstance?.snomedCode}"/>
                            <span class="help-inline">${hasErrors(bean: snomedInstance, field: 'snomedCode', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>
