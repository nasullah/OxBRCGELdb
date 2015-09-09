



            <div class="${hasErrors(bean: participantInstance, field: 'diagnosis', 'error')} required">
                <label for="diagnosis" class="control-label"><g:message code="participant.diagnosis.label" default="Diagnosis" /></label>
                <div>
                    <g:select class="form-control" id="diagnosis" name="diagnosis.id" size="7" from="${listICD10}" optionKey="id" required="" value="${participantInstance?.diagnosis?.id}"/>
                    <span class="help-inline">${hasErrors(bean: participantInstance, field: 'diagnosis', 'error')}</span>
                </div>
            </div>
