<%@ page import="geldb.SampleTrackingEvent" %>



			<div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'specimen', 'error')} required">
				<label for="specimen" class="control-label"><g:message code="sampleTrackingEvent.specimen.label" default="Specimen" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="specimen" name="specimen.id" from="${geldb.Specimen.list()}" optionKey="id" required="" value="${sampleTrackingEventInstance?.specimen?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'specimen', 'error')}</span>
				</div>
			</div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'sampleTrackingEventType', 'error')} required">
				<label for="sampleTrackingEventType" class="control-label"><g:message code="sampleTrackingEvent.sampleTrackingEventType.label" default="Sample Tracking Event Type" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" name="sampleTrackingEventType" from="${geldb.SampleTrackingEventType?.values()}" keys="${geldb.SampleTrackingEventType.values()*.name()}" required="" value="${sampleTrackingEventInstance?.sampleTrackingEventType?.name()}"/>
					<span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'sampleTrackingEventType', 'error')}</span>
				</div>
			</div>
        </div>
</div>

			<div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'date', 'error')} required">
				<label for="date" class="control-label"><g:message code="sampleTrackingEvent.date.label" default="Date" /><span class="required-indicator">*</span></label>
				<div>
					<bs:datePicker name="date" precision="day"  value="${sampleTrackingEventInstance?.date}"  />
					<span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'date', 'error')}</span>
				</div>
			</div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'time', 'error')} ">
				<label for="time" class="control-label"><g:message code="sampleTrackingEvent.time.label" default="Time" /></label>
				<div>
					<g:textField class="form-control" name="time" value="${sampleTrackingEventInstance?.time}"/>
					<span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'time', 'error')}</span>
				</div>
			</div>
        </div>
</div>

