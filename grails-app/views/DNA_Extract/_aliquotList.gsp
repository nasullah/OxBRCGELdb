<div>
    <g:select class="form-control" name="aliquot" from="${listAliquotsByGeLId}"
              multiple="multiple" optionKey="id" size="5" value="${DNA_ExtractInstance?.aliquot*.id}" class="many-to-many"/>
    <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'aliquot', 'error')}</span>
</div>