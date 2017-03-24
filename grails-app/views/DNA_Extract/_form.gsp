<%@ page import="geldb.DNA_Extract" %>
<%@ page import="geldb.ExtractionType" %>


            <g:if test="${DNA_ExtractInstance?.aliquot}">
                <br/>
                <g:each in="${DNA_ExtractInstance.aliquot}" var="a">
                    <p><b>${a}</b></p>
                    <g:hiddenField name="aliquot" value="${a.id}" />
                </g:each>
            </g:if>
            <g:else>
                <br/>
                <div class="row">
                    <div class="col-lg-6">
                        <label class="control-label"> Enter Participant/GEL ID</label>
                        <div class="input-group">
                            <g:textField type="text" id="search" name="search" class="form-control"  placeholder="GEL000" required="" />
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-success" value="Find" onClick= 'getAliquots()'><span class="glyphicon glyphicon-search"></span> Find Aliquot</button>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <label class="control-label"> Or scan/enter aliquot barcode</label>
                        <div class="input-group">
                            <g:textField type="text" id="aliquotBarcode" name="aliquotBarcode" class="form-control"  placeholder="1234567890" />
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-success" value="Find" onClick= 'getAliquotByBarcode()'><span class="glyphicon glyphicon-search"></span> Find Aliquot</button>
                            </div>
                        </div>
                    </div>
                </div>
                <p>
                <div id="selectAliquot"></div>
            </g:else>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'extractionType', 'error')} ">
                        <label for="extractionType" class="control-label"><g:message code="DNA_Extract.extractionType.label" default="Extraction Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="extractionType" name="extractionType.id" from="${geldb.ExtractionType.list().sort {it.extractionTypeName}}" optionKey="id" required="" value="${DNA_ExtractInstance?.extractionType?.id}" noSelection="['':'- Choose -']"  onchange="getElution()"/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'extractionType', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'exhausted', 'error')} ">
                        <label for="exhausted" class="control-label"><g:message code="DNA_Extract.exhausted.label" default="Exhausted DNA Extract" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:radioGroup name="exhausted"
                                          values="[true, false]"
                                          labels="['Yes', 'No']"
                                          value="${DNA_ExtractInstance?.exhausted}">
                                ${it.label}  ${it.radio} &nbsp; &nbsp;
                            </g:radioGroup>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'passFail', 'error')} ">
                        <label for="passFail" class="control-label"><g:message code="DNA_Extract.passFail.label" default="Pass/Fail" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:if test="${DNA_ExtractInstance?.id}">
                                <g:set var="passFail" value="${DNA_ExtractInstance.passFail}" />
                            </g:if>
                            <g:radioGroup name="passFail"
                                          values="[true, false]"
                                          labels="['Yes', 'No']"
                                          value="${passFail}"
                                          required="">
                                ${it.label}  ${it.radio} &nbsp; &nbsp;
                            </g:radioGroup>
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
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'dNAConcentrationNanodrop', 'error')} required">
                        <label for="dNAConcentrationNanodrop" class="control-label"><g:message code="DNA_Extract.dNAConcentrationNanodrop.label" default="DNA/RNA Concentration (Nanodrop- ng/µl)" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="dNAConcentrationNanodrop" value="${fieldValue(bean: DNA_ExtractInstance, field: 'dNAConcentrationNanodrop')}" required=""/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'dNAConcentrationNanodrop', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'dNAConcentrationQubit', 'error')} required">
                        <label for="dNAConcentrationQubit" class="control-label"><g:message code="DNA_Extract.dNAConcentrationQubit.label" default="DNA/RNA Concentration (Qubit- ng/µl)" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="dNAConcentrationQubit" value="${fieldValue(bean: DNA_ExtractInstance, field: 'dNAConcentrationQubit')}" required=""/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'dNAConcentrationQubit', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'dNAAmount', 'error')} required">
                        <label for="dNAAmount" class="control-label"><g:message code="DNA_Extract.dNAAmount.label" default="DNA/RNA Volume (µl)" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="dNAAmount" value="${fieldValue(bean: DNA_ExtractInstance, field: 'dNAAmount')}" required=""/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'dNAAmount', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'extractionDate', 'error')} required">
                        <label for="extractionDate" class="control-label"><g:message code="DNA_Extract.extractionDate.label" default="Extraction Date" /><span class="required-indicator">*</span></label>
                        <div>
                            <bs:datePicker name="extractionDate" precision="day"  value="${DNA_ExtractInstance?.extractionDate}"  />
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'extractionDate', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'extractedBy', 'error')} ">
                        <label for="extractedBy" class="control-label"><g:message code="DNA_Extract.extractedBy.label" default="Extracted By" /></label>
                        <div>
                            <g:select class="form-control" id="extractedBy" name="extractedBy.id" from="${geldb.StaffMember.findAllByStaffRole('Scientist/Lab Technician').sort {it.staffName}}" optionKey="id" value="${DNA_ExtractInstance?.extractedBy?.id}" noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'extractedBy', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'sapphireIdentifier', 'error')} ">
                        <label for="sapphireIdentifier" class="control-label"><g:message code="DNA_Extract.sapphireIdentifier.label" default="DNA/RNA Elution" /></label>
                        <div>
                            <g:textField class="form-control" id="sapphireIdentifier" name="sapphireIdentifier" value="${DNA_ExtractInstance?.sapphireIdentifier}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'sapphireIdentifier', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'extractionKit', 'error')} required">
                        <label for="extractionKit" class="control-label"><g:message code="DNA_Extract.extractionKit.label" default="DNA/RNA Extraction Kit" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="extractionKit" name="extractionKit.id" from="${geldb.DNAExtractionKit.list().sort {it.extractionKitName}}" required="" optionKey="id" value="${DNA_ExtractInstance?.extractionKit?.id}" noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'extractionKit', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'experimentName', 'error')} required">
                        <label for="experimentName" class="control-label"><g:message code="DNA_Extract.experimentName.label" default="Experiment Name" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="experimentName" required="" value="${DNA_ExtractInstance?.experimentName}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'experimentName', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6" id="delatQC">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'delatQC', 'error')} required">
                        <label for="delatQC" class="control-label"><g:message code="DNA_Extract.delatQC.label" default="Delta QC" /></label>
                        <div>
                            <g:field class="form-control" name="delatQC" value="${fieldValue(bean: DNA_ExtractInstance, field: 'delatQC')}" />
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'delatQC', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6"  id="rin">
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'rin', 'error')} required">
                        <label for="rin" class="control-label"><g:message code="DNA_Extract.rin.label" default="RIN" /></label>
                        <div>
                            <g:field class="form-control" name="rin" value="${fieldValue(bean: DNA_ExtractInstance, field: 'rin')}" />
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'rin', 'error')}</span>
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
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'a260A230', 'error')} required">
                        <label for="a260A280" class="control-label"><g:message code="DNA_Extract.a260A230.label" default="A260A230" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="a260A230" value="${fieldValue(bean: DNA_ExtractInstance, field: 'a260A230')}" required=""/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'a260A230', 'error')}</span>
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
            </div>

            <g:hiddenField name="originalVolume" value="${originalVolume}" />
            <g:hiddenField name="originalDnaId" value="${originalDnaId}" />

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

    function getAliquotByBarcode(){
        ${remoteFunction (controller: 'DNA_Extract',
                        action: 'findAliquotByBarcode',
                        params: '"aliquotBarcode=" + $("#aliquotBarcode").val()',
                        update: 'selectAliquot',
                        onFailure:'errorBarcode()'
                )}
    }

    function errorBarcode(){
        var select = $("#selectAliquot");
        select.empty().append("Not found");
        $('#notFound').modal()
    }

    function hiderRinOrDeltaCQ(){
        var select = $("#extractionType").val();
        var rnaExtraction = "${ExtractionType.findByExtractionTypeName('RNA Extraction')?.id}";
        var dnaExtraction = "${ExtractionType.findByExtractionTypeName('DNA Extraction')?.id}";
        if (select == rnaExtraction){
            $('#delatQC').hide();
            $('#rin').show();
        }
        if (select == dnaExtraction){
            $('#rin').hide();
            $('#delatQC').show();
        }
        if (select == ""){
            $('#rin').hide();
            $('#delatQC').hide();
        }
    }

    function getElution(){
        var baseUrl = "${createLink(controller:'DNA_Extract', action:'getElution')}";
        var selectExtractionType = $("#extractionType").val();
        var selectAliquot = $('#aliquot').val();
        var url = baseUrl + "?selectAliquot=" + selectAliquot + "&selectExtractionType=" + selectExtractionType;
        $.ajax({
            url:url,
            type: 'POST',
            dataType: 'xml',
            async:true,
            success: function(res) {

                if (res){
                    var elution = $(res).find("map").text();
                    $('#sapphireIdentifier').val(elution);
                }
            },
            error: function(request, status, error) {
                $('#sapphireIdentifier').val("");

            }
        });
        hiderRinOrDeltaCQ();
    }
</script>

