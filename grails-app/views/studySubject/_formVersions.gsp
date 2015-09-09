


            <div class="${hasErrors(bean: studySubjectInstance, field: 'consentFormVersion', 'error')} required">
                <label for="consentFormVersion" class="control-label"><g:message code="studySubject.consentFormVersion.label" default="Consent Form Version" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" name="consentFormVersion" from="${listConsentVersionForm}" value="${studySubjectInstance?.consentFormVersion}" valueMessagePrefix="studySubjectInstance.consentFormVersion" />
                    <span class="help-inline">${hasErrors(bean: studySubjectInstance, field: 'consentFormVersion', 'error')}</span>
                </div>
            </div>
