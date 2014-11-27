<div>
    <g:select class="form-control" id="participant" name="participant.id" from="${listParticipantByGeLId}" optionKey="id" required="" value="${solidSpecimenInstance?.participant?.id}" class="many-to-one"/>
    <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'participant', 'error')}</span>
</div>