<%@ page import="geldb.UnitType; geldb.Aliquot" %>


<hr style="border:1; height:1px" />

<g:if test="${aliquotInstance?.derivedFrom?.id != null}">

    <div class="${hasErrors(bean: derivationInstance, field: 'aliquot', 'error')} ">
        <label for="aliquot" class="control-label"><g:message code="derivation.aliquot.label" default="Parent Aliquot" /><span class="required-indicator">*</span></label>
        <div>
            <g:select class="form-control" id="aliquot" name="aliquot.id" from="${geldb.Aliquot.list()}" optionKey="id"  value="${aliquotInstance?.derivedFrom?.aliquot?.id}" required="" class="many-to-one"/>
            <span class="help-inline">${hasErrors(bean: derivationInstance, field: 'aliquot', 'error')}</span>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: derivationInstance, field: 'derivationProcess', 'error')} required">
                <label for="derivationProcess" class="control-label"><g:message code="derivation.derivationProcess.label" default="Derivation Process" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" name="derivationProcess" from="${geldb.DerivationType?.values()}" keys="${geldb.DerivationType.values()*.name()}" required="" value="${aliquotInstance?.derivedFrom?.derivationProcess?.name()}" onchange="getSlidId()" noSelection="['':'- Choose -']"/>
                    <span class="help-inline">${hasErrors(bean: derivationInstance, field: 'derivationProcess', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotType', 'error')} required">
                <label for="aliquotType" class="control-label"><g:message code="aliquot.aliquotType.label" default="Aliquot Type" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="aliquotType" name="aliquotType.id" from="${geldb.AliquotType.list().sort{it.aliquotTypeName}}" optionKey="id" required="" value="${aliquotInstance?.aliquotType?.id}" noSelection="['':'- Choose -']" onchange="preFillCreatedOnFFAliquot()"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotType', 'error')}</span>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: derivationInstance, field: 'derivationDate', 'error')} required">
                <label for="derivationDate" class="control-label"><g:message code="derivation.derivationDate.label" default="Derivation Date" /><span class="required-indicator">*</span></label>
                <div>
                    <bs:datePicker name="derivationDate" precision="day"  value="${aliquotInstance?.derivedFrom?.derivationDate}"  />
                    <span class="help-inline">${hasErrors(bean: derivationInstance, field: 'derivationDate', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: derivationInstance, field: 'derivedBy', 'error')} required">
                <label for="derivedBy" class="control-label"><g:message code="derivation.derivedBy.label" default="Derived By" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="derivedBy" name="derivedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" required="" value="${aliquotInstance?.derivedFrom?.derivedBy?.id}" noSelection="['':'- Choose -']" />
                    <span class="help-inline">${hasErrors(bean: derivationInstance, field: 'derivedBy', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'sapphireIdentifier', 'error')} ">
                <g:if test="${aliquotInstance?.derivedFrom?.derivationProcess?.name() =='Tissue_disruption' || aliquotInstance?.derivedFrom?.derivationProcess?.name() =='Tissue_disruption_centrifugation_with_buffer'}">
                    <label for="sapphireIdentifier" class="control-label">Identifier</label>
                </g:if>
                <g:else>
                    <label for="sapphireIdentifier" class="control-label">Slide Id</label>
                </g:else>
                <div>
                    <g:textField class="form-control" id="sapphireIdentifier" name="sapphireIdentifier" value="${aliquotInstance?.sapphireIdentifier}"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'sapphireIdentifier', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'exhausted', 'error')} ">
                <label for="exhausted" class="control-label"><g:message code="aliquot.exhausted.label" default="Exhausted" /><span class="required-indicator">*</span></label>
                <div>
                    <g:radioGroup name="exhausted"
                                  values="[true, false]"
                                  labels="['Yes', 'No']"
                                  value="${aliquotInstance?.exhausted}">
                        ${it.label}  ${it.radio}
                    </g:radioGroup>
                </div>
            </div>
        </div>
    </div>

    <g:if test="${aliquotInstance?.derivedFrom?.derivationProcess?.name() =='Tissue_disruption' || aliquotInstance?.derivedFrom?.derivationProcess?.name() =='Tissue_disruption_centrifugation_with_buffer'}">
        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotVolumeMass', 'error')} ">
                    <label for="aliquotVolumeMass" class="control-label"><g:message code="aliquot.aliquotVolumeMass.label" default="Volume/Mass" /></label>
                    <div>
                        <g:textField class="form-control" name="aliquotVolumeMass" value="${fieldValue(bean: aliquotInstance, field: 'aliquotVolumeMass')}" />
                        <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotVolumeMass', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: aliquotInstance, field: 'unit', 'error')}">
                    <label for="unit" class="control-label"><g:message code="aliquot.unit.label" default="Unit" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" id="unit" name="unit.id" from="${geldb.Units.list().sort()}" optionKey="id" value="${aliquotInstance?.unit?.id}" required="" noSelection="['':'- Choose -']"/>
                        <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'unit', 'error')}</span>
                    </div>
                </div>
            </div>
        </div>
    </g:if>
