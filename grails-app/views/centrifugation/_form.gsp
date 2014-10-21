<%@ page import="geldb.Centrifugation" %>



            <g:if test="${centrifugationInstance?.derivation?.id !=null}">
                <div class="${hasErrors(bean: centrifugationInstance, field: 'derivation', 'error')} ">
                    <label for="derivation" class="control-label"><g:message code="centrifugation.derivation.label" default="Derivation" /></label>
                    <div>
                        <g:select class="form-control" id="derivation" name="derivation.id" from="${geldb.Derivation.list()}" optionKey="id" value="${centrifugationInstance?.derivation?.id}" class="many-to-one" noSelection="['null': '']"/>
                        <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'derivation', 'error')}</span>
                    </div>
                </div>
            </g:if>
            %{--<g:if test="${centrifugationInstance?.specimen?.id !=null}">--}%
                %{--<div class="${hasErrors(bean: centrifugationInstance, field: 'specimen', 'error')} ">--}%
                    %{--<label for="specimen" class="control-label"><g:message code="centrifugation.specimen.label" default="Specimen" /></label>--}%
                    %{--<div>--}%
                        %{--<g:select class="form-control" id="specimen" name="specimen.id" from="${geldb.Specimen.list()}" optionKey="id" value="${centrifugationInstance?.specimen?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
                        %{--<span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'specimen', 'error')}</span>--}%
                    %{--</div>--}%
                %{--</div>--}%
            %{--</g:if>--}%

			<div class="${hasErrors(bean: centrifugationInstance, field: 'reportDate', 'error')} required">
				<label for="reportDate" class="control-label"><g:message code="centrifugation.reportDate.label" default="Report Date" /><span class="required-indicator">*</span></label>
				<div>
					<bs:datePicker name="reportDate" precision="day"  value="${centrifugationInstance?.reportDate}"  />
					<span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'reportDate', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: centrifugationInstance, field: 'reportStaff', 'error')} required">
				<label for="reportStaff" class="control-label"><g:message code="centrifugation.reportStaff.label" default="Report Staff" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="reportStaff" name="reportStaff.id" from="${geldb.StaffMember.list()}" optionKey="id" required="" value="${centrifugationInstance?.reportStaff?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'reportStaff', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: centrifugationInstance, field: 'comments', 'error')} ">
                        <label for="comments" class="control-label"><g:message code="centrifugation.comments.label" default="Comments" /></label>
                        <div>
                            <g:textArea class="form-control" name="comments" cols="40" rows="5" value="${centrifugationInstance?.comments}"/>
                            <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'comments', 'error')}</span>
                        </div>
                    </div>
                </div>
                    <div class="col-lg-6">
                        <div class="${hasErrors(bean: centrifugationInstance, field: 'timeReceived', 'error')} ">
                            <label for="timeReceived" class="control-label"><g:message code="centrifugation.timeReceived.label" default="Time Received" /></label>
                            <div>
                                <g:textField class="form-control" name="timeReceived" value="${centrifugationInstance?.timeReceived}"/>
                                <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'timeReceived', 'error')}</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="${hasErrors(bean: centrifugationInstance, field: 'priorTemporarySampleTemperature', 'error')} required">
                            <label for="priorTemporarySampleTemperature" class="control-label"><g:message code="centrifugation.priorTemporarySampleTemperature.label" default="Prior Temporary Sample Temperature" /><span class="required-indicator">*</span></label>
                            <div>
                                <g:field class="form-control" name="priorTemporarySampleTemperature" value="${fieldValue(bean: centrifugationInstance, field: 'priorTemporarySampleTemperature')}" required=""/>
                                <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'priorTemporarySampleTemperature', 'error')}</span>
                            </div>
                        </div>
                    </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                        <div class="${hasErrors(bean: centrifugationInstance, field: 'postTemporarySampleTemperature', 'error')} required">
                            <label for="postTemporarySampleTemperature" class="control-label"><g:message code="centrifugation.postTemporarySampleTemperature.label" default="Post Temporary Sample Temperature" /><span class="required-indicator">*</span></label>
                            <div>
                                <g:field class="form-control" name="postTemporarySampleTemperature" value="${fieldValue(bean: centrifugationInstance, field: 'postTemporarySampleTemperature')}" required=""/>
                                <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'postTemporarySampleTemperature', 'error')}</span>
                            </div>
                        </div>
                </div>
                    <div class="col-lg-6">
                        <div class="${hasErrors(bean: centrifugationInstance, field: 'timePutIntoTemporaryStorage', 'error')} ">
                            <label for="timePutIntoTemporaryStorage" class="control-label"><g:message code="centrifugation.timePutIntoTemporaryStorage.label" default="Time Put Into Temporary Storage" /></label>
                            <div>
                                <g:textField class="form-control" name="timePutIntoTemporaryStorage" value="${centrifugationInstance?.timePutIntoTemporaryStorage}"/>
                                <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'timePutIntoTemporaryStorage', 'error')}</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="${hasErrors(bean: centrifugationInstance, field: 'timePutIntoLongStorage', 'error')} ">
                            <label for="timePutIntoLongStorage" class="control-label"><g:message code="centrifugation.timePutIntoLongStorage.label" default="Time Put Into Long Storage" /></label>
                            <div>
                                <g:textField class="form-control" name="timePutIntoLongStorage" value="${centrifugationInstance?.timePutIntoLongStorage}"/>
                                <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'timePutIntoLongStorage', 'error')}</span>
                            </div>
                        </div>
                    </div>
            </div>
            <fieldset class="embedded"><legend><g:message code="centrifugation.firstCentrifugation.label" default="First Centrifugation" /></legend>
                <div class="fieldcontain ${hasErrors(bean: centrifugationInstance, field: 'firstCentrifugation.centrifugationBrake', 'error')} ">
                    <label for="firstCentrifugation.centrifugationBrake" class="control-label"><g:message code="centrifugation.firstCentrifugation.centrifugationBrake.label" default="Centrifugation Brake" /></label>
                    <div>
                        <bs:checkBox name="firstCentrifugation.centrifugationBrake" value="${centrifugationInstance?.firstCentrifugation?.centrifugationBrake}" />
                        <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'firstCentrifugation.centrifugationBrake', 'error')}</span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="fieldcontain${hasErrors(bean: centrifugationInstance, field: 'firstCentrifugation.centrifugationSpeed', 'error')} required">
                            <label for="firstCentrifugation.centrifugationSpeed" class="control-label"><g:message code="centrifugation.firstCentrifugation.centrifugationSpeed.label" default="Centrifugation Speed" /><span class="required-indicator">*</span></label>
                            <div>
                                <g:field class="form-control" name="firstCentrifugation.centrifugationSpeed" type="number" value="${centrifugationInstance?.firstCentrifugation?.centrifugationSpeed}" required=""/>
                                <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'firstCentrifugation.centrifugationSpeed', 'error')}</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="fieldcontain${hasErrors(bean: centrifugationInstance, field: 'firstCentrifugation.centrifugationTemperature', 'error')} required">
                            <label for="firstCentrifugation.centrifugationTemperature" class="control-label"><g:message code="centrifugation.firstCentrifugation.centrifugationTemperature.label" default="Centrifugation Temperature" /><span class="required-indicator">*</span></label>
                            <div>
                                <g:field class="form-control" name="firstCentrifugation.centrifugationTemperature" value="${fieldValue(bean: centrifugationInstance, field: 'firstCentrifugation.centrifugationTemperature')}" required=""/>
                                <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'firstCentrifugation.centrifugationTemperature', 'error')}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="fieldcontain${hasErrors(bean: centrifugationInstance, field: 'firstCentrifugation.endTime', 'error')} required">
                    <label for="firstCentrifugation.endTime" class="control-label"><g:message code="centrifugation.firstCentrifugation.endTime.label" default="End Time" /><span class="required-indicator">*</span></label>
                    <div>
                        <bs:datePicker name="firstCentrifugation.endTime" precision="minute"  value="${centrifugationInstance?.firstCentrifugation?.endTime}"  />
                        <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'firstCentrifugation.endTime', 'error')}</span>
                    </div>
                </div>

                <div class="fieldcontain${hasErrors(bean: centrifugationInstance, field: 'firstCentrifugation.startTime', 'error')} required">
                    <label for="firstCentrifugation.startTime" class="control-label"><g:message code="centrifugation.firstCentrifugation.startTime.label" default="Start Time" /><span class="required-indicator">*</span></label>
                    <div>
                        <bs:datePicker name="firstCentrifugation.startTime" precision="minute"  value="${centrifugationInstance?.firstCentrifugation?.startTime}"  />
                        <span class="help-inline">${hasErrors(bean: centrifugationInstance, field: 'firstCentrifugation.startTime', 'error')}</span>
                    </div>
                </div>
            </fieldset>
            <g:if test="${centrifugationInstance?.firstCentrifugation?.centrifugationBrake !=null}">
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
            </g:if>
