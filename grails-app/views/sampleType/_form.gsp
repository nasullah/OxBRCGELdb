<%@ page import="geldb.SampleType" %>



            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sampleTypeInstance, field: 'sampleTypeName', 'error')} ">
                        <label for="sampleTypeName" class="control-label"><g:message code="sampleType.sampleTypeName.label" default="Sample Type Name" /></label>
                        <div>
                            <g:textField class="form-control" name="sampleTypeName" value="${sampleTypeInstance?.sampleTypeName}"/>
                            <span class="help-inline">${hasErrors(bean: sampleTypeInstance, field: 'sampleTypeName', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: sampleTypeInstance, field: 'sampleTypeDesc', 'error')} ">
                        <label for="sampleTypeDesc" class="control-label"><g:message code="sampleType.sampleTypeDesc.label" default="Sample Type Desc" /></label>
                        <div>
                            <g:textField class="form-control" name="sampleTypeDesc" value="${sampleTypeInstance?.sampleTypeDesc}"/>
                            <span class="help-inline">${hasErrors(bean: sampleTypeInstance, field: 'sampleTypeDesc', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

