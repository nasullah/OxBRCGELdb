<%@ page import="geldb.TumourLocation" %>


            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: tumourLocationInstance, field: 'tumourLocation', 'error')} ">
                        <label for="tumourLocation" class="control-label"><g:message code="tumourLocation.tumourLocation.label" default="Tumour Location" /></label>
                        <div>
                            <g:textField class="form-control" name="tumourLocation" value="${tumourLocationInstance?.tumourLocation}"/>
                            <span class="help-inline">${hasErrors(bean: tumourLocationInstance, field: 'tumourLocation', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

