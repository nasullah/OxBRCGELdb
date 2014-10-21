<%@ page import="geldb.StaffRole; geldb.StudySubject" %>



			<div class="${hasErrors(bean: studySubjectInstance, field: 'participant', 'error')} required">
				<label for="participant" class="control-label"><g:message code="studySubject.participant.label" default="Participant" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="participant" name="participant.id" from="${geldb.Participant.list()}" optionKey="id" required="" value="${studySubjectInstance?.participant?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'participant', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: studySubjectInstance, field: 'study', 'error')} required">
                        <label for="study" class="control-label"><g:message code="studySubject.study.label" default="Study" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="study" name="study.id" from="${geldb.Study.list()}" optionKey="id" required="" value="${studySubjectInstance?.study?.id}" />
                            <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'study', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: studySubjectInstance, field: 'studySubjectIdentifier', 'error')} required">
                        <label for="studySubjectIdentifier" class="control-label"><g:message code="studySubject.studySubjectIdentifier.label" default="Study Subject Identifier" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="studySubjectIdentifier" maxlength="50" required="" value="${studySubjectInstance?.studySubjectIdentifier}"/>
                            <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'studySubjectIdentifier', 'error')}</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: studySubjectInstance, field: 'consentFormVersion', 'error')} required">
                        <label for="consentFormVersion" class="control-label"><g:message code="studySubject.consentFormVersion.label" default="Consent Form Version" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" name="consentFormVersion" from="${studySubjectInstance.constraints.consentFormVersion.inList}" value="${studySubjectInstance?.consentFormVersion}" valueMessagePrefix="studySubjectInstance.consentFormVersion" />
                            <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'consentFormVersion', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			<div class="${hasErrors(bean: studySubjectInstance, field: 'consentStatus', 'error')} ">
				<label for="consentStatus" class="control-label"><g:message code="studySubject.consentStatus.label" default="Consent Status" /></label>
				<div>
					<bs:checkBox name="consentStatus" value="${studySubjectInstance?.consentStatus}" />
					<span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'consentStatus', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: studySubjectInstance, field: 'recruitmentDate', 'error')} required">
                        <label for="recruitmentDate" class="control-label"><g:message code="studySubject.recruitmentDate.label" default="Recruitment Date" /><span class="required-indicator">*</span></label>
                        <div>
                            <bs:datePicker name="recruitmentDate" precision="day"  value="${studySubjectInstance?.recruitmentDate}"  />
                            <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'recruitmentDate', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: studySubjectInstance, field: 'recruitedBy', 'error')} ">
                        <label for="recruitedBy" class="control-label"><g:message code="studySubject.recruitedBy.label" default="Recruited By" /></label>
                        <div>
                            <g:select class="form-control" id="recruitedBy" name="recruitedBy.id" from="${geldb.StaffMember.list()}"
                                      optionKey="id" value="${studySubjectInstance?.recruitedBy?.id}"  noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'recruitedBy', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>



