<%@ page import="geldb.AliquotType" %>


        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: aliquotTypeInstance, field: 'aliquotTypeName', 'error')} ">
                    <label for="aliquotTypeName" class="control-label"><g:message code="aliquotType.aliquotTypeName.label" default="Aliquot Type Name" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:textField class="form-control" name="aliquotTypeName" required="" value="${aliquotTypeInstance?.aliquotTypeName}"/>
                        <span class="help-inline">${hasErrors(bean: aliquotTypeInstance, field: 'aliquotTypeName', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: aliquotTypeInstance, field: 'aliquotTypeDesc', 'error')} ">
                    <label for="aliquotTypeDesc" class="control-label"><g:message code="aliquotType.aliquotTypeDesc.label" default="Aliquot Type Desc" /></label>
                    <div>
                        <g:textField class="form-control" name="aliquotTypeDesc" value="${aliquotTypeInstance?.aliquotTypeDesc}"/>
                        <span class="help-inline">${hasErrors(bean: aliquotTypeInstance, field: 'aliquotTypeDesc', 'error')}</span>
                    </div>
                </div>
            </div>
        </div>

