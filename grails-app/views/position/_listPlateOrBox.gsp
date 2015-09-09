


            <div class="${hasErrors(bean: positionInstance, field: 'plateOrBox', 'error')} required">
                <label for="plateOrBox" class="control-label"><g:message code="position.plateOrBox.label" default="Choose Plate or Box" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="plateOrBox" name="plateOrBox.id" from="${listPlateOrBox}" optionKey="id" required=""  value="${positionInstance?.plateOrBox?.id}" />
                    <span class="help-inline">${hasErrors(bean: positionInstance, field: 'plateOrBox', 'error')}</span>
                </div>
            </div>
