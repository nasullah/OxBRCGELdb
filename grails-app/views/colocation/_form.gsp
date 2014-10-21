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

			<div class="${hasErrors(bean: colocationInstance, field: 'pairedAliquot', 'error')} ">
				<label for="pairedAliquot" class="control-label"><g:message code="colocation.pairedAliquot.label" default="Paired Aliquot" /></label>
				<div>
					<g:select class="form-control" id="pairedAliquot" name="pairedAliquot.id" from="${geldb.Aliquot.findAllBySpecimen(colocationInstance?.aliquot?.specimen)}"
                              optionKey="id" value="${colocationInstance?.pairedAliquot?.id}" class="many-to-one" noSelection="['null': '-Choose an existing aliquot-']"/>
					<span class="help-inline">${hasErrors(bean: colocationInstance, field: 'pairedAliquot', 'error')}</span>
				</div>
			</div>

