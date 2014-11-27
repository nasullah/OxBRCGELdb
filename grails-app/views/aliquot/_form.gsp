<%@ page import="geldb.UnitType; geldb.Aliquot" %>



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

            <p>

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

            <div class="${hasErrors(bean: aliquotInstance, field: 'specimen', 'error')} required">
                <label for="specimen" class="control-label"><g:message code="aliquot.specimen.label" default="Specimen" /><span class="required-indicator">*</span></label>
                <div id="selectSpecimen">
                    <g:select class=""  name="1" from="${''}" optionKey="" value="${''}" required=""/>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'blockNumber', 'error')} ">
                        <label for="blockNumber" class="control-label"><g:message code="aliquot.blockNumber.label" default="Block Number" /></label>
                        <div>
                            <g:textField class="form-control" name="blockNumber" value="${aliquotInstance?.blockNumber}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'blockNumber', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'biobankIdentifier', 'error')} ">
                        <label for="biobankIdentifier" class="control-label"><g:message code="aliquot.biobankIdentifier.label" default="Biobank Identifier" /></label>
                        <div>
                            <g:textField class="form-control" name="biobankIdentifier" value="${aliquotInstance?.biobankIdentifier}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'biobankIdentifier', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotType', 'error')} required">
                        <label for="aliquotType" class="control-label"><g:message code="aliquot.aliquotType.label" default="Aliquot Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="aliquotType" name="aliquotType.id" from="${geldb.AliquotType.list()}" optionKey="id" required="" value="${aliquotInstance?.aliquotType?.id}" />
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotType', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="${hasErrors(bean: aliquotInstance, field: 'exhausted', 'error')} ">
                <label for="exhausted" class="control-label"><g:message code="aliquot.exhausted.label" default="Exhausted" /></label>
                <div>
                    <bs:checkBox name="exhausted" value="${aliquotInstance?.exhausted}" />
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'exhausted', 'error')}</span>
                </div>
            </div>

            <div class="${hasErrors(bean: aliquotInstance, field: 'passFail', 'error')} ">
                <label for="passFail" class="control-label"><g:message code="aliquot.passFail.label" default="Pass Fail" /></label>
                <div>
                    <bs:checkBox name="passFail" value="${aliquotInstance?.passFail}" />
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'passFail', 'error')}</span>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'passFailReason', 'error')} ">
                        <label for="passFailReason" class="control-label"><g:message code="aliquot.passFailReason.label" default="Pass Fail Reason" /></label>
                        <div>
                            <g:textArea class="form-control" name="passFailReason" cols="40" rows="5" value="${aliquotInstance?.passFailReason}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'passFailReason', 'error')}</span>
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

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'barcode', 'error')} ">
                        <label for="barcode" class="control-label"><g:message code="aliquot.barcode.label" default="Barcode" /></label>
                        <div>
                            <g:textField class="form-control" name="barcode" value="${aliquotInstance?.barcode}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'barcode', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotVolumeMass', 'error')} ">
                        <label for="aliquotVolumeMass" class="control-label"><g:message code="aliquot.aliquotVolumeMass.label" default="Aliquot Volume/Mass" /></label>
                        <div>
                            <g:field class="form-control" name="aliquotVolumeMass" value="${fieldValue(bean: aliquotInstance, field: 'aliquotVolumeMass')}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotVolumeMass', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'unit', 'error')}">
                        <label for="unit" class="control-label"><g:message code="aliquot.unit.label" default="Unit" /></label>
                        <div>
                            <g:select class="form-control" id="unit" name="unit.id" from="${geldb.Units.list()}" optionKey="id" required="" value="${aliquotInstance?.unit?.id}" noSelection="['null': '']"/>
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
        $('#notFound').modal()
    }
</script>

