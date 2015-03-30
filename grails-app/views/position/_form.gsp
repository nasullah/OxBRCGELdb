<%@ page import="geldb.Position" %>




            <div class="${hasErrors(bean: positionInstance, field: 'identifiedSample', 'error')} required">
                <label for="identifiedSample" class="control-label"><g:message code="position.identifiedSample.label" default="Sample" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="identifiedSample" name="identifiedSample.id" from="${geldb.IdentifiedSample.list()}" optionKey="id" required="" size="1" multiple="false" value="${positionInstance?.containedSamples?.id}" class="many-to-one"/>
                    <span class="help-inline">${hasErrors(bean: positionInstance, field: 'identifiedSample', 'error')}</span>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="">
                        <label for="freezer" class="control-label"><g:message code="shelf.freezer.label" default="Choose Freezer" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="freezer" name="freezer.id" from="${geldb.Freezer.list().sort {it.freezerName}}" optionKey="id" required="" onchange="filterPlateBox()" value= "${positionInstance.plateOrBox?.shelf?.freezer?.id}" noSelection="['':'- Choose -']"/>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div id="filter" class="${hasErrors(bean: positionInstance, field: 'plateOrBox', 'error')} required">
                        <label for="plateOrBox" class="control-label"><g:message code="position.plateOrBox.label" default="Choose Plate or Box" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="plateOrBox" name="plateOrBox.id" from="${geldb.PlateOrBox.list().sort {it.shelf}}" optionKey="id" required=""  value="${positionInstance?.plateOrBox?.id}" noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: positionInstance, field: 'plateOrBox', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: positionInstance, field: 'letter', 'error')} ">
                        <label for="letter" class="control-label"><g:message code="position.letter.label" default="Letter" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="letter" value="${positionInstance?.letter}" required=""/>
                            <span class="help-inline">${hasErrors(bean: positionInstance, field: 'letter', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: positionInstance, field: 'number', 'error')} ">
                        <label for="number" class="control-label"><g:message code="position.number.label" default="Number" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="number" value="${positionInstance?.number}" required=""/>
                            <span class="help-inline">${hasErrors(bean: positionInstance, field: 'number', 'error')}</span>
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
                            <p>No sample found with the Gel Id you entered, or all samples of the Gel Id have already been allocated positions.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function validate(){
        ${remoteFunction (controller: 'position',
                        action: 'validateUniqueness',
                        params: '\'number=\' + $("#number").val() + \'&letter=\' + $("#letter").val()',
                        onFailure:'error()'
                )}
    }

    function error(){
        //alert('sfgsdfsdfsdf')
       $('#notFound').modal()
    }

    <g:javascript plugin="jquery" library="jquery" />

    function filterPlateBox(){
        ${remoteFunction (controller: 'position',
                        action: 'filterPlateOrBox',
                        params: '"freezer=" + $("#freezer").val()',
                        update: 'filter',
                        onFailure: 'errorFilterPlateBox()'
                )}
    }

    function errorFilterPlateBox(request, status, error){
        $('#plateOrBox').val("");
    }
</script>




