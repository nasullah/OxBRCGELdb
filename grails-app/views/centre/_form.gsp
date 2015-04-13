<%@ page import="geldb.Centre" %>


            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: centreInstance, field: 'centreName', 'error')} ">
                        <label for="centreName" class="control-label"><g:message code="centre.centreName.label" default="Centre Name" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="centreName" required="" value="${centreInstance?.centreName}"/>
                            <span class="help-inline">${hasErrors(bean: centreInstance, field: 'centreName', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

