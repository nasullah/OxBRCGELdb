<%@ page import="geldb.StudyIdentifier" %>



			<div class="${hasErrors(bean: studyIdentifierInstance, field: 'study', 'error')} required">
				<label for="study" class="control-label"><g:message code="studyIdentifier.study.label" default="Study" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="study" name="study.id" from="${geldb.Study.list()}" optionKey="id" required="" value="${studyIdentifierInstance?.study?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: studyIdentifierInstance, field: 'study', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: studyIdentifierInstance, field: 'studyIdentifier', 'error')} ">
                        <label for="studyIdentifier" class="control-label"><g:message code="studyIdentifier.studyIdentifier.label" default="Study Identifier" /></label>
                        <div>
                            <g:textField class="form-control" name="studyIdentifier" value="${studyIdentifierInstance?.studyIdentifier}"/>
                            <span class="help-inline">${hasErrors(bean: studyIdentifierInstance, field: 'studyIdentifier', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

