<%@ page import="geldb.SolidSpecimen; geldb.FluidSpecimen; geldb.Aliquot; geldb.SampleTrackingEvent" %>
<%@ page import="geldb.Specimen" %>

            <br/>
            <p><b>${FluidSpecimen.findById(sampleTrackingEventInstance?.identifiedSample?.id) }</b></p>
            <p><b>${SolidSpecimen.findById(sampleTrackingEventInstance?.identifiedSample?.id) }</b></p>
            <p><b>${Aliquot.findById(sampleTrackingEventInstance?.identifiedSample?.id) }</b></p>
            <g:hiddenField name="identifiedSample.id" id="identifiedSample" value="${sampleTrackingEventInstance?.identifiedSample?.id}"/>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'sampleTrackingEventType', 'error')} required">
                        <label for="sampleTrackingEventType" class="control-label"><g:message code="sampleTrackingEvent.sampleTrackingEventType.label" default="Sample Tracking Event Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="sampleTrackingEventType" name="sampleTrackingEventType.id" from="${geldb.SampleTrackingEventType.list()}"
                                      optionKey="id" required="" value="${sampleTrackingEventInstance?.sampleTrackingEventType?.id}" />
                            <span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'sampleTrackingEventType', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'date', 'error')} required">
                        <label for="date" class="control-label"><g:message code="sampleTrackingEvent.date.label" default="Date" /><span class="required-indicator">*</span></label>
                        <div>
                            <bs:datePicker name="date" precision="day"  value="${sampleTrackingEventInstance?.date}"  />
                            <span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'date', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'time', 'error')} ">
                        <label for="time" class="control-label"><g:message code="sampleTrackingEvent.time.label" default="Time" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field type="time" class="form-control" name="time" value="${sampleTrackingEventInstance?.time}" required=""/>
                            <span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'time', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

