<%@ page import="geldb.Derivation" %>



<div class="${hasErrors(bean: derivationInstance, field: 'aliquot', 'error')} ">
    <label for="aliquot" class="control-label"><g:message code="derivation.aliquot.label" default="Parent Aliquot" /><span class="required-indicator">*</span></label>
    <div>
        <g:select class="form-control" id="aliquot" name="aliquot.id" from="${geldb.Aliquot.list()}" optionKey="id"  value="${derivationInstance?.aliquot?.id}" required="" class="many-to-one"/>
        <span class="help-inline">${hasErrors(bean: derivationInstance, field: 'aliquot', 'error')}</span>
    </div>
</div>

<div class="row">
    <div class="col-lg-6">
        <div class="${hasErrors(bean: derivationInstance, field: 'derivationProcess', 'error')} required">
            <label for="derivationProcess" class="control-label"><g:message code="derivation.derivationProcess.label" default="Derivation Process" /><span class="required-indicator">*</span></label>
            <div>
                <g:select class="form-control" name="derivationProcess" from="${geldb.DerivationType?.values()}" keys="${geldb.DerivationType.values()*.name()}" required="" value="${derivationInstance?.derivationProcess?.name()}" onchange="getSlidId()" noSelection="['':'- Choose -']"/>
                <span class="help-inline">${hasErrors(bean: derivationInstance, field: 'derivationProcess', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotType', 'error')} required">
            <label for="aliquotType" class="control-label"><g:message code="aliquot.aliquotType.label" default="Derived Aliquot Type" /><span class="required-indicator">*</span></label>
            <div>
                <g:select class="form-control" id="aliquotType" name="aliquotType.id" from="${geldb.AliquotType.list().sort {it.aliquotTypeName}}" optionKey="id" required="" value="${aliquotType}" noSelection="['':'- Choose -']" />
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
                <bs:datePicker name="derivationDate" precision="day"  value="${derivationInstance?.derivationDate}"  />
                <span class="help-inline">${hasErrors(bean: derivationInstance, field: 'derivationDate', 'error')}</span>
            </div>
        </div>
    </div>

    %{--<div class="col-lg-6">--}%
    %{--<div class="${hasErrors(bean: derivationInstance, field: 'derivationTime', 'error')} ">--}%
    %{--<label for="derivationTime" class="control-label"><g:message code="derivation.derivationTime.label" default="Derivation Time" /></label>--}%
    %{--<div>--}%
    %{--<g:field type="time" class="form-control" name="derivationTime" value="${derivationInstance?.derivationTime}"/>--}%
    %{--<span class="help-inline">${hasErrors(bean: derivationInstance, field: 'derivationTime', 'error')}</span>--}%
    %{--</div>--}%
    %{--</div>--}%
    %{--</div>--}%

    <div class="col-lg-6">
        <div class="${hasErrors(bean: derivationInstance, field: 'derivedBy', 'error')} required">
            <label for="derivedBy" class="control-label"><g:message code="derivation.derivedBy.label" default="Derived By" /><span class="required-indicator">*</span></label>
            <div>
                <g:select class="form-control" id="derivedBy" name="derivedBy.id" from="${geldb.StaffMember.list().sort {it.staffName}}" optionKey="id" required="" value="${derivationInstance?.derivedBy?.id}" noSelection="['':'- Choose -']" />
                <span class="help-inline">${hasErrors(bean: derivationInstance, field: 'derivedBy', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: aliquotInstance, field: 'barcode', 'error')} ">
            <label for="barcode" class="control-label"><g:message code="aliquot.barcode.label" default="Barcode (where available)" /></label>
            <div>
                <% def barcode = derivationInstance?.derivedAliquots?.barcode %>
                <% barcode =barcode.findResult {it?.size() ? it : null}%>
                <g:textField class="form-control" name="barcode" value="${barcode}"/>
                <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'barcode', 'error')}</span>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-6">
        <div class="${hasErrors(bean: aliquotInstance, field: 'sapphireIdentifier', 'error')} ">
            <g:if test="${derivationInstance?.derivationProcess?.name() =='Tissue_disruption_centrifugation_with_buffer'}">
                <label for="sapphireIdentifier" class="control-label">Identifier</label>
            </g:if>
            <g:else>
                <label for="sapphireIdentifier" class="control-label"><g:message code="aliquot.sapphireIdentifier.label" default="Slide ID (Frozen only)" /></label>
            </g:else>
            <div>
                <% def sapphireIdentifier = derivationInstance?.derivedAliquots?.sapphireIdentifier %>
                <% sapphireIdentifier =sapphireIdentifier.findResult {it?.size() ? it : null}%>
                <g:textField class="form-control" name="sapphireIdentifier" id="sapphireIdentifier" value="${sapphireIdentifier}"/>
                <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'sapphireIdentifier', 'error')}</span>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="${hasErrors(bean: aliquotInstance, field: 'exhausted', 'error')} ">
            <label for="exhausted" class="control-label"><g:message code="aliquot.exhausted.label" default="Exhausted" /><span class="required-indicator">*</span></label>
            <div>
                <label class="radio-inline"><input type="radio" name="exhausted" value= "True">Yes</label>
                <label class="radio-inline"><input type="radio" name="exhausted" value= "False" checked="checked" >No</label>
            </div>
        </div>
    </div>
</div>

<g:if test="${derivationInstance?.derivationProcess?.name() =='Tissue_disruption_centrifugation_with_buffer'}">
    <div class="row">
        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotVolumeMass', 'error')} ">
                <label for="aliquotVolumeMass" class="control-label"><g:message code="aliquot.aliquotVolumeMass.label" default="Volume/Mass" /></label>
                <div>
                    <% def aliquotVolumeMass = derivationInstance?.derivedAliquots?.aliquotVolumeMass %>
                    <% aliquotVolumeMass =aliquotVolumeMass.findResult {it?.size() ? it : null}%>
                    <g:textField class="form-control" name="aliquotVolumeMass" value="${aliquotVolumeMass}" />
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotVolumeMass', 'error')}</span>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="${hasErrors(bean: aliquotInstance, field: 'unit', 'error')}">
                <label for="unit" class="control-label"><g:message code="aliquot.unit.label" default="Unit" /><span class="required-indicator">*</span></label>
                <div>
                    <% def unit = derivationInstance?.derivedAliquots?.unit %>
                    <% unit =unit.findResult {it?.id ? it : null}%>
                    <g:select class="form-control" id="unit" name="unit.id" from="${geldb.Units.list().sort()}" optionKey="id" value="${unit?.id}" required="" noSelection="['':'- Choose -']"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'unit', 'error')}</span>
                </div>
            </div>
        </div>
    </div>
</g:if>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function getAliquots(){
        ${remoteFunction (controller: 'derivation',
                        action: 'findAliquotsByGeLId',
                        params: '"search=" + $("#search").val()',
                        update: 'selectAliquot',
                        onFailure:'error()'
                )}
    }

    function error(){
        var select = $("#selectAliquot");
        select.empty().append("Not found");
        $('#notFound').modal()
    }

    function getSlidId(){

        var baseUrl = "${createLink(controller:'derivation', action:'getSlideID')}";
        var selectAliquot = $('#aliquot').val();
        var url = baseUrl + "?selectAliquot="+selectAliquot;
        $.ajax({
            url:url,
            type: 'POST',
            dataType: 'xml',
            async:true,
            success: function(res) {

                if (res){
                    var slidID = $(res).find("map").text();
                    $('#sapphireIdentifier').val(slidID);
                }
            },
            error: function(request, status, error) {
                $('#sapphireIdentifier').val("");

            }
        });
    }
</script>

