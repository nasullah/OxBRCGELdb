<%@ page import="geldb.SequencingReports" %>



			<div class="${hasErrors(bean: sequencingReportsInstance, field: 'sequencingRun', 'error')} required">
				<label for="sequencingRun" class="control-label"><g:message code="sequencingReports.sequencingRun.label" default="Sequencing Run" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="sequencingRun" name="sequencingRun.id" from="${geldb.SequencingRun.list()}" optionKey="id" required="" value="${sequencingReportsInstance?.sequencingRun?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: sequencingReportsInstance, field: 'sequencingRun', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sequencingReportsInstance, field: 'bAMpath', 'error')} ">
                        <label for="bAMpath" class="control-label"><g:message code="sequencingReports.bAMpath.label" default="BAM path" /></label>
                        <div>
                            <g:textField class="form-control" name="bAMpath" value="${sequencingReportsInstance?.bAMpath}"/>
                            <span class="help-inline">${hasErrors(bean: sequencingReportsInstance, field: 'bAMpath', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sequencingReportsInstance, field: 'reportPath', 'error')} ">
                        <label for="reportPath" class="control-label"><g:message code="sequencingReports.reportPath.label" default="Report Path" /></label>
                        <div>
                            <g:textField class="form-control" name="reportPath" value="${sequencingReportsInstance?.reportPath}"/>
                            <span class="help-inline">${hasErrors(bean: sequencingReportsInstance, field: 'reportPath', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			%{--<div class="${hasErrors(bean: sequencingReportsInstance, field: 'vCFpath', 'error')} ">--}%
				%{--<label for="vCFpath" class="control-label"><g:message code="sequencingReports.vCFpath.label" default="V CF path" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${sequencingReportsInstance?.vCFpath?}" var="v">--}%
    %{--<li><g:link controller="VCFpath" action="show" id="${v.id}">${v?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="VCFpath" action="create" params="['sequencingReports.id': sequencingReportsInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'VCFpath.label', default: 'VCFpath')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: sequencingReportsInstance, field: 'vCFpath', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

