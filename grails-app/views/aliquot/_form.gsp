<%@ page import="geldb.UnitType; geldb.Aliquot" %>


            <hr style="border:1; height:1px" />

            <g:if test="${aliquotInstance?.derivedFrom?.id !=null}">
                <div class="${hasErrors(bean: aliquotInstance, field: 'derivedFrom', 'error')} ">
                    <label for="derivedFrom" class="control-label"><g:message code="aliquot.derivedFrom.label" default="Derived From" /></label>
                    <div>
                        <g:select class="form-control" id="derivedFrom" name="derivedFrom.id" from="${geldb.Derivation.list()}" optionKey="id" value="${aliquotInstance?.derivedFrom?.id}" class="many-to-one" noSelection="['null': '']"/>
                        <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'derivedFrom', 'error')}</span>
                    </div>
                </div>
            </g:if>

            <g:if test="${aliquotInstance?.colocation?.id !=null}">
                <div class="${hasErrors(bean: aliquotInstance, field: 'colocation', 'error')} ">
                    <label for="colocation" class="control-label"><g:message code="aliquot.colocation.label" default="Colocation" /></label>
                    <div>
                        <g:select class="form-control" id="colocation" name="colocation.id" from="${geldb.Colocation.list()}" optionKey="id" value="${aliquotInstance?.colocation?.id}" class="many-to-one" noSelection="['null': '']"/>
                        <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'colocation', 'error')}</span>
                    </div>
                </div>
            </g:if>

            <div class="row">
                <div class="col-lg-6">
                    <div class="input-group">
                        <g:textField type="text" id="search" name="search" class="form-control"  placeholder="Enter participant's GeL Id" required="" ></g:textField>
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-success" value="Find" onClick= 'getSpecimen()'><span class="glyphicon glyphicon-search"></span> Find Specimen</button>
                        </div>
                    </div>
                </div>
            </div>

            <p>

            <div id="selectSpecimen"></div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'blockNumber', 'error')} ">
                        <label for="blockNumber" class="control-label"><g:message code="aliquot.blockNumber.label" default="Block Number" /></label>
                        <div>
                            <g:textField class="form-control" id="blockNumber" name="blockNumber" value="${aliquotInstance?.blockNumber}" />
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'blockNumber', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'sapphireIdentifier', 'error')} ">
                        <label for="sapphireIdentifier" class="control-label"><g:message code="aliquot.sapphireIdentifier.label" default="Biobanking Identifier" /></label>
                        <div>
                            <g:textField class="form-control" id="sapphireIdentifier" name="sapphireIdentifier" value="${aliquotInstance?.sapphireIdentifier}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'sapphireIdentifier', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'barcode', 'error')} ">
                        <label for="barcode" class="control-label"><g:message code="aliquot.barcode.label" default="Barcode (where available)" /></label>
                        <div>
                            <g:textField class="form-control" name="barcode" value="${aliquotInstance?.barcode}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'barcode', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotType', 'error')} required">
                        <label for="aliquotType" class="control-label"><g:message code="aliquot.aliquotType.label" default="Aliquot Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="aliquotType" name="aliquotType.id" from="${geldb.AliquotType.list().sort()}" optionKey="id" required="" value="${aliquotInstance?.aliquotType?.id}" noSelection="['':'- Choose -']" onclick="alertUser()" />
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotType', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'exhausted', 'error')} ">
                        <label for="exhausted" class="control-label"><g:message code="aliquot.exhausted.label" default="Exhausted" /><span class="required-indicator">*</span></label>
                        <div>
                            %{--<bs:checkBox name="exhausted" value="${aliquotInstance?.exhausted}" offLabel="No" onLabel="Yes" />--}%
                            %{--<span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'exhausted', 'error')}</span>--}%
                            <label class="radio-inline"><input type="radio" name="exhausted" value="True">Yes</label>
                            <label class="radio-inline"><input type="radio" name="exhausted" value="False" checked="checked" >No</label>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'notes', 'error')} ">
                        <label for="notes" class="control-label"><g:message code="aliquot.notes.label" default="Notes" /></label>
                        <div>
                            <g:textArea class="form-control" name="notes" cols="40" rows="5" value="${aliquotInstance?.notes}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'notes', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            %{--<div class="${hasErrors(bean: aliquotInstance, field: 'passFail', 'error')} ">--}%
                %{--<label for="passFail" class="control-label"><g:message code="aliquot.passFail.label" default="Pass/Fail" /></label>--}%
                %{--<div>--}%
                    %{--<bs:checkBox name="passFail" value="${aliquotInstance?.passFail}" offLabel="Fail" onLabel="Pass" />--}%
                    %{--<span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'passFail', 'error')}</span>--}%
                %{--</div>--}%
            %{--</div>--}%

                %{--<div class="col-lg-6">--}%
                    %{--<div class="${hasErrors(bean: aliquotInstance, field: 'passFailReason', 'error')} ">--}%
                        %{--<label for="passFailReason" class="control-label"><g:message code="aliquot.passFailReason.label" default="Pass Fail Reason" /></label>--}%
                        %{--<div>--}%
                            %{--<g:textArea class="form-control" name="passFailReason" cols="40" rows="5" value="${aliquotInstance?.passFailReason}"/>--}%
                            %{--<span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'passFailReason', 'error')}</span>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotPhotograph', 'error')} required">
                        <label for="aliquotPhotograph" class="control-label"><g:message code="aliquot.aliquotPhotograph.label" default="Aliquot Photograph" /></label>
                        <div>
                            <input type="file" id="aliquotPhotograph" name="aliquotPhotograph" />
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotPhotograph', 'error')}</span>
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
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotVolumeMass', 'error')} ">
                        <label for="aliquotVolumeMass" class="control-label"><g:message code="aliquot.aliquotVolumeMass.label" default="Aliquot Volume/Mass" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="aliquotVolumeMass" value="${fieldValue(bean: aliquotInstance, field: 'aliquotVolumeMass')}" required=""/>
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotVolumeMass', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'unit', 'error')}">
                        <label for="unit" class="control-label"><g:message code="aliquot.unit.label" default="Unit" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="unit" name="unit.id" from="${geldb.Units.list().sort()}" optionKey="id" value="${aliquotInstance?.unit?.id}" required="" noSelection="['':'- Choose unit -']"/>
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'unit', 'error')}</span>
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

            <div class="modal fade" id="isEmpty">
                <div class="modal-dialog" style="position: absolute; left: 0%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">Required!</h4>
                        </div>
                        <div class="modal-body">
                            <p>You need to fill in either Block Number or Biobanking Identifier.</p>
                        </div>
                        <div class="modal-footer">
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

    function alertUser(){
        if ($.trim($('#blockNumber').val()) == '' && $.trim($('#sapphireIdentifier').val()) == ''){
            $('#isEmpty').modal()
        }
    }
</script>

