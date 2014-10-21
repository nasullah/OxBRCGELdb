<%@ page import="geldb.SampleTrackingEvent" %>
<%@ page import="geldb.Specimen" %>



			<div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'specimen', 'error')} required">
				<label for="specimen" class="control-label"><g:message code="sampleTrackingEvent.specimen.label" default="Specimen" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="specimen" name="specimen.id" from="${geldb.Specimen.list()}" optionKey="id" required="" value="${sampleTrackingEventInstance?.specimen?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'specimen', 'error')}</span>
				</div>
			</div>

            %{--<div class="row">--}%
                %{--<div class="col-lg-6">--}%
                    %{--<div class="">--}%
                        %{--<label for="specimen" class="control-label"><g:message code="barcode" default="Barcode" /><span class="required-indicator">*</span></label>--}%
                        %{--<div>--}%
                            %{--<g:textField class="form-control" name="barcode" value="${params.barcode}" placeholder="Scan Barcode" />--}%
                            %{--<span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'specimen', 'error')}</span>--}%

                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%
                %{--<div class="col-lg-6">--}%
                    %{--<div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'specimen', 'error')} required">--}%
                        %{--<label for="specimen" class="control-label"><g:message code="sampleTrackingEvent.specimen.label" default="Specimen" /><span class="required-indicator">*</span></label>--}%
                        %{--<div>--}%
                            %{--<g:textField class="form-control" name="specimen" value="${sampleTrackingEventInstance?.specimen?.id}"/>--}%
                            %{--<span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'specimen', 'error')}</span>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%
            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'sampleTrackingEventType', 'error')} required">
                        <label for="sampleTrackingEventType" class="control-label"><g:message code="sampleTrackingEvent.sampleTrackingEventType.label" default="Sample Tracking Event Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="sampleTrackingEventType" name="sampleTrackingEventType.id" from="${geldb.SampleTrackingEventType.list()}" optionKey="id" required="" value="${sampleTrackingEventInstance?.sampleTrackingEventType?.id}" />
                            <span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'sampleTrackingEventType', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'date', 'error')} required">
                        <label for="date" class="control-label"><g:message code="sampleTrackingEvent.date.label" default="Date" /><span class="required-indicator">*</span></label>
                        <div>
                            <bs:datePicker name="date" precision="day"  value="${sampleTrackingEventInstance?.date}"  />
                            <span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'date', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'time', 'error')} ">
                        <label for="time" class="control-label"><g:message code="sampleTrackingEvent.time.label" default="Time" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="time" value="${sampleTrackingEventInstance?.time}"/>
                            <span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'time', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>


