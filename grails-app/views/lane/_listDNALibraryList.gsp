<div>
    <g:select class="form-control" name="loadedLibrary" from="${listDNALibraryByGeLId}" multiple="multiple" optionKey="id" size="5" value="${laneInstance?.loadedLibrary*.id}" class="many-to-many"/>
    <span class="help-inline">${hasErrors(bean: laneInstance, field: 'loadedLibrary', 'error')}</span>
</div>