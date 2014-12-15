<%@ page import="geldb.UnitType; geldb.Units; geldb.SolidSpecimen" %>

            <hr style="border:1; height:1px" />

            <div class="row">
                <div class="col-lg-6">
                    <div class="input-group">
                        <g:textField type="text" id="search" name="search" class="form-control"  placeholder="Enter participant's GeL Id" required=""></g:textField>
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-success" value="Find" onClick= 'getParticipant()'><span class="glyphicon glyphicon-search"></span> Find Participant</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="${hasErrors(bean: solidSpecimenInstance, field: 'participant', 'error')} required" >
                <label for="participant" class="control-label"><g:message code="solidSpecimen.participant.label" default="Participant" /><span class="required-indicator">*</span></label>
                <div id="selectParticipant">
                    <g:select class="" name="1" from="${''}" optionKey="" value="${''}" required=""/>
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
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'collectionMethod', 'error')} required">
                        <label for="collectionMethod" class="control-label"><g:message code="solidSpecimen.collectionMethod.label" default="Collection Method" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="collectionMethod" name="collectionMethod.id" from="${geldb.CollectionMethod.list()}" optionKey="id" required="" value="${solidSpecimenInstance?.collectionMethod?.id}" />
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'collectionMethod', 'error')}</span>
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
                            <g:select class="form-control" id="collectionLocation" name="collectionLocation.id" from="${geldb.Location.list()}" optionKey="id" value="${solidSpecimenInstance?.collectionLocation?.id}" noSelection="['':'- Choose Location -']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'collectionLocation', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'collectedBy', 'error')} ">
                        <label for="collectedBy" class="control-label"><g:message code="solidSpecimen.collectedBy.label" default="Collected By" /></label>
                        <div>
                            <g:select class="form-control" id="collectedBy" name="collectedBy.id" from="${geldb.StaffMember.findAllByStaffRole('Biobanker')}" optionKey="id" value="${solidSpecimenInstance?.collectedBy?.id}" noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'collectedBy', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'preparedBy', 'error')} ">
                        <label for="preparedBy" class="control-label"><g:message code="solidSpecimen.preparedBy.label" default="Prepared By" /></label>
                        <div>
                            <g:select class="form-control" id="preparedBy" name="preparedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${solidSpecimenInstance?.preparedBy?.id}" noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'preparedBy', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'surgeon', 'error')} ">
                        <label for="surgeon" class="control-label"><g:message code="solidSpecimen.surgeon.label" default="Surgeon" /></label>
                        <div>
                            <g:select class="form-control" id="surgeon" name="surgeon.id" from="${geldb.StaffMember.findAllByStaffRole('Surgeon')}" optionKey="id" value="${solidSpecimenInstance?.surgeon?.id}"  noSelection="['':'- Choose Surgeon -']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'surgeon', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'pathologist', 'error')} ">
                        <label for="pathologist" class="control-label"><g:message code="solidSpecimen.pathologist.label" default="Pathologist" /></label>
                        <div>
                            <g:select class="form-control" id="pathologist" name="pathologist.id" from="${geldb.StaffMember.findAllByStaffRole('Pathologist')}"
                                      optionKey="id" value="${solidSpecimenInstance?.pathologist?.id}"  noSelection="['':'- Choose Pathologist -']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'pathologist', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'methodOfTransportToPathologist', 'error')} ">
                        <label for="methodOfTransportToPathologist" class="control-label"><g:message code="solidSpecimen.methodOfTransportToPathologist.label" default="Method of Transport to Pathologist" /></label>
                        <div>
                            <g:select class="form-control" id="methodOfTransportToPathologist" name="methodOfTransportToPathologist.id" from="${geldb.MethodOfTransport.list()}" optionKey="id" value="${solidSpecimenInstance?.methodOfTransportToPathologist?.id}"  noSelection="['':'- Choose Method of Transport -']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'methodOfTransportToPathologist', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'anatomicalSite', 'error')} ">
                        <label for="anatomicalSite" class="control-label"><g:message code="solidSpecimen.anatomicalSite.label" default="Anatomical Site" /></label>
                        <div>
                            <g:select class="form-control" id="anatomicalSite" name="anatomicalSite.id" from="${geldb.AnatomicalSite.list()}" optionKey="id" value="${solidSpecimenInstance?.anatomicalSite?.id}" noSelection="['':'- Choose Anatomical Site -']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'anatomicalSite', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenInstance, field: 'barcode', 'error')} ">
                        <label for="barcode" class="control-label"><g:message code="solidSpecimen.barcode.label" default="Barcode" /></label>
                        <div>
                            <g:textField class="form-control" name="barcode" value="${solidSpecimenInstance?.barcode}"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'barcode', 'error')}</span>
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

            <div class="modal fade" id="notFound">
                <div class="modal-dialog" style="position: absolute; left: 0%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">Not Found!</h4>
                        </div>
                        <div class="modal-body" onfocus='dialogBody()'>
                            <p>No participant found with the Gel Id you entered</p>
                        </div>
                        <div class="modal-footer">
                            <a class='btn btn-primary btn-small' <g:link controller="participant" action="create" ><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'participant.label', default: 'Participant')])}</g:link>
                            <button type="button" class="btn" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function getParticipant(){
        ${remoteFunction (controller: 'solidSpecimen',
                        action: 'findParticipantByGeLId',
                        params: '"search=" + $("#search").val()',
                        update: 'selectParticipant',
                        onFailure: 'error()'
                )}
    }

    function error(){
        var select = $("#selectParticipant");
        select.empty().append("Not found");
        $('#notFound').modal()
    }
</script>

