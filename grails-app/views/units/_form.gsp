<%@ page import="geldb.Units" %>


            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: unitsInstance, field: 'unitType', 'error')} required">
                        <label for="unitType" class="control-label"><g:message code="units.unitType.label" default="Unit Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" name="unitType" from="${geldb.UnitType?.values()}" keys="${geldb.UnitType.values()*.name()}" required="" value="${unitsInstance?.unitType?.name()}"/>
                            <span class="help-inline">${hasErrors(bean: unitsInstance, field: 'unitType', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: unitsInstance, field: 'unitName', 'error')} ">
                        <label for="unitName" class="control-label"><g:message code="units.unitName.label" default="Unit Name" /></label>
                        <div>
                            <g:textField class="form-control" name="unitName" value="${unitsInstance?.unitName}"/>
                            <span class="help-inline">${hasErrors(bean: unitsInstance, field: 'unitName', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: unitsInstance, field: 'unitDescription', 'error')} ">
                        <label for="unitDescription" class="control-label"><g:message code="units.unitDescription.label" default="Unit Description" /></label>
                        <div>
                            <g:textField class="form-control" name="unitDescription" value="${unitsInstance?.unitDescription}"/>
                            <span class="help-inline">${hasErrors(bean: unitsInstance, field: 'unitDescription', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>


