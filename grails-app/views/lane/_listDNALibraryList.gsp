


            <div class="${hasErrors(bean: laneInstance, field: 'loadedLibrary', 'error')} ">
                <label for="loadedLibrary" class="control-label"><g:message code="lane.loadedLibrary.label" default="Loaded Library" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" name="loadedLibrary" from="${listDNALibraryByGeLId}" multiple="multiple" optionKey="id" size="5" value="${laneInstance?.loadedLibrary*.id}" class="many-to-many"/>
                    <span class="help-inline">${hasErrors(bean: laneInstance, field: 'loadedLibrary', 'error')}</span>
                </div>
            </div>


