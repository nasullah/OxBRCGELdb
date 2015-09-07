<%@ page import="geldb.UnitType; geldb.FluidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Create Multiple Fluid Specimen</title>
</head>

<body>

<section id="create-fluidSpecimen" class="first">

    <g:hasErrors bean="${fluidSpecimenInstance}">
        <div class="alert alert-danger">
            <g:renderErrors bean="${fluidSpecimenInstance}" as="list" />
        </div>
    </g:hasErrors>

    <g:form action="saveMultiple" class="form-horizontal" role="form" >

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

        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'fluidSampleType', 'error')} required">
                    <label for="fluidSampleType" class="control-label"><g:message code="fluidSpecimen.fluidSampleType.label" default="Fluid Sample Type" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" name="fluidSampleType" from="${geldb.FluidSampleType?.values()?.sort()}" keys="${geldb.FluidSampleType.values()*.name()}" required="" value="${fluidSpecimenInstance?.fluidSampleType?.name()}"/>
                        <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'fluidSampleType', 'error')}</span>
                    </div>
                </div>
            </div>
        </div>

        <p></p>

        <label class="control-label">Primary Container<span class="required-indicator">*</span></label>

        <hr style="border:1; height:1px" />

        <g:each var="primaryContainer" in="${geldb.PrimaryContainerType?.values()}" status="i">
            <div class="row">
                <div class="col-lg-12">
                    <label class="control-label">${primaryContainer}</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <input type="checkbox" name="primaryContainer_${i}" value="${geldb.PrimaryContainerType?.values()[i].name()}"/>
                        </span>
                        <label class="control-label">Barcode</label>
                        <g:field type="text" class="form-control" name="barcode_${i}" placeholder="Barcode"/>
                        <span class="input-group-addon">
                        </span>
                        <label class="control-label">Volume</label>
                        <g:field type="number decimal" class="form-control" name="fluidSpecimenVolume_${i}" placeholder="Fluid Specimen Volume"/>
                    </div>
                </div>
            </div>
        </g:each>

        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'volumeUnit', 'error')} required">
                    <label for="volumeUnit" class="control-label"><g:message code="fluidSpecimen.volumeUnit.label" default="Volume Unit" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" id="volumeUnit" name="volumeUnit.id" from="${geldb.Units.findAllByUnitType(UnitType.VolumeUnit).sort()}" optionKey="id" required="" value="${fluidSpecimenInstance?.volumeUnit?.id}" />
                        <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'volumeUnit', 'error')}</span>
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
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'notes', 'error')} ">
                    <label for="notes" class="control-label"><g:message code="fluidSpecimen.notes.label" default="Notes" /></label>
                    <div>
                        <g:textArea class="form-control" name="notes" cols="40" rows="4" value="${fluidSpecimenInstance?.notes}"/>
                        <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'notes', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectionLocation', 'error')} ">
                    <label for="collectionLocation" class="control-label"><g:message code="fluidSpecimen.collectionLocation.label" default="Collection Location" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" id="collectionLocation" name="collectionLocation.id" from="${geldb.Location.list().sort()}" optionKey="id" value="${fluidSpecimenInstance?.collectionLocation?.id}" required="" noSelection="['':'- Choose -']"/>
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

        <div class="form-actions margin-top-medium">
            <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'save', default: 'Save')}" />
            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
        </div>
    </g:form>

</section>
<hr style="border:1; height:1px" />

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

</body>

</html>