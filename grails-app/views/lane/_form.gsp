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

			<div class="${hasErrors(bean: laneInstance, field: 'loadedLibrary', 'error')} ">
				<label for="loadedLibrary" class="control-label"><g:message code="lane.loadedLibrary.label" default="Loaded Library" /></label>
				<div>
					<g:select class="form-control" name="loadedLibrary" from="${geldb.DNA_Library.list()}" multiple="multiple" optionKey="id" size="5" value="${laneInstance?.loadedLibrary*.id}" class="many-to-many"/>
					<span class="help-inline">${hasErrors(bean: laneInstance, field: 'loadedLibrary', 'error')}</span>
				</div>
			</div>