</g:if>

<g:if test="${aliquotInstance?.colocation?.id !=null && aliquotInstance?.derivedFrom?.id == null}">
    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'colocation', 'error')} ">
                <label for="colocation" class="control-label"><g:message code="aliquot.colocation.label" default="Colocation" /></label>
                <div>
                    <g:select class="form-control" id="colocation" name="colocation.id" from="${geldb.Colocation.list()}" optionKey="id" value="${aliquotInstance?.colocation?.id}" class="many-to-one" noSelection="['null': '']"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'colocation', 'error')}</span>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'specimen', 'error')} required">
                <label for="specimen" class="control-label"><g:message code="aliquot.specimen.label" default="Specimen" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="specimen" name="specimen.id" size="4" from="${geldb.Specimen.findAllByParticipant(aliquotInstance?.colocation?.aliquot?.specimen?.participant)}" optionKey="id" required="" value="${aliquotInstance?.specimen?.id}" class="many-to-one"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'specimen', 'error')}</span>
                </div>
            </div>
        </div>
    </div>
    <p>
    <p>
</g:if>

<g:if test="${aliquotInstance?.derivedFrom?.id == null && aliquotInstance?.specimen?.id == null && aliquotInstance?.colocation?.id == null}">
    <div class="row">
        <div class="col-lg-6">
            <div class="input-group">
                <g:textField type="text" id="search" name="search" class="form-control"  placeholder="GEL000" required="" ></g:textField>
                <div class="input-group-btn">
                    <button type="button" class="btn btn-success" value="Find" onClick= 'getSpecimen()'><span class="glyphicon glyphicon-search"></span> Find Specimen</button>
                </div>
            </div>
        </div>
    </div>
    <p>
    <div id="selectSpecimen"></div>
</g:if>

<g:if test="${aliquotInstance?.colocation?.id == null && aliquotInstance?.derivedFrom?.id == null && aliquotInstance?.specimen?.id != null}">
    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'specimen', 'error')} required">
                <label for="specimen" class="control-label"><g:message code="aliquot.specimen.label" default="Specimen" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="specimen" name="specimen.id" size="1" from="${geldb.Specimen.list()}" optionKey="id" required="" value="${aliquotInstance?.specimen?.id}" class="many-to-one"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'specimen', 'error')}</span>
                </div>
            </div>
        </div>
    </div>
</g:if>

