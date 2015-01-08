<%@ page import="geldb.MethodOfTransport" %>



            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: methodOfTransportInstance, field: 'methodOfTransportName', 'error')} ">
                        <label for="methodOfTransportName" class="control-label"><g:message code="methodOfTransport.methodOfTransportName.label" default="Method Of Transport Name" /></label>
                        <div>
                            <g:textField class="form-control" name="methodOfTransportName" value="${methodOfTransportInstance?.methodOfTransportName}"/>
                            <span class="help-inline">${hasErrors(bean: methodOfTransportInstance, field: 'methodOfTransportName', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: methodOfTransportInstance, field: 'methodOfTransportDescription', 'error')} ">
                        <label for="methodOfTransportDescription" class="control-label"><g:message code="methodOfTransport.methodOfTransportDescription.label" default="Method Of Transport Description" /></label>
                        <div>
                            <g:textField class="form-control" name="methodOfTransportDescription" value="${methodOfTransportInstance?.methodOfTransportDescription}"/>
                            <span class="help-inline">${hasErrors(bean: methodOfTransportInstance, field: 'methodOfTransportDescription', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

