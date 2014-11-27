<div>
    <g:select class="form-control" id="specimen" name="specimen.id" size="5" from="${listSpecimenByGeLId}" optionKey="id" required="" value="${aliquotInstance?.specimen?.id}" class="many-to-one"/>
    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'specimen', 'error')}</span>
</div>