<%@ page import="geldb.Derivation" %>



			<div class="${hasErrors(bean: derivationInstance, field: 'aliquot', 'error')} required">
				<label for="aliquot" class="control-label"><g:message code="derivation.aliquot.label" default="Aliquot" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="aliquot" name="aliquot.id" from="${geldb.Aliquot.list()}" optionKey="id" required="" value="${derivationInstance?.aliquot?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: derivationInstance, field: 'aliquot', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: derivationInstance, field: 'derivationDate', 'error')} required">
                        <label for="derivationDate" class="control-label"><g:message code="derivation.derivationDate.label" default="Derivation Date" /><span class="required-indicator">*</span></label>
                        <div>
                            <bs:datePicker name="derivationDate" precision="day"  value="${derivationInstance?.derivationDate}"  />
                            <span class="help-inline">${hasErrors(bean: derivationInstance, field: 'derivationDate', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: derivationInstance, field: 'derivationTime', 'error')} ">
                        <label for="derivationTime" class="control-label"><g:message code="derivation.derivationTime.label" default="Derivation Time" /></label>
                        <div>
                            <g:textField class="form-control" name="derivationTime" value="${derivationInstance?.derivationTime}"/>
                            <span class="help-inline">${hasErrors(bean: derivationInstance, field: 'derivationTime', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			<div class="${hasErrors(bean: derivationInstance, field: 'derivedBy', 'error')} required">
				<label for="derivedBy" class="control-label"><g:message code="derivation.derivedBy.label" default="Derived By" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="derivedBy" name="derivedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" required="" value="${derivationInstance?.derivedBy?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: derivationInstance, field: 'derivedBy', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: derivationInstance, field: 'notes', 'error')} ">
                        <label for="notes" class="control-label"><g:message code="derivation.notes.label" default="Notes" /></label>
                        <div>
                            <g:textArea class="form-control" name="notes" cols="40" rows="5" value="${derivationInstance?.notes}"/>
                            <span class="help-inline">${hasErrors(bean: derivationInstance, field: 'notes', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: derivationInstance, field: 'derivationProcess', 'error')} required">
                        <label for="derivationProcess" class="control-label"><g:message code="derivation.derivationProcess.label" default="Derivation Process" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" name="derivationProcess" from="${geldb.DerivationType?.values()}" keys="${geldb.DerivationType.values()*.name()}" required="" value="${derivationInstance?.derivationProcess?.name()}"/>
                            <span class="help-inline">${hasErrors(bean: derivationInstance, field: 'derivationProcess', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			%{--<div class="${hasErrors(bean: derivationInstance, field: 'report', 'error')} ">--}%
				%{--<label for="report" class="control-label"><g:message code="derivation.report.label" default="Report" /></label>--}%
				%{--<div>--}%
					%{--<g:select class="form-control" id="report" name="report.id" from="${geldb.Report.list()}" optionKey="id" value="${derivationInstance?.report?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: derivationInstance, field: 'report', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: derivationInstance, field: 'derivedAliquots', 'error')} ">--}%
				%{--<label for="derivedAliquots" class="control-label"><g:message code="derivation.derivedAliquots.label" default="Derived Aliquots" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${derivationInstance?.derivedAliquots?}" var="d">--}%
    %{--<li><g:link controller="aliquot" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="aliquot" action="create" params="['derivation.id': derivationInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Aliquot')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: derivationInstance, field: 'derivedAliquots', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

