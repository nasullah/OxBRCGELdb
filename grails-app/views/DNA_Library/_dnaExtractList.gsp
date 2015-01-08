


            <div class="${hasErrors(bean: DNA_LibraryInstance, field: 'na_extract', 'error')} ">
                <label for="na_extract" class="control-label"><g:message code="DNA_Library.na_extract.label" default="DNA Extract" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" name="na_extract" from="${listDNAExtractByGeLId}"
                              multiple="multiple" optionKey="id" size="5" value="${DNA_LibraryInstance?.na_extract*.id}" class="many-to-many"/>
                    <span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'na_extract', 'error')}</span>
                </div>
            </div>