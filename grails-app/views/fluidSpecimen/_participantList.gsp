

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'participant', 'error')} required">
                        <label for="participant" class="control-label"><g:message code="fluidSpecimen.participant.label" default="Participant" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="participant" name="participant.id" from="${listParticipantByGeLId}" optionKey="id" required="" value="${fluidSpecimenInstance?.participant?.id}" />
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'participant', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>
