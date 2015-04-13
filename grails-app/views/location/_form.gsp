<%@ page import="geldb.Location" %>


        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: locationInstance, field: 'centre', 'error')} required">
                    <label for="centre" class="control-label"><g:message code="location.centre.label" default="Centre" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" id="centre" name="centre.id" from="${geldb.Centre.list()}" optionKey="id" required="" value="${locationInstance?.centre?.id}" />
                        <span class="help-inline">${hasErrors(bean: locationInstance, field: 'centre', 'error')}</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: locationInstance, field: 'locationName', 'error')} ">
                    <label for="locationName" class="control-label"><g:message code="location.locationName.label" default="Location Name" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:textField class="form-control" name="locationName" required="" value="${locationInstance?.locationName}"/>
                        <span class="help-inline">${hasErrors(bean: locationInstance, field: 'locationName', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: locationInstance, field: 'locationDescription', 'error')} ">
                    <label for="locationDescription" class="control-label"><g:message code="location.locationDescription.label" default="Location Description" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:textField class="form-control" name="locationDescription" required="" value="${locationInstance?.locationDescription}"/>
                        <span class="help-inline">${hasErrors(bean: locationInstance, field: 'locationDescription', 'error')}</span>
                    </div>
                </div>
            </div>
        </div>

