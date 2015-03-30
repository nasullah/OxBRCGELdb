<%@ page import="geldb.DNA_Extract" %>


            <g:if test="${DNA_ExtractInstance?.aliquot*.id == null}">
                <hr style="border:1; height:1px" />
                <div class="row">
                    <div class="col-lg-6">
                        <div class="input-group">
                            <g:textField type="text" id="search" name="search" class="form-control"  placeholder="Enter participant's GeL Id" required="" ></g:textField>
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-success" value="Find" onClick= 'getAliquots()'><span class="glyphicon glyphicon-search"></span> Find Aliquot</button>
                            </div>
                        </div>
                    </div>
                </div>
                <p>
                <div id="selectAliquot"></div>
            </g:if>

            <g:if test="${DNA_ExtractInstance?.aliquot*.id != null}">
                <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'aliquot', 'error')} ">
                    <label for="aliquot" class="control-label"><g:message code="DNA_Extract.aliquot.label" default="Aliquot" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" name="aliquot" id="aliquot" from="${geldb.Aliquot.list()}"
                                  multiple="multiple" size="1" optionKey="id" value="${DNA_ExtractInstance?.aliquot*.id}" required="" class="many-to-many"/>
                        <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'aliquot', 'error')}</span>
                    </div>
                </div>
            </g:if>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'exhausted', 'error')} ">
                        <label for="exhausted" class="control-label"><g:message code="DNA_Extract.exhausted.label" default="Exhausted" /></label>
                        <div>
                            %{--<bs:checkBox name="exhausted" value="${DNA_ExtractInstance?.exhausted}" offLabel="No" onLabel="Yes"/>--}%
                            %{--<span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'exhausted', 'error')}</span>--}%
                            <label class="radio-inline"><input type="radio" name="exhausted" value="True">Yes</label>
                            <label class="radio-inline"><input type="radio" name="exhausted" value="False" checked="checked" >No</label>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'passFail', 'error')} ">
                        <label for="passFail" class="control-label"><g:message code="DNA_Extract.passFail.label" default="Pass/Fail" /></label>
                        <div>
                            %{--<bs:checkBox name="passFail" value="${DNA_ExtractInstance?.passFail}" offLabel="Fail" onLabel="Pass"/>--}%
                            %{--<span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'passFail', 'error')}</span>--}%
                            <label class="radio-inline"><input type="radio" name="passFail" value="True" checked="checked">Yes</label>
                            <label class="radio-inline"><input type="radio" name="passFail" value="False" >No</label>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'passFailReason', 'error')} ">
                        <label for="passFailReason" class="control-label"><g:message code="DNA_Extract.passFailReason.label" default="Pass Fail Reason" /></label>
                        <div>
                            <g:textArea class="form-control" name="passFailReason" cols="40" rows="5" value="${DNA_ExtractInstance?.passFailReason}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'passFailReason', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'notes', 'error')} ">
                        <label for="notes" class="control-label"><g:message code="DNA_Extract.notes.label" default="Notes" /></label>
                        <div>
                            <g:textArea class="form-control" name="notes" cols="40" rows="5" value="${DNA_ExtractInstance?.notes}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'notes', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'dNAConcentration', 'error')} required">
                        <label for="dNAConcentration" class="control-label"><g:message code="DNA_Extract.dNAConcentration.label" default="DNA Concentration" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="dNAConcentration" value="${fieldValue(bean: DNA_ExtractInstance, field: 'dNAConcentration')}" required=""/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'dNAConcentration', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'dNAAmount', 'error')} required">
                        <label for="dNAAmount" class="control-label"><g:message code="DNA_Extract.dNAAmount.label" default="DNA Amount" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="dNAAmount" value="${fieldValue(bean: DNA_ExtractInstance, field: 'dNAAmount')}" required=""/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'dNAAmount', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'extractionDate', 'error')} required">
                        <label for="extractionDate" class="control-label"><g:message code="DNA_Extract.extractionDate.label" default="Extraction Date" /><span class="required-indicator">*</span></label>
                        <div>
                            <bs:datePicker name="extractionDate" precision="day"  value="${DNA_ExtractInstance?.extractionDate}"  />
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'extractionDate', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'extractedBy', 'error')} ">
                        <label for="extractedBy" class="control-label"><g:message code="DNA_Extract.extractedBy.label" default="Extracted By" /></label>
                        <div>
                            <g:select class="form-control" id="extractedBy" name="extractedBy.id" from="${geldb.StaffMember.list().sort {it.staffName}}" optionKey="id" value="${DNA_ExtractInstance?.extractedBy?.id}" noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'extractedBy', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'geLSampleIdentifier', 'error')} required">
                        <label for="geLSampleIdentifier" class="control-label"><g:message code="DNA_Extract.geLSampleIdentifier.label" default="GeL Sample Identifier" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="geLSampleIdentifier" maxlength="50" required="" value="${DNA_ExtractInstance?.geLSampleIdentifier}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'geLSampleIdentifier', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'sapphireIdentifier', 'error')} ">
                        <label for="sapphireIdentifier" class="control-label"><g:message code="DNA_Extract.sapphireIdentifier.label" default="Biobanking Identifier" /></label>
                        <div>
                            <g:textField class="form-control" id="sapphireIdentifier" name="sapphireIdentifier" value="${DNA_ExtractInstance?.sapphireIdentifier}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'sapphireIdentifier', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'dNAExtractionKit', 'error')} required">
                        <label for="dNAExtractionKit" class="control-label"><g:message code="DNA_Extract.dNAExtractionKit.label" default="DNA Extraction Kit" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="dNAExtractionKit" maxlength="50" required="" value="${DNA_ExtractInstance?.dNAExtractionKit}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'dNAExtractionKit', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'delatQC', 'error')} required">
                        <label for="delatQC" class="control-label"><g:message code="DNA_Extract.delatQC.label" default="Delta QC" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="delatQC" value="${fieldValue(bean: DNA_ExtractInstance, field: 'delatQC')}" required=""/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'delatQC', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'a260A280', 'error')} required">
                        <label for="a260A280" class="control-label"><g:message code="DNA_Extract.a260A280.label" default="A260A280" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="a260A280" value="${fieldValue(bean: DNA_ExtractInstance, field: 'a260A280')}" required=""/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'a260A280', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'barcode', 'error')} ">
                        <label for="barcode" class="control-label"><g:message code="DNA_Extract.barcode.label" default="Barcode" /></label>
                        <div>
                            <g:textField class="form-control" name="barcode" value="${DNA_ExtractInstance?.barcode}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'barcode', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="">
                        <label for="exhaustAliquot" class="control-label"><g:message code="DNA_Extract.exhaustAliquot.label" default="Exhaust Aliquot ?" /></label>
                        <div>
                            %{--<bs:checkBox name="exhaustAliquot" id="exhaustAliquot" offLabel="No" onLabel="Yes"/>--}%
                            <label class="radio-inline"><input type="radio" name="exhaustAliquot"  value="True">Yes</label>
                            <label class="radio-inline"><input type="radio" name="exhaustAliquot"  value="False" >No</label>
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
                            <p>No aliquot found with the Gel Id you entered</p>
                        </div>
                        <div class="modal-footer">
                            <a class='btn btn-primary btn-small' <g:link controller="aliquot" action="create" ><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Aliquot')])}</g:link>
                            <button type="button" class="btn" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function getAliquots(){
        ${remoteFunction (controller: 'DNA_Extract',
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
</script>

