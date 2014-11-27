<%@ page import="geldb.Period" %>


            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: periodInstance, field: 'period', 'error')} ">
                        <label for="period" class="control-label"><g:message code="period.period.label" default="Period" /></label>
                        <div>
                            <g:textField class="form-control" name="period" value="${periodInstance?.period}"/>
                            <span class="help-inline">${hasErrors(bean: periodInstance, field: 'period', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>


