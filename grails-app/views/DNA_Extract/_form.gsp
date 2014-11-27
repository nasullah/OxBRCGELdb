<%@ page import="geldb.DNA_Extract" %>


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

            <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'aliquot', 'error')} ">
                <label for="aliquot" class="control-label"><g:message code="DNA_Extract.aliquot.label" default="Aliquot" /><span class="required-indicator">*</span></label>
                <div id="selectAliquot">
                    <g:select class=""  name="1" from="${''}" optionKey="" value="${''}" required=""/>
                </div>
            </div>

			<div class="${hasErrors(bean: DNA_ExtractInstance, field: 'exhausted', 'error')} ">
				<label for="exhausted" class="control-label"><g:message code="DNA_Extract.exhausted.label" default="Exhausted" /></label>
				<div>
					<bs:checkBox name="exhausted" value="${DNA_ExtractInstance?.exhausted}" />
					<span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'exhausted', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: DNA_ExtractInstance, field: 'passFail', 'error')} ">
				<label for="passFail" class="control-label"><g:message code="DNA_Extract.passFail.label" default="Pass Fail" /></label>
				<div>
					<bs:checkBox name="passFail" value="${DNA_ExtractInstance?.passFail}" />
					<span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'passFail', 'error')}</span>
				</div>
			</div>

            <div class="row">
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
                            <g:select class="form-control" id="extractedBy" name="extractedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${DNA_ExtractInstance?.extractedBy?.id}" noSelection="['null': '']"/>
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
                    <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'dNAExtractionKit', 'error')} required">
                        <label for="dNAExtractionKit" class="control-label"><g:message code="DNA_Extract.dNAExtractionKit.label" default="DNA Extraction Kit" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="dNAExtractionKit" maxlength="50" required="" value="${DNA_ExtractInstance?.dNAExtractionKit}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'dNAExtractionKit', 'error')}</span>
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
        $('#notFound').modal()
    }
</script>

