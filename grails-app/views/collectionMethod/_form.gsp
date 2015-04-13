<%@ page import="geldb.CollectionMethod" %>



            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: collectionMethodInstance, field: 'collectionMethodName', 'error')} ">
                        <label for="collectionMethodName" class="control-label"><g:message code="collectionMethod.collectionMethodName.label" default="Collection Method Name" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="collectionMethodName" required="" value="${collectionMethodInstance?.collectionMethodName}"/>
                            <span class="help-inline">${hasErrors(bean: collectionMethodInstance, field: 'collectionMethodName', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: collectionMethodInstance, field: 'collectionMethodDesc', 'error')} ">
                        <label for="collectionMethodDesc" class="control-label"><g:message code="collectionMethod.collectionMethodDesc.label" default="Collection Method Desc" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="collectionMethodDesc" required="" value="${collectionMethodInstance?.collectionMethodDesc}"/>
                            <span class="help-inline">${hasErrors(bean: collectionMethodInstance, field: 'collectionMethodDesc', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

