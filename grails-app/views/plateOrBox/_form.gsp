<%@ page import="geldb.PlateOrBox" %>


            <div class="${hasErrors(bean: plateOrBoxInstance, field: 'shelf', 'error')} required">
                <label for="shelf" class="control-label"><g:message code="plateOrBox.shelf.label" default="Shelf" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="shelf" name="shelf.id" from="${geldb.Shelf.list()}" optionKey="id" required="" value="${plateOrBoxInstance?.shelf?.id}" class="many-to-one"/>
                    <span class="help-inline">${hasErrors(bean: plateOrBoxInstance, field: 'shelf', 'error')}</span>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: plateOrBoxInstance, field: 'identifier', 'error')} ">
                        <label for="identifier" class="control-label"><g:message code="plateOrBox.identifier.label" default="Identifier" /></label>
                        <div>
                            <g:textField class="form-control" name="identifier" value="${plateOrBoxInstance?.identifier}"/>
                            <span class="help-inline">${hasErrors(bean: plateOrBoxInstance, field: 'identifier', 'error')}</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: plateOrBoxInstance, field: 'storageLocation', 'error')} ">
                        <label for="storageLocation" class="control-label"><g:message code="plateOrBox.storageLocation.label" default="Storage Location" /></label>
                        <div>
                            <g:textField class="form-control" name="storageLocation" value="${plateOrBoxInstance?.storageLocation}"/>
                            <span class="help-inline">${hasErrors(bean: plateOrBoxInstance, field: 'storageLocation', 'error')}</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: plateOrBoxInstance, field: 'numberOfWells', 'error')} ">
                        <label for="numberOfWells" class="control-label"><g:message code="plateOrBox.numberOfWells.label" default="Number Of Wells" /></label>
                        <div>
                            <g:field class="form-control" name="numberOfWells" type="number" value="${plateOrBoxInstance.numberOfWells}"/>
                            <span class="help-inline">${hasErrors(bean: plateOrBoxInstance, field: 'numberOfWells', 'error')}</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: plateOrBoxInstance, field: 'plateType', 'error')} ">
                        <label for="plateType" class="control-label"><g:message code="plateOrBox.plateType.label" default="Plate Type" /></label>
                        <div>
                            <g:textField class="form-control" name="plateType" value="${plateOrBoxInstance?.plateType}"/>
                            <span class="help-inline">${hasErrors(bean: plateOrBoxInstance, field: 'plateType', 'error')}</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: plateOrBoxInstance, field: 'intendedAssay', 'error')} ">
                        <label for="intendedAssay" class="control-label"><g:message code="plateOrBox.intendedAssay.label" default="Intended Assay" /></label>
                        <div>
                            <g:textField class="form-control" name="intendedAssay" value="${plateOrBoxInstance?.intendedAssay}"/>
                            <span class="help-inline">${hasErrors(bean: plateOrBoxInstance, field: 'intendedAssay', 'error')}</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: plateOrBoxInstance, field: 'barcode', 'error')} ">
                        <label for="barcode" class="control-label"><g:message code="plateOrBox.barcode.label" default="Barcode" /></label>
                        <div>
                            <g:textField class="form-control" name="barcode" value="${plateOrBoxInstance?.barcode}"/>
                            <span class="help-inline">${hasErrors(bean: plateOrBoxInstance, field: 'barcode', 'error')}</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: plateOrBoxInstance, field: 'notes', 'error')} ">
                        <label for="notes" class="control-label"><g:message code="plateOrBox.notes.label" default="Notes" /></label>
                        <div>
                            <g:textArea class="form-control" name="notes" cols="40" rows="5" value="${plateOrBoxInstance?.notes}"/>
                            <span class="help-inline">${hasErrors(bean: plateOrBoxInstance, field: 'notes', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>


			%{--<div class="${hasErrors(bean: plateOrBoxInstance, field: 'well', 'error')} ">--}%
				%{--<label for="well" class="control-label"><g:message code="plateOrBox.well.label" default="Well" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${plateOrBoxInstance?.well?}" var="w">--}%
    %{--<li><g:link controller="position" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="position" action="create" params="['plateOrBox.id': plateOrBoxInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'position.label', default: 'Position')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: plateOrBoxInstance, field: 'well', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

