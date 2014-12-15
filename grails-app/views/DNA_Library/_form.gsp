<%@ page import="geldb.DNA_Library" %>


            <hr style="border:1; height:1px" />

            <div class="row">
                <div class="col-lg-6">
                    <div class="input-group">
                        <g:textField type="text" id="search" name="search" class="form-control"  placeholder="Enter participant's GeL Id" required="" ></g:textField>
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-success" value="Find" onClick= 'getDNAExtract()'><span class="glyphicon glyphicon-search"></span> Find DNA Extract</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="${hasErrors(bean: DNA_LibraryInstance, field: 'na_extract', 'error')} ">
                <label for="na_extract" class="control-label"><g:message code="DNA_Library.na_extract.label" default="DNA Extract" /><span class="required-indicator">*</span></label>
                <div id="selectDNAExtract">
                    <g:select class=""  name="1" from="${''}" optionKey="" value="${''}" required=""/>
                </div>
            </div>

			<div class="${hasErrors(bean: DNA_LibraryInstance, field: 'exhausted', 'error')} ">
				<label for="exhausted" class="control-label"><g:message code="DNA_Library.exhausted.label" default="Exhausted" /></label>
				<div>
					<bs:checkBox name="exhausted" value="${DNA_LibraryInstance?.exhausted}" />
					<span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'exhausted', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: DNA_LibraryInstance, field: 'passFail', 'error')} ">
				<label for="passFail" class="control-label"><g:message code="DNA_Library.passFail.label" default="Pass Fail" /></label>
				<div>
					<bs:checkBox name="passFail" value="${DNA_LibraryInstance?.passFail}" />
					<span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'passFail', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_LibraryInstance, field: 'passFailReason', 'error')} ">
                        <label for="passFailReason" class="control-label"><g:message code="DNA_Library.passFailReason.label" default="Pass Fail Reason" /></label>
                        <div>
                            <g:textArea class="form-control" name="passFailReason" cols="40" rows="5" value="${DNA_LibraryInstance?.passFailReason}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'passFailReason', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_LibraryInstance, field: 'notes', 'error')} ">
                        <label for="notes" class="control-label"><g:message code="DNA_Library.notes.label" default="Notes" /></label>
                        <div>
                            <g:textArea class="form-control" name="notes" cols="40" rows="5" value="${DNA_LibraryInstance?.notes}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'notes', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_LibraryInstance, field: 'dNA_QC_qPCR', 'error')} ">
                        <label for="dNA_QC_qPCR" class="control-label"><g:message code="DNA_Library.dNA_QC_qPCR.label" default="DNA QC qPCR" /></label>
                        <div>
                            <g:field class="form-control" name="dNA_QC_qPCR" value="${fieldValue(bean: DNA_LibraryInstance, field: 'dNA_QC_qPCR')}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'dNA_QC_qPCR', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_LibraryInstance, field: 'dNAInputForLibraryPrep', 'error')} ">
                        <label for="dNAInputForLibraryPrep" class="control-label"><g:message code="DNA_Library.dNAInputForLibraryPrep.label" default="DNA Input For Library Prep" /></label>
                        <div>
                            <g:field class="form-control" name="dNAInputForLibraryPrep" value="${fieldValue(bean: DNA_LibraryInstance, field: 'dNAInputForLibraryPrep')}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'dNAInputForLibraryPrep', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_LibraryInstance, field: 'fragmentedDNASize', 'error')} required">
                        <label for="fragmentedDNASize" class="control-label"><g:message code="DNA_Library.fragmentedDNASize.label" default="Fragmented DNA Size" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="fragmentedDNASize" type="number" value="${DNA_LibraryInstance.fragmentedDNASize}" required=""/>
                            <span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'fragmentedDNASize', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_LibraryInstance, field: 'fragmentationProtocol', 'error')} ">
                        <label for="fragmentationProtocol" class="control-label"><g:message code="DNA_Library.fragmentationProtocol.label" default="Fragmentation Protocol" /></label>
                        <div>
                            <g:textField class="form-control" name="fragmentationProtocol" value="${DNA_LibraryInstance?.fragmentationProtocol}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'fragmentationProtocol', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_LibraryInstance, field: 'framentedDNAConcentration', 'error')} required">
                        <label for="framentedDNAConcentration" class="control-label"><g:message code="DNA_Library.framentedDNAConcentration.label" default="Framented DNA Concentration" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="framentedDNAConcentration" value="${fieldValue(bean: DNA_LibraryInstance, field: 'framentedDNAConcentration')}" required=""/>
                            <span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'framentedDNAConcentration', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_LibraryInstance, field: 'libraryConcentration', 'error')} required">
                        <label for="libraryConcentration" class="control-label"><g:message code="DNA_Library.libraryConcentration.label" default="Library Concentration" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="libraryConcentration" value="${fieldValue(bean: DNA_LibraryInstance, field: 'libraryConcentration')}" required=""/>
                            <span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'libraryConcentration', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_LibraryInstance, field: 'libraryPrepBy', 'error')} ">
                        <label for="libraryPrepBy" class="control-label"><g:message code="DNA_Library.libraryPrepBy.label" default="Library Prep By" /></label>
                        <div>
                            <g:select class="form-control" id="libraryPrepBy" name="libraryPrepBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${DNA_LibraryInstance?.libraryPrepBy?.id}"  noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'libraryPrepBy', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: DNA_LibraryInstance, field: 'barcode', 'error')} ">
                        <label for="barcode" class="control-label"><g:message code="DNA_Library.barcode.label" default="Barcode" /></label>
                        <div>
                            <g:textField class="form-control" name="barcode" value="${DNA_LibraryInstance?.barcode}"/>
                            <span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'barcode', 'error')}</span>
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
                            <p>No DNA Extract found with the Gel Id you entered</p>
                        </div>
                        <div class="modal-footer">
                            <a class='btn btn-primary btn-small' <g:link controller="DNA_Extract" action="create" ><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'DNA_Extract.label', default: 'DNA Extract')])}</g:link>
                            <button type="button" class="btn" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function getDNAExtract(){
        ${remoteFunction (controller: 'DNA_Library',
                        action: 'findDNAExtractByGeLId',
                        params: '"search=" + $("#search").val()',
                        update: 'selectDNAExtract',
                        onFailure:'error()'
                )}
    }

    function error(){
        var select = $("#selectDNAExtract");
        select.empty().append("Not found");
        $('#notFound').modal()
    }
</script>


