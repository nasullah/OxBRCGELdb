<%@ page import="geldb.DNA_Library" %>


            <div class="${hasErrors(bean: DNA_LibraryInstance, field: 'na_extract', 'error')} ">
                <label for="na_extract" class="control-label"><g:message code="DNA_Library.na_extract.label" default="DNA Extract" /></label>
                <div>
                    <g:select class="form-control" name="na_extract" from="${geldb.DNA_Extract.list()}" multiple="multiple" optionKey="id" size="5" value="${DNA_LibraryInstance?.na_extract*.id}" class="many-to-many"/>
                    <span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'na_extract', 'error')}</span>
                </div>
            </div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: DNA_LibraryInstance, field: 'localIdentifier', 'error')} ">
				<label for="localIdentifier" class="control-label"><g:message code="DNA_Library.localIdentifier.label" default="Local Identifier" /></label>
				<div>
					<g:textField class="form-control" name="localIdentifier" value="${DNA_LibraryInstance?.localIdentifier}"/>
					<span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'localIdentifier', 'error')}</span>
				</div>
			</div>
    </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: DNA_LibraryInstance, field: 'size', 'error')} required">
				<label for="size" class="control-label"><g:message code="DNA_Library.size.label" default="Size" /><span class="required-indicator">*</span></label>
				<div>
					<g:field class="form-control" name="size" value="${fieldValue(bean: DNA_LibraryInstance, field: 'size')}" required=""/>
					<span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'size', 'error')}</span>
				</div>
			</div>
    </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: DNA_LibraryInstance, field: 'unit', 'error')} ">
				<label for="unit" class="control-label"><g:message code="DNA_Library.unit.label" default="Unit" /></label>
				<div>
					<g:textField class="form-control" name="unit" value="${DNA_LibraryInstance?.unit}"/>
					<span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'unit', 'error')}</span>
				</div>
			</div>
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
			<div class="${hasErrors(bean: DNA_LibraryInstance, field: 'notes', 'error')} ">
				<label for="notes" class="control-label"><g:message code="DNA_Library.notes.label" default="Notes" /></label>
				<div>
					<g:textArea class="form-control" name="notes" cols="40" rows="5" value="${DNA_LibraryInstance?.notes}"/>
					<span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'notes', 'error')}</span>
				</div>
			</div>
    </div>
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
</div>
<div class="row">
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
				<label for="framentedDNAConcentration" class="control-label"><g:message code="DNA_Library.framentedDNAConcentration.label" default="Fragmented DNA Concentration" /><span class="required-indicator">*</span></label>
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
					<g:select class="form-control" id="libraryPrepBy" name="libraryPrepBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${DNA_LibraryInstance?.libraryPrepBy?.id}" class="many-to-one" noSelection="['null': '']"/>
					<span class="help-inline">${hasErrors(bean: DNA_LibraryInstance, field: 'libraryPrepBy', 'error')}</span>
				</div>
			</div>
        </div>
</div>


