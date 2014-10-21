<%@ page import="geldb.StaffRole; geldb.UnitType; geldb.FluidSpecimen" %>



            <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'participant', 'error')} required">
                <label for="participant" class="control-label"><g:message code="fluidSpecimen.participant.label" default="Participant" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="participant" name="participant.id" from="${geldb.Participant.list()}" optionKey="id" required="" value="${fluidSpecimenInstance?.participant?.id}" class="many-to-one"/>
                    <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'participant', 'error')}</span>
                </div>
            </div>

			<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'exhausted', 'error')} ">
				<label for="exhausted" class="control-label"><g:message code="fluidSpecimen.exhausted.label" default="Exhausted" /></label>
				<div>
					<bs:checkBox name="exhausted" value="${fluidSpecimenInstance?.exhausted}" />
					<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'exhausted', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'passFail', 'error')} ">
				<label for="passFail" class="control-label"><g:message code="fluidSpecimen.passFail.label" default="Pass Fail" /></label>
				<div>
					<bs:checkBox name="passFail" value="${fluidSpecimenInstance?.passFail}" />
					<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'passFail', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'passFailReason', 'error')} ">
                        <label for="passFailReason" class="control-label"><g:message code="fluidSpecimen.passFailReason.label" default="Pass Fail Reason" /></label>
                        <div>
                            <g:textArea class="form-control" name="passFailReason" cols="40" rows="5" value="${fluidSpecimenInstance?.passFailReason}"/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'passFailReason', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'notes', 'error')} ">
                        <label for="notes" class="control-label"><g:message code="fluidSpecimen.notes.label" default="Notes" /></label>
                        <div>
                            <g:textArea class="form-control" name="notes" cols="40" rows="5" value="${fluidSpecimenInstance?.notes}"/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'notes', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectionDate', 'error')} required">
                        <label for="collectionDate" class="control-label"><g:message code="fluidSpecimen.collectionDate.label" default="Collection Date" /><span class="required-indicator">*</span></label>
                        <div>
                            <bs:datePicker name="collectionDate" precision="day"  value="${fluidSpecimenInstance?.collectionDate}"  />
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectionDate', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectionTime', 'error')} ">
                        <label for="collectionTime" class="control-label"><g:message code="fluidSpecimen.collectionTime.label" default="Collection Time" /></label>
                        <div>
                            <g:textField class="form-control" name="collectionTime" value="${fluidSpecimenInstance?.collectionTime}"/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectionTime', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectionLocation', 'error')} ">
                        <label for="collectionLocation" class="control-label"><g:message code="fluidSpecimen.collectionLocation.label" default="Collection Location" /></label>
                        <div>
                            <g:select class="form-control" id="collectionLocation" name="collectionLocation.id" from="${geldb.Location.list()}" optionKey="id" value="${fluidSpecimenInstance?.collectionLocation?.id}"  noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectionLocation', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectedBy', 'error')} ">
                        <label for="collectedBy" class="control-label"><g:message code="fluidSpecimen.collectedBy.label" default="Collected By" /></label>
                        <div>
                            <g:select class="form-control" id="collectedBy" name="collectedBy.id" from="${geldb.StaffMember.findAllByStaffRoleOrStaffRole(StaffRole.findByRole('Clinician'),StaffRole.findByRole('Biobanker'))}"
                                      optionKey="id" value="${fluidSpecimenInstance?.collectedBy?.id}" noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectedBy', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'preparedBy', 'error')} ">
                        <label for="preparedBy" class="control-label"><g:message code="fluidSpecimen.preparedBy.label" default="Prepared By" /></label>
                        <div>
                            <g:select class="form-control" id="preparedBy" name="preparedBy.id" from="${geldb.StaffMember.findAllByStaffRole(StaffRole.findByRole('Scientist'))}"
                                      optionKey="id" value="${fluidSpecimenInstance?.preparedBy?.id}" noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'preparedBy', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'primaryContainer', 'error')} ">
                        <label for="primaryContainer" class="control-label"><g:message code="fluidSpecimen.primaryContainer.label" default="Primary Container" /></label>
                        <div>
                            <g:select class="form-control" name="primaryContainer" from="${geldb.PrimaryContainerType?.values()}" keys="${geldb.PrimaryContainerType.values()*.name()}" value="${fluidSpecimenInstance?.primaryContainer?.name()}" noSelection="['': '']"/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'primaryContainer', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'fluidSampleType', 'error')} required">
                        <label for="fluidSampleType" class="control-label"><g:message code="fluidSpecimen.fluidSampleType.label" default="Fluid Sample Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" name="fluidSampleType" from="${geldb.FluidSampleType?.values()}" keys="${geldb.FluidSampleType.values()*.name()}" required="" value="${fluidSpecimenInstance?.fluidSampleType?.name()}"/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'fluidSampleType', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'fluidSpecimenVolume', 'error')} required">
                        <label for="fluidSpecimenVolume" class="control-label"><g:message code="fluidSpecimen.fluidSpecimenVolume.label" default="Fluid Specimen Volume" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="fluidSpecimenVolume" value="${fieldValue(bean: fluidSpecimenInstance, field: 'fluidSpecimenVolume')}" required=""/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'fluidSpecimenVolume', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'volumeUnit', 'error')} required">
                        <label for="volumeUnit" class="control-label"><g:message code="fluidSpecimen.volumeUnit.label" default="Volume Unit" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="volumeUnit" name="volumeUnit.id" from="${geldb.Units.findAllByUnitType(UnitType.VolumeUnit)}" optionKey="id" required="" value="${fluidSpecimenInstance?.volumeUnit?.id}" />
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'volumeUnit', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'aliquot', 'error')} ">--}%
				%{--<label for="aliquot" class="control-label"><g:message code="fluidSpecimen.aliquot.label" default="Aliquot" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${fluidSpecimenInstance?.aliquot?}" var="a">--}%
    %{--<li><g:link controller="aliquot" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="aliquot" action="create" params="['fluidSpecimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Aliquot')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'aliquot', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'trackingEvent', 'error')} ">--}%
				%{--<label for="trackingEvent" class="control-label"><g:message code="fluidSpecimen.trackingEvent.label" default="Tracking Event" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${fluidSpecimenInstance?.trackingEvent?}" var="t">--}%
    %{--<li><g:link controller="sampleTrackingEvent" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="sampleTrackingEvent" action="create" params="['fluidSpecimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sampleTrackingEvent.label', default: 'SampleTrackingEvent')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'trackingEvent', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

