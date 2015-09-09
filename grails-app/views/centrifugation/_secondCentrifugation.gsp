


            <fieldset class="embedded"><legend><g:message code="centrifugation.secondCentrifugation.label" default="Second Centrifugation" /></legend>

                <div class="${hasErrors(bean: centrifugationInstance, field: 'secondCentrifugation.centrifugationBrake', 'error')} ">
                    <label for="secondCentrifugation.centrifugationBrake" class="control-label"><g:message code="centrifugation.secondCentrifugation.centrifugationBrake.label" default="Centrifugation Brake" /></label>
                    <div>
                        <bs:checkBox name="secondCentrifugation.centrifugationBrake" value="${centrifugationInstance?.secondCentrifugation?.centrifugationBrake}" />
                        <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'centrifugationBrake', 'error')}</span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="${hasErrors(bean: centrifugationInstance, field: 'secondCentrifugation.centrifugationSpeed', 'error')} required">
                            <label for="secondCentrifugation.centrifugationSpeed" class="control-label"><g:message code="centrifugation.secondCentrifugation.centrifugationSpeed.label" default="Centrifugation Speed" /><span class="required-indicator">*</span></label>
                            <div>
                                <g:field class="form-control" name="secondCentrifugation.centrifugationSpeed" type="number" value="${centrifugationInstance?.secondCentrifugation?.centrifugationSpeed}" required=""/>
                                <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'secondCentrifugation.centrifugationSpeed', 'error')}</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="${hasErrors(bean: centrifugationInstance, field: 'secondCentrifugation.centrifugationTemperature', 'error')} required">
                            <label for="secondCentrifugation.centrifugationTemperature" class="control-label"><g:message code="centrifugation.secondCentrifugation.centrifugationTemperature.label" default="Centrifugation Temperature" /><span class="required-indicator">*</span></label>
                            <div>
                                <g:field class="form-control" name="secondCentrifugation.centrifugationTemperature" value="${fieldValue(bean: centrifugationInstance?.secondCentrifugation, field: 'centrifugationTemperature')}" required=""/>
                                <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'secondCentrifugation.centrifugationTemperature', 'error')}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="${hasErrors(bean: centrifugationInstance, field: 'secondCentrifugation.endTime', 'error')} required">
                    <label for="secondCentrifugation.endTime" class="control-label"><g:message code="centrifugation.secondCentrifugation.endTime.label" default="End Time" /><span class="required-indicator">*</span></label>
                    <div>
                        <bs:datePicker name="secondCentrifugation.endTime" precision="minute"  value="${centrifugationInstance?.secondCentrifugation?.endTime}"  />
                        <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'secondCentrifugation.endTime', 'error')}</span>
                    </div>
                </div>

                <div class="${hasErrors(bean: centrifugationInstance, field: 'secondCentrifugation.startTime', 'error')} required">
                    <label for="secondCentrifugation.startTime" class="control-label"><g:message code="centrifugation.secondCentrifugation.startTime.label" default="Start Time" /><span class="required-indicator">*</span></label>
                    <div>
                        <bs:datePicker name="secondCentrifugation.startTime" precision="minute"  value="${centrifugationInstance?.secondCentrifugation?.startTime}"  />
                        <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'secondCentrifugation.startTime', 'error')}</span>
                    </div>
                </div>
            </fieldset>