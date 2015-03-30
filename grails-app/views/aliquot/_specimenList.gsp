

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'specimen', 'error')} required">
                        <label for="specimen" class="control-label"><g:message code="aliquot.specimen.label" default="Specimen" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="specimen" name="specimen.id" size="5" from="${listSpecimenByGeLId}" optionKey="id" onchange="exhaustFluidSpecimen()" required="" value="${aliquotInstance?.specimen?.id}" class="many-to-one"/>
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'specimen', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

