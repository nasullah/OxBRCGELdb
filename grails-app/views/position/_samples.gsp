

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: dispatchItemInstance, field: 'identifiedSample', 'error')} required">
                        <label for="identifiedSample" class="control-label"><g:message code="dispatchItem.identifiedSample.label" default="Choose a Sample" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="identifiedSample" name="identifiedSample.id" from="${listSampleByGeLId}" optionKey="id" required="" value="${dispatchItemInstance?.identifiedSample?.id}"/>
                            <span class="help-inline">${hasErrors(bean: dispatchItemInstance, field: 'identifiedSample', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>
