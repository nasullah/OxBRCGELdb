<%@ page import="geldb.Destination" %>



            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: destinationInstance, field: 'companyName', 'error')} ">
                        <label for="companyName" class="control-label"><g:message code="destination.companyName.label" default="Company Name" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="companyName" required="" value="${destinationInstance?.companyName}"/>
                            <span class="help-inline">${hasErrors(bean: destinationInstance, field: 'companyName', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: destinationInstance, field: 'companyAddress', 'error')} ">
                        <label for="companyAddress" class="control-label"><g:message code="destination.companyAddress.label" default="Company Address" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textArea class="form-control" name="companyAddress" cols="40" required="" rows="4" value="${destinationInstance?.companyAddress}"/>
                            <span class="help-inline">${hasErrors(bean: destinationInstance, field: 'companyAddress', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: destinationInstance, field: 'companyPostalCode', 'error')} ">
                        <label for="companyPostalCode" class="control-label"><g:message code="destination.companyPostalCode.label" default="Company Postal Code" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="companyPostalCode" required="" value="${destinationInstance?.companyPostalCode}"/>
                            <span class="help-inline">${hasErrors(bean: destinationInstance, field: 'companyPostalCode', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: destinationInstance, field: 'companyCountry', 'error')} ">
                        <label for="companyCountry" class="control-label"><g:message code="destination.companyCountry.label" default="Company Country" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="companyCountry" required="" value="${destinationInstance?.companyCountry}"/>
                            <span class="help-inline">${hasErrors(bean: destinationInstance, field: 'companyCountry', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

