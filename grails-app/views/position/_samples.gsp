
            <div>
                <g:select class="form-control" id="identifiedSample" name="identifiedSample.id" from="${listSampleByGeLId}" optionKey="id" required="" value="${dispatchItemInstance?.identifiedSample?.id}"/>
                <span class="help-inline">${hasErrors(bean: dispatchItemInstance, field: 'identifiedSample', 'error')}</span>
            </div>