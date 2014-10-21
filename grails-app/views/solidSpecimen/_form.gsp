<%@ page import="geldb.StaffRole; geldb.UnitType; geldb.Units; geldb.SolidSpecimen" %>



            <div class="${hasErrors(bean: solidSpecimenInstance, field: 'participant', 'error')} required">
                <label for="participant" class="control-label"><g:message code="solidSpecimen.participant.label" default="Participant" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="participant" name="participant.id" from="${geldb.Participant.list()}" optionKey="id" required="" value="${solidSpecimenInstance?.participant?.id}" class="many-to-one"/>
                    <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'participant', 'error')}</span>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'histologyNumber', 'error')} ">
                        <label for="histologyNumber" class="control-label"><g:message code="solidSpecimen.histologyNumber.label" default="Histology Number" /></label>
                        <div>
                            <g:textField class="form-control" name="histologyNumber" value="${solidSpecimenInstance?.histologyNumber}"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'histologyNumber', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'sampleType', 'error')} required">
                        <label for="sampleType" class="control-label"><g:message code="solidSpecimen.sampleType.label" default="Sample Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="sampleType" name="sampleType.id" from="${geldb.CollectionMethod.list()}" optionKey="id" required="" value="${solidSpecimenInstance?.sampleType?.id}" />
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'sampleType', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'tumourType', 'error')} required">
                        <label for="tumourType" class="control-label"><g:message code="solidSpecimen.tumourType.label" default="Tumour Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="tumourType" name="tumourType.id" from="${geldb.TumourType.list()}" optionKey="id" required="" value="${solidSpecimenInstance?.tumourType?.id}"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'tumourType', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="${hasErrors(bean: solidSpecimenInstance, field: 'exhausted', 'error')} ">
                <label for="exhausted" class="control-label"><g:message code="solidSpecimen.exhausted.label" default="Exhausted" /></label>
                <div>
                    <bs:checkBox name="exhausted" value="${solidSpecimenInstance?.exhausted}" />
                    <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'exhausted', 'error')}</span>
                </div>
            </div>

            <div class="${hasErrors(bean: solidSpecimenInstance, field: 'passFail', 'error')} ">
                <label for="passFail" class="control-label"><g:message code="solidSpecimen.passFail.label" default="Pass Fail" /></label>
                <div>
                    <bs:checkBox name="passFail" value="${solidSpecimenInstance?.passFail}" />
                    <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'passFail', 'error')}</span>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'passFailReason', 'error')} ">
                        <label for="passFailReason" class="control-label"><g:message code="solidSpecimen.passFailReason.label" default="Pass Fail Reason" /></label>
                        <div>
                            <g:textArea class="form-control" name="passFailReason" cols="40" rows="5" value="${solidSpecimenInstance?.passFailReason}"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'passFailReason', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'notes', 'error')} ">
                        <label for="notes" class="control-label"><g:message code="solidSpecimen.notes.label" default="Notes" /></label>
                        <div>
                            <g:textArea class="form-control" name="notes" cols="40" rows="5" value="${solidSpecimenInstance?.notes}"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'notes', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'collectionDate', 'error')} required">
                        <label for="collectionDate" class="control-label"><g:message code="solidSpecimen.collectionDate.label" default="Collection Date" /><span class="required-indicator">*</span></label>
                        <div>
                            <bs:datePicker name="collectionDate" precision="day"  value="${solidSpecimenInstance?.collectionDate}"  />
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'collectionDate', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'collectionTime', 'error')} ">
                        <label for="collectionTime" class="control-label"><g:message code="solidSpecimen.collectionTime.label" default="Collection Time" /></label>
                        <div>
                            <g:textField class="form-control" name="collectionTime" value="${solidSpecimenInstance?.collectionTime}"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'collectionTime', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'collectionLocation', 'error')} ">
                        <label for="collectionLocation" class="control-label"><g:message code="solidSpecimen.collectionLocation.label" default="Collection Location" /></label>
                        <div>
                            <g:select class="form-control" id="collectionLocation" name="collectionLocation.id" from="${geldb.Location.list()}" optionKey="id" value="${solidSpecimenInstance?.collectionLocation?.id}" noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'collectionLocation', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'collectedBy', 'error')} ">
                        <label for="collectedBy" class="control-label"><g:message code="solidSpecimen.collectedBy.label" default="Collected By" /></label>
                        <div>
                            <g:select class="form-control" id="collectedBy" name="collectedBy.id" from="${geldb.StaffMember.findAllByStaffRole(StaffRole.findByRole('Biobanker'))}" optionKey="id" value="${solidSpecimenInstance?.collectedBy?.id}" noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'collectedBy', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'preparedBy', 'error')} ">
                        <label for="preparedBy" class="control-label"><g:message code="solidSpecimen.preparedBy.label" default="Prepared By" /></label>
                        <div>
                            <g:select class="form-control" id="preparedBy" name="preparedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${solidSpecimenInstance?.preparedBy?.id}" noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'preparedBy', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'surgeon', 'error')} ">
                        <label for="surgeon" class="control-label"><g:message code="solidSpecimen.surgeon.label" default="Surgeon" /></label>
                        <div>
                            <g:select class="form-control" id="surgeon" name="surgeon.id" from="${geldb.StaffMember.findAllByStaffRole(StaffRole.findByRole('Surgeon'))}" optionKey="id" value="${solidSpecimenInstance?.surgeon?.id}"  noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'surgeon', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'pathologist', 'error')} ">
                        <label for="pathologist" class="control-label"><g:message code="solidSpecimen.pathologist.label" default="Pathologist" /></label>
                        <div>
                            <g:select class="form-control" id="pathologist" name="pathologist.id" from="${geldb.StaffMember.findAllByStaffRole(StaffRole.findByRole('Pathologist'))}"
                                      optionKey="id" value="${solidSpecimenInstance?.pathologist?.id}"  noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'pathologist', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'methodOfTransportToPathologist', 'error')} ">
                        <label for="methodOfTransportToPathologist" class="control-label"><g:message code="solidSpecimen.methodOfTransportToPathologist.label" default="Method Of Transport To Pathologist" /></label>
                        <div>
                            <g:select class="form-control" id="methodOfTransportToPathologist" name="methodOfTransportToPathologist.id" from="${geldb.MethodOfTransport.list()}" optionKey="id" value="${solidSpecimenInstance?.methodOfTransportToPathologist?.id}"  noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'methodOfTransportToPathologist', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'anatomicalSite', 'error')} ">
                        <label for="anatomicalSite" class="control-label"><g:message code="solidSpecimen.anatomicalSite.label" default="Anatomical Site" /></label>
                        <div>
                            <g:select class="form-control" id="anatomicalSite" name="anatomicalSite.id" from="${geldb.AnatomicalSite.list()}" optionKey="id" value="${solidSpecimenInstance?.anatomicalSite?.id}" noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'anatomicalSite', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'specimenWeight', 'error')} ">
                        <label for="specimenWeight" class="control-label"><g:message code="solidSpecimen.specimenWeight.label" default="Specimen Weight" /></label>
                        <div>
                            <g:field class="form-control" name="specimenWeight" value="${fieldValue(bean: solidSpecimenInstance, field: 'specimenWeight')}"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'specimenWeight', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'massUnit', 'error')} ">
                        <label for="massUnit" class="control-label"><g:message code="solidSpecimen.massUnit.label" default="Mass Unit" /></label>
                        <div>
                            <g:select class="form-control" id="massUnit" name="massUnit.id" from="${geldb.Units.findAllByUnitType(UnitType.MassUnit)}"
                                      optionKey="id" value="${solidSpecimenInstance?.massUnit?.id}"  noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'massUnit', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            %{--<div class="${hasErrors(bean: solidSpecimenInstance, field: 'aliquot', 'error')} ">--}%
            %{--<label for="aliquot" class="control-label"><g:message code="solidSpecimen.aliquot.label" default="Aliquot" /></label>--}%
            %{--<div>--}%
            %{----}%
            %{--<ul class="one-to-many">--}%
            %{--<g:each in="${solidSpecimenInstance?.aliquot?}" var="a">--}%
            %{--<li><g:link controller="aliquot" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>--}%
            %{--</g:each>--}%
            %{--<li class="add">--}%
            %{--<g:link controller="aliquot" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Aliquot')])}</g:link>--}%
            %{--</li>--}%
            %{--</ul>--}%

            %{--<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'aliquot', 'error')}</span>--}%
            %{--</div>--}%
            %{--</div>--}%

            %{--<div class="${hasErrors(bean: solidSpecimenInstance, field: 'fixationReport', 'error')} ">--}%
            %{--<label for="fixationReport" class="control-label"><g:message code="solidSpecimen.fixationReport.label" default="Fixation Report" /></label>--}%
            %{--<div>--}%
            %{----}%
            %{--<ul class="one-to-many">--}%
            %{--<g:each in="${solidSpecimenInstance?.fixationReport?}" var="f">--}%
            %{--<li><g:link controller="fixationReport" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>--}%
            %{--</g:each>--}%
            %{--<li class="add">--}%
            %{--<g:link controller="fixationReport" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'fixationReport.label', default: 'FixationReport')])}</g:link>--}%
            %{--</li>--}%
            %{--</ul>--}%

            %{--<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'fixationReport', 'error')}</span>--}%
            %{--</div>--}%
            %{--</div>--}%

            %{--<div class="${hasErrors(bean: solidSpecimenInstance, field: 'solidSpecimenReport', 'error')} ">--}%
            %{--<label for="solidSpecimenReport" class="control-label"><g:message code="solidSpecimen.solidSpecimenReport.label" default="Solid Specimen Report" /></label>--}%
            %{--<div>--}%
            %{----}%
            %{--<ul class="one-to-many">--}%
            %{--<g:each in="${solidSpecimenInstance?.solidSpecimenReport?}" var="s">--}%
            %{--<li><g:link controller="solidSpecimenReport" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>--}%
            %{--</g:each>--}%
            %{--<li class="add">--}%
            %{--<g:link controller="solidSpecimenReport" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'solidSpecimenReport.label', default: 'SolidSpecimenReport')])}</g:link>--}%
            %{--</li>--}%
            %{--</ul>--}%

            %{--<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'solidSpecimenReport', 'error')}</span>--}%
            %{--</div>--}%
            %{--</div>--}%

            %{--<div class="${hasErrors(bean: solidSpecimenInstance, field: 'trackingEvent', 'error')} ">--}%
            %{--<label for="trackingEvent" class="control-label"><g:message code="solidSpecimen.trackingEvent.label" default="Tracking Event" /></label>--}%
            %{--<div>--}%
            %{----}%
            %{--<ul class="one-to-many">--}%
            %{--<g:each in="${solidSpecimenInstance?.trackingEvent?}" var="t">--}%
            %{--<li><g:link controller="sampleTrackingEvent" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>--}%
            %{--</g:each>--}%
            %{--<li class="add">--}%
            %{--<g:link controller="sampleTrackingEvent" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sampleTrackingEvent.label', default: 'SampleTrackingEvent')])}</g:link>--}%
            %{--</li>--}%
            %{--</ul>--}%

            %{--<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'trackingEvent', 'error')}</span>--}%
            %{--</div>--}%
            %{--</div>--}%
