<%@ page import="geldb.SampleTrackingEvent" %>
<%@ page import="geldb.Specimen" %>

            <hr style="border:1; height:1px" />

            <div class="row">
                <div class="col-lg-6">
                    <label  class=""><g:message code="l" default="Enter participant's GeL Id" /></label>
                    <div class="input-group">
                        <g:textField type="text" id="search" name="search" class="form-control"  placeholder="Enter participant's GeL Id" required="" ></g:textField>
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-success" value="Find" onClick= 'getSpecimen()'><span class="glyphicon glyphicon-search"></span> Find Specimen</button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="">
                        <label for="barcode" class="control-label"> Barcode</label>
                        <div>
                            <g:textField class="form-control" name="barcode" value=""/>
                            <span class="help-inline"></span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'identifiedSample', 'error')} required">
                        <label for="specimen" class="control-label"><g:message code="sampleTrackingEvent.identifiedSample.label" default="Specimen" /><span class="required-indicator">*</span></label>
                        <div id="selectSpecimen">
                            <g:select class="form-control"  name="1" from="${''}" optionKey="" value="${''}" required=""/>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sampleTrackingEventInstance, field: 'sampleTrackingEventType', 'error')} required">
                        <label for="sampleTrackingEventType" class="control-label"><g:message code="sampleTrackingEvent.sampleTrackingEventType.label" default="Sample Tracking Event Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="sampleTrackingEventType" name="sampleTrackingEventType.id" from="${geldb.SampleTrackingEventType.findAllBySampleTrackingEventTypeName('Despatched to Oxford')}"
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
                            <g:field type="time" class="form-control" name="time" value="${sampleTrackingEventInstance?.time}"/>
                            <span class="help-inline">${hasErrors(bean: sampleTrackingEventInstance, field: 'time', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="notFound">
                <div class="modal-dialog" style="position: absolute; left: 0%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">Not Found!</h4>
                        </div>
                        <div class="modal-body">
                            <p>No specimen found with the Gel Id you entered</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function getSpecimen(){
        ${remoteFunction (controller: 'sampleTrackingEvent',
                        action: 'findSpecimenToDispatchByGeLId',
                        params: '"search=" + $("#search").val()',
                        update: 'selectSpecimen',
                        onFailure:'error()'
                )}
    }

    function error(){
        $('#notFound').modal()
    }
</script>


