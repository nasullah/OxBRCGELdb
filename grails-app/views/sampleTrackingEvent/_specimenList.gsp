<div>
    <g:select class="form-control" id="identifiedSample" name="identifiedSample.id" from="${listSpecimenByGeLId}" optionKey="id" required="" value="${sampleTrackingEventInstance?.identifiedSample?.id}" />
    <span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'identifiedSample', 'error')}</span>
</div>