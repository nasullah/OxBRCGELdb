<%@ page import="geldb.Colocation" %>


<div class="${hasErrors(bean: colocationInstance, field: 'aliquot', 'error')} required">
    <label for="aliquot" class="control-label"><g:message code="colocation.aliquot.label" default="Aliquot" /><span class="required-indicator">*</span></label>
    <div>
        <g:select class="form-control" id="aliquot" name="aliquot.id" from="${geldb.Aliquot.list()}" optionKey="id" required="" value="${colocationInstance?.aliquot?.id}" class="many-to-one"/>
        <span class="help-inline">${hasErrors(bean: colocationInstance, field: 'aliquot', 'error')}</span>
    </div>
</div>

			<div class="${hasErrors(bean: colocationInstance, field: 'adjacent', 'error')} ">
				<label for="adjacent" class="control-label"><g:message code="colocation.adjacent.label" default="Adjacent" /></label>
				<div>
					<bs:checkBox name="adjacent" value="${colocationInstance?.adjacent}" />
					<span class="help-inline">${hasErrors(bean: colocationInstance, field: 'adjacent', 'error')}</span>
				</div>
			</div>
<div class="row">
   <div class="col-lg-6">
			<div class="${hasErrors(bean: colocationInstance, field: 'notes', 'error')} ">
				<label for="notes" class="control-label"><g:message code="colocation.notes.label" default="Notes" /></label>
				<div>
					<g:textArea class="form-control" name="notes" cols="40" rows="5" value="${colocationInstance?.notes}"/>
					<span class="help-inline">${hasErrors(bean: colocationInstance, field: 'notes', 'error')}</span>
				</div>
			</div>
   </div>
</div>


			%{--<div class="${hasErrors(bean: colocationInstance, field: 'pairedAliquot', 'error')} ">--}%
				%{--<label for="pairedAliquot" class="control-label"><g:message code="colocation.pairedAliquot.label" default="Paired Aliquot" /></label>--}%
				%{--<div>--}%
                    %{--<div>--}%
                        %{--<g:select class="form-control"  name="pairedAliquot" from="${geldb.Aliquot.list()}" multiple="multiple" optionKey="id" size="5" value="${colocationInstance?.pairedAliquot*.id}" class="many-to-many"/>--}%
                        %{--<span class="help-inline">${hasErrors(bean: colocationInstance, field: 'pairedAliquot', 'error')}</span>--}%
                    %{--</div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${colocationInstance?.pairedAliquot?}" var="p">--}%
    %{--<li><g:link controller="aliquot" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="aliquot" action="create" params="['colocation.id': colocationInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Aliquot')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: colocationInstance, field: 'pairedAliquot', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

%{--<g:select class="form-control" name="na_extract" from="${geldb.DNA_Extract.list()}" multiple="multiple" optionKey="id" size="5" value="${DNA_LibraryInstance?.na_extract*.id}" class="many-to-many"/>--}%
%{--<span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'na_extract', 'error')}</span>--}%