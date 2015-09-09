


            <div class="${hasErrors(bean: dispatchItemInstance, field: 'identifiedSample', 'error')} required">
                <label for="identifiedSample" class="control-label"><g:message code="dispatchItem.identifiedSample.label" default="Sample" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="identifiedSample" name="identifiedSample.id" from="${listSampleByGeLId}" optionKey="id" size="5"  required="" value="${dispatchItemInstance?.identifiedSample?.id}" class="many-to-many"/>
                    <span class="help-inline">${hasErrors(bean: dispatchItemInstance, field: 'identifiedSample', 'error')}</span>
                </div>
            </div>


