<%@ page import="geldb.DispatchedBox" %>



        <div class="${hasErrors(bean: dispatchedBoxInstance, field: 'dispatchRecord', 'error')} required">
            <label for="dispatchRecord" class="control-label"><g:message code="dispatchedBox.dispatchRecord.label" default="Dispatch Record" /><span class="required-indicator">*</span></label>
            <div>
                <g:select class="form-control" id="dispatchRecord" name="dispatchRecord.id" from="${geldb.DispatchRecord.list()}" optionKey="id" required="" value="${dispatchedBoxInstance?.dispatchRecord?.id}" class="many-to-one"/>
                <span class="help-inline">${hasErrors(bean: dispatchedBoxInstance, field: 'dispatchRecord', 'error')}</span>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: dispatchedBoxInstance, field: 'barcode', 'error')} ">
                    <label for="barcode" class="control-label"><g:message code="dispatchedBox.barcode.label" default="Barcode" /></label>
                    <div>
                        <g:textField class="form-control" name="barcode" value="${dispatchedBoxInstance?.barcode}"/>
                        <span class="help-inline">${hasErrors(bean: dispatchedBoxInstance, field: 'barcode', 'error')}</span>
                    </div>
                </div>
            </div>
        </div>


