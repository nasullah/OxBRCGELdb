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
            </div>

            <g:if test="${laneInstance?.loadedLibrary*.id == null}">
                <div class="row">
                    <div class="col-lg-6">
                        <label for="laneNumber" class="control-label"><g:message code="lane.laneNumber.label" default="Enter participant's GeL Id" /></label>
                        <div class="input-group">
                            <g:textField type="text" id="search" name="search" class="form-control"  placeholder="GEL000" required="" ></g:textField>
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-success" value="Find" onClick= 'getDNALibrary()'><span class="glyphicon glyphicon-search"></span> Find DNA Library</button>
                            </div>
                        </div>
                    </div>
                </div>
                <p>
                <div id="selectDNALibrary"></div>
            </g:if>

            <g:if test="${laneInstance?.loadedLibrary*.id != null}">
                <div class="${hasErrors(bean: laneInstance, field: 'loadedLibrary', 'error')} ">
                    <label for="loadedLibrary" class="control-label"><g:message code="lane.loadedLibrary.label" default="Loaded Library" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" name="loadedLibrary" from="${geldb.DNA_Library.list()}" multiple="multiple" optionKey="id" size="1" value="${laneInstance?.loadedLibrary*.id}" class="many-to-many"/>
                        <span class="help-inline">${hasErrors(bean: laneInstance, field: 'loadedLibrary', 'error')}</span>
                    </div>
                </div>
            </g:if>

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
        var select = $("#selectDNALibrary");
        select.empty().append("Not found");
        $('#notFound').modal()
    }
</script>

