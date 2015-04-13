<%@ page import="geldb.SampleTrackingEventType" %>



            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sampleTrackingEventTypeInstance, field: 'sampleTrackingEventTypeName', 'error')} ">
                        <label for="sampleTrackingEventTypeName" class="control-label"><g:message code="sampleTrackingEventType.sampleTrackingEventTypeName.label" default="Sample Tracking Event Type Name" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="sampleTrackingEventTypeName" required="" value="${sampleTrackingEventTypeInstance?.sampleTrackingEventTypeName}"/>
                            <span class="help-inline">${hasErrors(bean: sampleTrackingEventTypeInstance, field: 'sampleTrackingEventTypeName', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sampleTrackingEventTypeInstance, field: 'sampleTrackingEventTypeDesc', 'error')} ">
                        <label for="sampleTrackingEventTypeDesc" class="control-label"><g:message code="sampleTrackingEventType.sampleTrackingEventTypeDesc.label" default="Sample Tracking Event Type Desc" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="sampleTrackingEventTypeDesc" required="" value="${sampleTrackingEventTypeInstance?.sampleTrackingEventTypeDesc}"/>
                            <span class="help-inline">${hasErrors(bean: sampleTrackingEventTypeInstance, field: 'sampleTrackingEventTypeDesc', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