<g:if test="${aliquotInstance?.derivedFrom?.id ==null}">
    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotType', 'error')} required">
                <label for="aliquotType" class="control-label"><g:message code="aliquot.aliquotType.label" default="Aliquot Type" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="aliquotType" name="aliquotType.id" from="${geldb.AliquotType.list().sort{it.aliquotTypeName}}" optionKey="id" required="" value="${aliquotInstance?.aliquotType?.id}" noSelection="['':'- Choose -']" onchange="preFillCreatedOnFFAliquot()"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotType', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6" id="showCreatedOn">
            <div class="${hasErrors(bean: aliquotInstance, field: 'createdOn', 'error')} required">
                <label for="createdOn" class="control-label"><g:message code="FFPE_Tissue_Report.createdOn.label" default="Created on" /></label>
                <div>
                    <bs:datePicker id="createdOn" name="createdOn" precision="day"  value="${aliquotInstance?.createdOn}" default="none" noSelection="['': '']"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'createdOn', 'error')}</span>
                </div>
            </div>
        </div>
    </div>
</g:if>

<div class="row">
    <g:if test="${aliquotInstance?.derivedFrom?.id ==null}">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'blockNumber', 'error')} ">
                <label for="blockNumber" class="control-label"><g:message code="aliquot.blockNumber.label" default="Block number (in this format: path number, block number, size (small/XL))" /></label>
                <div>
                    <g:textField class="form-control" id="blockNumber" name="blockNumber" value="${aliquotInstance?.blockNumber}" />
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'blockNumber', 'error')}</span>
                </div>
            </div>
        </div>
    </g:if>

    <g:if test="${aliquotInstance?.derivedFrom?.id ==null}">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'sapphireIdentifier', 'error')} ">
                <label for="sapphireIdentifier" class="control-label"><g:message code="aliquot.sapphireIdentifier.label" default="Biobanking Identifier (Sapphire number, ORB Sample Bank number, Study ID)" /></label>
                <div>
                    <g:textField class="form-control" id="sapphireIdentifier" name="sapphireIdentifier" value="${aliquotInstance?.sapphireIdentifier}"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'sapphireIdentifier', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'exhausted', 'error')} ">
                <label for="exhausted" class="control-label"><g:message code="aliquot.exhausted.label" default="Exhausted" /><span class="required-indicator">*</span></label>
                <div>
                    <g:radioGroup name="exhausted"
                                  values="[true, false]"
                                  labels="['Yes', 'No']"
                                  value="${aliquotInstance?.exhausted}">
                        ${it.label}  ${it.radio}
                    </g:radioGroup>
                </div>
            </div>
        </div>
    </g:if>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: aliquotInstance, field: 'barcode', 'error')} ">
            <label for="barcode" class="control-label"><g:message code="aliquot.barcode.label" default="Barcode (where available)" /></label>
            <div>
                <g:textField class="form-control" name="barcode" value="${aliquotInstance?.barcode}"/>
                <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'barcode', 'error')}</span>
            </div>
        </div>
    </div>
</div>

<g:if test="${aliquotInstance?.derivedFrom?.id == null}">
    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'notes', 'error')} ">
                <label for="notes" class="control-label"><g:message code="aliquot.notes.label" default="Notes" /></label>
                <div>
                    <g:textArea class="form-control" name="notes" cols="40" rows="4" value="${aliquotInstance?.notes}"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'notes', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotRanking', 'error')} ">
                <label for="aliquotRanking" class="control-label"><g:message code="aliquot.aliquotRanking.label" default="Aliquot Ranking" /></label>
                <div>
                    <g:select class="form-control" name="aliquotRanking" from="${aliquotInstance.constraints.aliquotRanking.inList}" value="${aliquotInstance?.aliquotRanking}" valueMessagePrefix="aliquot.aliquotRanking"  noSelection="['':'- Choose -']"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotRanking', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'frozenBy', 'error')} required" id="frozenByWithLabel">
                <label for="frozenBy" class="control-label"><g:message code="aliquot.frozenBy.label" default="Frozen By (frozen sample only)" /></label>
                <div>
                    <g:select class="form-control" id="frozenBy" name="frozenBy" from="${geldb.FrozenBy?.values()}" keys="${geldb.FrozenBy.values()*.name()}" value="${aliquotInstance?.frozenBy?.name()}" noSelection="['':'- Choose -']"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'frozenBy', 'error')}</span>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotVolumeMass', 'error')} ">
                <label for="aliquotVolumeMass" class="control-label"><g:message code="aliquot.aliquotVolumeMass.label" default="Aliquot Volume/Mass" /></label>
                <div>
                    <g:textField class="form-control" name="aliquotVolumeMass" value="${fieldValue(bean: aliquotInstance, field: 'aliquotVolumeMass')}" />
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotVolumeMass', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'unit', 'error')}">
                <label for="unit" class="control-label"><g:message code="aliquot.unit.label" default="Unit" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="unit" name="unit.id" from="${geldb.Units.list().sort()}" optionKey="id" value="${aliquotInstance?.unit?.id}" required="" noSelection="['':'- Choose -']"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'unit', 'error')}</span>
                </div>
            </div>
        </div>
    </div>

    <div id="exhaustSpecimen"></div>

    <g:if test="${!aliquotInstance?.createdTime}">
        <g:hiddenField id="createdTime" name="createdTime" value="${new Date().format('yyyy-MM-dd HH:MM')}"/>
    </g:if>

