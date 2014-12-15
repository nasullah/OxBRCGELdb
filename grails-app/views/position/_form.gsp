<%@ page import="geldb.Position" %>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: positionInstance, field: 'plateOrBox', 'error')} required">
                        <label for="plateOrBox" class="control-label"><g:message code="position.plateOrBox.label" default="Plate Or Box" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="plateOrBox" name="plateOrBox.id" from="${geldb.PlateOrBox.list()}" optionKey="id" required="" value="${positionInstance?.plateOrBox?.id}"/>
                            <span class="help-inline">${hasErrors(bean: positionInstance, field: 'plateOrBox', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: positionInstance, field: 'letter', 'error')} ">
                        <label for="letter" class="control-label"><g:message code="position.letter.label" default="Letter" /></label>
                        <div>
                            <g:textField class="form-control" name="letter" value="${positionInstance?.letter}"/>
                            <span class="help-inline">${hasErrors(bean: positionInstance, field: 'letter', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: positionInstance, field: 'number', 'error')} ">
                        <label for="number" class="control-label"><g:message code="position.number.label" default="Number" /></label>
                        <div>
                            <g:textField class="form-control" name="number" value="${positionInstance?.number}"/>
                            <span class="help-inline">${hasErrors(bean: positionInstance, field: 'number', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="">
                        <label  class="control-label">Sample Type<span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="sampleType" name="sampleType.id" from="${['Fluid Specimen', 'Solid Specimen', 'Aliquot', 'DNA Extract', 'DNA Library']}" required="" noSelection="['':'- Choose Sample Type -']"/>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label class="">Find Sample</label>
                    <div class="input-group">
                        <g:textField type="text" id="search" name="search" class="form-control"  placeholder="Enter participant's GeL Id" required="" ></g:textField>
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-success" value="Find" onClick= 'getSample()'><span class="glyphicon glyphicon-search"></span> Find</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: dispatchItemInstance, field: 'identifiedSample', 'error')} required">
                        <label for="identifiedSample" class="control-label"><g:message code="dispatchItem.identifiedSample.label" default="Sample" /><span class="required-indicator">*</span></label>
                        <div id="selectFoundSamples">
                            <g:select class=""  name="1" from="${''}" optionKey="" value="${''}" required=""/>
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
                            <p>No sample found with the Gel Id you entered</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function getSample(){
        ${remoteFunction (controller: 'position',
                        action: 'findSampleByGeLId',
                        params: '\'search=\' + $("#search").val() + \'&selectType=\' + $("#sampleType").val()',
                        update: 'selectFoundSamples',
                        onFailure:'error()'
                )}
    }

    function error(){
        var select = $("#selectFoundSamples");
        select.empty().append("Not found");
        $('#notFound').modal()

    }
</script>




