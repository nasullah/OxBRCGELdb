<%@ page import="geldb.UnitType; geldb.FluidSpecimen" %>

            <g:if test="${fluidSpecimenInstance?.participant?.id == null}">
                <hr style="border:1; height:1px" />
                <div class="row">
                    <div class="col-lg-6">
                        <div class="input-group">
                            <g:textField type="text" id="search" name="search" class="form-control"  placeholder="GEL000" required="" ></g:textField>
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-success" value="Find" onClick= 'getParticipant()'><span class="glyphicon glyphicon-search"></span> Find Participant</button>
                            </div>
                        </div>
                    </div>
                </div>
                <p>
                <div id="selectParticipant"></div>
            </g:if>

            <g:if test="${fluidSpecimenInstance?.participant?.id != null}">
                %{--<div class="row">--}%
                    %{--<div class="col-lg-6">--}%
                        %{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'participant', 'error')} required">--}%
                            %{--<label for="participant" class="control-label"><g:message code="fluidSpecimen.participant.label" default="Participant" /><span class="required-indicator">*</span></label>--}%
                            %{--<div>--}%
                                %{--<g:select class="form-control" id="participant" name="participant.id" from="${geldb.Participant.list()}" optionKey="id" required="" value="${fluidSpecimenInstance?.participant?.id}" class="many-to-one" />--}%
                                %{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'participant', 'error')}</span>--}%
                            %{--</div>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%
                <p><b>Participant- ${fluidSpecimenInstance?.participant}</b></p>
                <g:hiddenField name="participant.id" id="participant" value="${fluidSpecimenInstance?.participant?.id}"/>
            </g:if>

            <div class="row">
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
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'primaryContainer', 'error')} ">
                        <label for="primaryContainer" class="control-label"><g:message code="fluidSpecimen.primaryContainer.label" default="Primary Container" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" name="primaryContainer" from="${geldb.PrimaryContainerType?.values()}" keys="${geldb.PrimaryContainerType.values()*.name()}" value="${fluidSpecimenInstance?.primaryContainer?.name()}" required="" noSelection="['':'- Choose -']" />
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'primaryContainer', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'barcode', 'error')} ">
                        <label for="barcode" class="control-label"><g:message code="fluidSpecimen.barcode.label" default="Barcode (where available)" /></label>
                        <div>
                            <g:textField class="form-control" name="barcode" value="${fluidSpecimenInstance?.barcode}"/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'barcode', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'timePoint', 'error')} ">
                        <label for="timePoint" class="control-label"><g:message code="fluidSpecimen.gender.label" default="Time Point" /></label>
                        <div>
                            <g:select class="form-control" name="timePoint" from="${fluidSpecimenInstance.constraints.timePoint.inList}" value="${fluidSpecimenInstance?.timePoint}" valueMessagePrefix="fluidSpecimen.timePoint"  noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'timePoint', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'exhausted', 'error')} ">
                        <label for="exhausted" class="control-label"><g:message code="fluidSpecimen.exhausted.label" default="Exhausted" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:radioGroup name="exhausted"
                                          values="[true, false, '']"
                                          labels="['Yes', 'No', 'Not completed']"
                                          value="${fluidSpecimenInstance?.exhausted}">
                                ${it.label}  ${it.radio}
                            </g:radioGroup>
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

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'passFail', 'error')} ">--}%
				%{--<label for="passFail" class="control-label"><g:message code="fluidSpecimen.passFail.label" default="Pass/Fail" /></label>--}%
				%{--<div>--}%
					%{--<bs:checkBox name="passFail" value="${fluidSpecimenInstance?.passFail}" offLabel="Fail" onLabel="Pass" />--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'passFail', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

                %{--<div class="col-lg-6">--}%
                    %{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'passFailReason', 'error')} ">--}%
                        %{--<label for="passFailReason" class="control-label"><g:message code="fluidSpecimen.passFailReason.label" default="Pass Fail Reason" /></label>--}%
                        %{--<div>--}%
                            %{--<g:textArea class="form-control" name="passFailReason" cols="40" rows="5" value="${fluidSpecimenInstance?.passFailReason}"/>--}%
                            %{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'passFailReason', 'error')}</span>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%


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
                        <label for="collectionTime" class="control-label"><g:message code="fluidSpecimen.collectionTime.label" default="Collection Time (if known)" /></label>
                        <div>
                            <g:field type="time" class="form-control" name="collectionTime" value="${fluidSpecimenInstance?.collectionTime}"/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectionTime', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectionLocation', 'error')} ">
                        <label for="collectionLocation" class="control-label"><g:message code="fluidSpecimen.collectionLocation.label" default="Collection Location" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="collectionLocation" name="collectionLocation.id" from="${geldb.Location.list().sort {it.locationName}}" optionKey="id" value="${fluidSpecimenInstance?.collectionLocation?.id}" required="" noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectionLocation', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectedBy', 'error')} ">
                        <label for="collectedBy" class="control-label"><g:message code="fluidSpecimen.collectedBy.label" default="Collected By" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="collectedBy" name="collectedBy.id" from="${geldb.StaffMember.findAllByStaffRole('Other').sort {it.staffName}}"
                                      optionKey="id" value="${fluidSpecimenInstance?.collectedBy?.id}" required="" noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectedBy', 'error')}</span>
                        </div>
                    </div>
                </div>

                %{--<div class="col-lg-6">--}%
                    %{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'preparedBy', 'error')} ">--}%
                        %{--<label for="preparedBy" class="control-label"><g:message code="fluidSpecimen.preparedBy.label" default="Prepared By" /></label>--}%
                        %{--<div>--}%
                            %{--<g:select class="form-control" id="preparedBy" name="preparedBy.id" from="${geldb.StaffMember.findAllByStaffRole('Scientist/Lab Technician').sort()}"--}%
                                      %{--optionKey="id" value="${fluidSpecimenInstance?.preparedBy?.id}" noSelection="['null': '']"/>--}%
                            %{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'preparedBy', 'error')}</span>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%
            </div>

            <div class="row">
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
                            <g:select class="form-control" id="volumeUnit" name="volumeUnit.id" from="${geldb.Units.findAllByUnitType(UnitType.VolumeUnit).sort {it.unitName}}" optionKey="id" required="" value="${fluidSpecimenInstance?.volumeUnit?.id}" />
                            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'volumeUnit', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="notFound">
                <div class="modal-dialog" style="position: absolute; left: 0%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">Not Found!</h4>
                        </div>
                        <div class="modal-body">
                            <p>No participant found with the Gel Id you entered</p>
                        </div>
                        <div class="modal-footer">
                            <a class='btn btn-success btn-small' href="/GELdb/importparticipant"><span class="glyphicon glyphicon-import"></span> Import Participant</a>
                            <a class='btn btn-primary btn-small' <g:link controller="participant" action="create" ><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'participant.label', default: 'Participant')])}</g:link>
                            <button type="button" class="btn" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function getParticipant(){
        ${remoteFunction (controller: 'fluidSpecimen',
                        action: 'findParticipantByGeLId',
                        params: '"search=" + $("#search").val()',
                        update: 'selectParticipant',
                        onFailure:'error()'
                )}
    }

    function error(){
        var select = $("#selectParticipant");
        select.empty().append("Not found");
        $('#notFound').modal()
    }
</script>
