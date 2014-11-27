<%@ page import="geldb.Lane" %>



			<div class="${hasErrors(bean: laneInstance, field: 'flowCell', 'error')} required">
				<label for="flowCell" class="control-label"><g:message code="lane.flowCell.label" default="Flow Cell" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="flowCell" name="flowCell.id" from="${geldb.FlowCell.list()}" optionKey="id" required="" value="${laneInstance?.flowCell?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: laneInstance, field: 'flowCell', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: laneInstance, field: 'laneNumber', 'error')} required">
                        <label for="laneNumber" class="control-label"><g:message code="lane.laneNumber.label" default="Lane Number" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="laneNumber" type="number" value="${laneInstance.laneNumber}" required=""/>
                            <span class="help-inline">${hasErrors(bean: laneInstance, field: 'laneNumber', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label for="laneNumber" class="control-label"><g:message code="lane.laneNumber.label" default="." /></label>
                    <div class="input-group">
                        <g:textField type="text" id="search" name="search" class="form-control"  placeholder="Enter participant's GeL Id" required="" ></g:textField>
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-success" value="Find" onClick= 'getDNALibrary()'><span class="glyphicon glyphicon-search"></span> Find DNA Library</button>
                        </div>
                    </div>
                </div>
            </div>

			<div class="${hasErrors(bean: laneInstance, field: 'loadedLibrary', 'error')} ">
				<label for="loadedLibrary" class="control-label"><g:message code="lane.loadedLibrary.label" default="Loaded Library" /><span class="required-indicator">*</span></label>
                <div id="selectDNALibrary">
                    <g:select class=""  name="1" from="${''}" optionKey="" value="${''}" required=""/>
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
                            <p>No DNA Library found with the Gel Id you entered</p>
                        </div>
                        <div class="modal-footer">
                            <a class='btn btn-primary btn-small' <g:link controller="DNA_Library" action="create" ><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'DNA_Library.label', default: 'DNA Library')])}</g:link>
                            <button type="button" class="btn" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function getDNALibrary(){
        ${remoteFunction (controller: 'lane',
                        action: 'findDNALibraryByGeLId',
                        params: '"search=" + $("#search").val()',
                        update: 'selectDNALibrary',
                        onFailure:'error()'
                )}
    }

    function error(){
        $('#notFound').modal()
    }
</script>

