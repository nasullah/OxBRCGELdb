<%@ page import="geldb.FlowCell" %>



			<div class="${hasErrors(bean: flowCellInstance, field: 'sequencingRun', 'error')} required">
				<label for="sequencingRun" class="control-label"><g:message code="flowCell.sequencingRun.label" default="Sequencing Run" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="sequencingRun" name="sequencingRun.id" from="${geldb.SequencingRun.list()}" optionKey="id" required="" value="${flowCellInstance?.sequencingRun?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: flowCellInstance, field: 'sequencingRun', 'error')}</span>
				</div>
			</div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: flowCellInstance, field: 'libraryLoadingConcentration', 'error')} required">
				<label for="libraryLoadingConcentration" class="control-label"><g:message code="flowCell.libraryLoadingConcentration.label" default="Library Loading Concentration" /><span class="required-indicator">*</span></label>
				<div>
					<g:field class="form-control" name="libraryLoadingConcentration" value="${fieldValue(bean: flowCellInstance, field: 'libraryLoadingConcentration')}" required=""/>
					<span class="help-inline">${hasErrors(bean: flowCellInstance, field: 'libraryLoadingConcentration', 'error')}</span>
				</div>
			</div>
    </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: flowCellInstance, field: 'clusterDensity', 'error')} required">
				<label for="clusterDensity" class="control-label"><g:message code="flowCell.clusterDensity.label" default="Cluster Density" /><span class="required-indicator">*</span></label>
				<div>
					<g:field class="form-control" name="clusterDensity" value="${fieldValue(bean: flowCellInstance, field: 'clusterDensity')}" required=""/>
					<span class="help-inline">${hasErrors(bean: flowCellInstance, field: 'clusterDensity', 'error')}</span>
				</div>
			</div>
    </div>
</div>

			%{--<div class="${hasErrors(bean: flowCellInstance, field: 'containedLane', 'error')} ">--}%
				%{--<label for="containedLane" class="control-label"><g:message code="flowCell.containedLane.label" default="Contained Lane" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${flowCellInstance?.containedLane?}" var="c">--}%
    %{--<li><g:link controller="lane" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="lane" action="create" params="['flowCell.id': flowCellInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'lane.label', default: 'Lane')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: flowCellInstance, field: 'containedLane', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

