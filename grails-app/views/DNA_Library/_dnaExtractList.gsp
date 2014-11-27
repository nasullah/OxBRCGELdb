<div>
    <g:select class="form-control" name="na_extract" from="${listDNAExtractByGeLId}"
              multiple="multiple" optionKey="id" size="5" value="${DNA_LibraryInstance?.na_extract*.id}" class="many-to-many"/>
    <span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'na_extract', 'error')}</span>
</div>