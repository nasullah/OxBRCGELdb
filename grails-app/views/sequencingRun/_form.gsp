<%@ page import="geldb.SequencingRun" %>



			<div class="${hasErrors(bean: sequencingRunInstance, field: 'runDate', 'error')} required">
				<label for="runDate" class="control-label"><g:message code="sequencingRun.runDate.label" default="Run Date" /><span class="required-indicator">*</span></label>
				<div>
					<bs:datePicker name="runDate" precision="day"  value="${sequencingRunInstance?.runDate}"  />
					<span class="help-inline">${hasErrors(bean: sequencingRunInstance, field: 'runDate', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sequencingRunInstance, field: 'machineName', 'error')} ">
                        <label for="machineName" class="control-label"><g:message code="sequencingRun.machineName.label" default="Machine Name" /></label>
                        <div>
                            <g:textField class="form-control" name="machineName" value="${sequencingRunInstance?.machineName}"/>
                            <span class="help-inline">${hasErrors(bean: sequencingRunInstance, field: 'machineName', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            %{--<g:if test="${sequencingRunInstance?.sequencingReports?.id !=null}">--}%
                %{--<div class="${hasErrors(bean: sequencingRunInstance, field: 'sequencingReports', 'error')} ">--}%
                    %{--<label for="sequencingReports" class="control-label"><g:message code="sequencingRun.sequencingReports.label" default="Sequencing Reports" /></label>--}%
                    %{--<div>--}%
                        %{--<g:select class="form-control" id="sequencingReports" name="sequencingReports.id" from="${geldb.SequencingReports.list()}" optionKey="id" value="${sequencingRunInstance?.sequencingReports?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
                        %{--<span class="help-inline">${hasErrors(bean: sequencingRunInstance, field: 'sequencingReports', 'error')}</span>--}%
                    %{--</div>--}%
                %{--</div>--}%
            %{--</g:if>--}%

			%{--<div class="${hasErrors(bean: sequencingRunInstance, field: 'loadedFlowCell', 'error')} ">--}%
				%{--<label for="loadedFlowCell" class="control-label"><g:message code="sequencingRun.loadedFlowCell.label" default="Loaded Flow Cell" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${sequencingRunInstance?.loadedFlowCell?}" var="l">--}%
    %{--<li><g:link controller="flowCell" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="flowCell" action="create" params="['sequencingRun.id': sequencingRunInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'flowCell.label', default: 'FlowCell')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: sequencingRunInstance, field: 'loadedFlowCell', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

