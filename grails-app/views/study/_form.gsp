<%@ page import="geldb.Study" %>


            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: studyInstance, field: 'studyName', 'error')} ">
                        <label for="studyName" class="control-label"><g:message code="study.studyName.label" default="Study Name" /></label>
                        <div>
                            <g:textField class="form-control" name="studyName" value="${studyInstance?.studyName}"/>
                            <span class="help-inline">${hasErrors(bean: studyInstance, field: 'studyName', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>
