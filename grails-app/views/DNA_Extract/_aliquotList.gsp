


        <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'aliquot', 'error')} ">
            <label for="aliquot" class="control-label"><g:message code="DNA_Extract.aliquot.label" default="Aliquot" /><span class="required-indicator">*</span></label>
            <div>
                <g:select class="form-control" name="aliquot" id="aliquot" from="${listAliquotsByGeLId}"
                          multiple="multiple" size="5" optionKey="id" value="${DNA_ExtractInstance?.aliquot*.id}" required="" class="many-to-many" onchange="getElution()"/>
                <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'aliquot', 'error')}</span>
            </div>
        </div>