</g:if>

<div class="modal fade" id="notFound">
    <div class="modal-dialog" style="position: absolute; left: 0%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">Not Found!</h4>
            </div>
            <div class="modal-body">
                <p>No specimen found with the Gel Id you entered</p>
            </div>
            <div class="modal-footer">
                <a class='btn btn-primary btn-small' <g:link controller="fluidSpecimen" action="create" ><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'fluidSpecimen.label', default: 'Fluid Specimen')])}</g:link>
                <a class='btn btn-primary btn-small' <g:link controller="solidSpecimen" action="create" ><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'solidSpecimen.label', default: 'Solid Specimen')])}</g:link>
                <button type="button" class="btn" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function getSpecimen(){
        ${remoteFunction (controller: 'aliquot',
                        action: 'findSpecimenByGeLId',
                        params: '"search=" + $("#search").val()',
                        update: 'selectSpecimen',
                        onFailure:'error()'
                )}
    }

    function error(){
        var select = $("#selectSpecimen");
        select.empty().append("Not found");
        $('#notFound').modal()
    }

    function exhaustFluidSpecimen(){
        ${remoteFunction (controller: 'aliquot',
                        action: 'exhaustSpecimen',
                        params: '"selectedSpecimen=" + $("#specimen").val()',
                        update: 'exhaustSpecimen',
                        onSuccess: '$("#exhaustSpecimen").show()',
                        onFailure:'$("#exhaustSpecimen").hide()'
                )}
    }

    function preFillCreatedOn(){
        var baseUrl = "${createLink(controller:'aliquot', action:'preFillCreatedOn')}";
        var specimenId = $('#specimen').val();
        var url = baseUrl + "?specimenId=" + specimenId;
        $.ajax({
            url:url,
            type: 'POST',
            dataType: 'xml',
            async:true,
            success: function(res) {
                if (res){
                    var createdOn = $(res).find('timestamp').text();
                    createdOn = createdOn.toString().substr(0,10);
                    $('#createdOn').val(createdOn);
                }
            },
            error: function(request, status, error) {
                $('#createdOn').val("");
            }
        });
    }

    function preFillCreatedOnFFAliquot(){
        var baseUrl = "${createLink(controller:'aliquot', action:'preFillCreatedOnFFAliquot')}";
        var specimenId = $('#specimen').val();
        var aliquotType = $('#aliquotType').val();
        var url = baseUrl + "?specimenId=" + specimenId + "&aliquotType=" + aliquotType;
        $.ajax({
            url:url,
            type: 'POST',
            dataType: 'xml',
            async:true,
            success: function(res) {
                if (res){
                    var createdOn = $(res).find('timestamp').text();
                    createdOn = createdOn.toString().substr(0,10);
                    $('#createdOn').val(createdOn);
                }
            },
            error: function(request, status, error) {
            }
        });
    }
</script>

