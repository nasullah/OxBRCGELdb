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
                            <g:select class="form-control" name="derivationProcess" from="${geldb.DerivationType?.values()}" keys="${geldb.DerivationType.values()*.name()}" required="" value="${derivationInstance?.derivationProcess?.name()}"  noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: derivationInstance, field: 'derivationProcess', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div>
                        <label for="aliquotType" class="control-label"><g:message code="aliquot.aliquotType.label" default="Derived Aliquot Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="aliquotType" name="aliquotType.id" from="${geldb.AliquotType.list().sort {it.aliquotTypeName}}" optionKey="id" required="" value="${aliquotType}" noSelection="['':'- Choose -']" />
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
                    <div>
                        <label for="barcode" class="control-label"><g:message code="aliquot.barcode.label" default="Barcode (where available)" /></label>
                        <div>
                            <g:textField class="form-control" name="barcode" value=""/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div>
                        <g:if test="${derivationInstance?.derivationProcess?.name() == 'Tissue_disruption' || derivationInstance?.derivationProcess?.name() == 'Tissue_disruption_centrifugation_with_buffer'}">
                            <label for="sapphireIdentifier" class="control-label">Identifier</label>
                        </g:if>
                        <g:else>
                            <label for="sapphireIdentifier" class="control-label"><g:message code="aliquot.sapphireIdentifier.label" default="Slide ID (Frozen only)" /></label>
                        </g:else>
                        <div>
                            <g:textField class="form-control" name="sapphireIdentifier" id="sapphireIdentifier" value=""/>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div>
                        <label for="exhausted" class="control-label"><g:message code="aliquot.exhausted.label" default="Exhausted" /><span class="required-indicator">*</span></label>
                        <div>
                            <label class="radio-inline"><input type="radio" name="exhausted" value= "True">Yes</label>
                            <label class="radio-inline"><input type="radio" name="exhausted" value= "False" checked="checked" >No</label>
                        </div>
                    </div>
                </div>
            </div>

            <g:if test="${derivationInstance?.derivationProcess?.name() == 'Tissue_disruption' || derivationInstance?.derivationProcess?.name() == 'Tissue_disruption_centrifugation_with_buffer'}">
                <div class="row">
                    <div class="col-lg-6">
                        <div>
                            <label for="aliquotVolumeMass" class="control-label"><g:message code="aliquot.aliquotVolumeMass.label" default="Volume/Mass" /></label>
                            <div>
                                <g:textField class="form-control" name="aliquotVolumeMass" value="0.6" />
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div>
                            <label for="unit" class="control-label"><g:message code="aliquot.unit.label" default="Unit" /><span class="required-indicator">*</span></label>
                            <div>
                                <g:select class="form-control" id="unit" name="unit.id" from="${geldb.Units.list().sort()}" optionKey="id" value="${geldb.Units.findByUnitName('ml').id}" required="" noSelection="['':'- Choose -']"/>
                            </div>
                        </div>
                    </div>
                </div>
            </g:if>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function getSlidId(){
        var baseUrl = "${createLink(controller:'derivation', action:'getSlideID')}";
        var parentAliquot = $('#aliquot').val();
        var aliquotType = $('#aliquotType').val();
        var url = baseUrl + "?parentAliquot="+parentAliquot+"&aliquotType="+aliquotType;
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
    getSlidId();
</script>

