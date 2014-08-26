<%@ page import="geldb.DNA_Extract" %>


            <div class="${hasErrors(bean: DNA_ExtractInstance, field: 'aliquot', 'error')} ">
                <label for="aliquot" class="control-label"><g:message code="DNA_Extract.aliquot.label" default="Aliquot" /></label>
                <div>
                    <g:select class="form-control" name="aliquot" from="${geldb.Aliquot.list()}" multiple="multiple" optionKey="id" size="5" value="${DNA_ExtractInstance?.aliquot*.id}" class="many-to-many"/>
                    <span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'aliquot', 'error')}</span>
                </div>
            </div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: DNA_ExtractInstance, field: 'localIdentifier', 'error')} ">
				<label for="localIdentifier" class="control-label"><g:message code="DNA_Extract.localIdentifier.label" default="Local Identifier" /></label>
				<div>
					<g:textField class="form-control" name="localIdentifier" value="${DNA_ExtractInstance?.localIdentifier}"/>
					<span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'localIdentifier', 'error')}</span>
				</div>
			</div>
    </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: DNA_ExtractInstance, field: 'size', 'error')} required">
				<label for="size" class="control-label"><g:message code="DNA_Extract.size.label" default="Size" /><span class="required-indicator">*</span></label>
				<div>
					<g:field class="form-control" name="size" value="${fieldValue(bean: DNA_ExtractInstance, field: 'size')}" required=""/>
					<span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'size', 'error')}</span>
				</div>
			</div>
    </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: DNA_ExtractInstance, field: 'unit', 'error')} ">
				<label for="unit" class="control-label"><g:message code="DNA_Extract.unit.label" default="Unit" /></label>
				<div>
					<g:textField class="form-control" name="unit" value="${DNA_ExtractInstance?.unit}"/>
					<span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'unit', 'error')}</span>
				</div>
			</div>
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
			<div class="${hasErrors(bean: DNA_ExtractInstance, field: 'notes', 'error')} ">
				<label for="notes" class="control-label"><g:message code="DNA_Extract.notes.label" default="Notes" /></label>
				<div>
					<g:textArea class="form-control" name="notes" cols="40" rows="5" value="${DNA_ExtractInstance?.notes}"/>
					<span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'notes', 'error')}</span>
				</div>
			</div>
    </div>
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

			<div class="${hasErrors(bean: DNA_ExtractInstance, field: 'extractionDate', 'error')} required">
				<label for="extractionDate" class="control-label"><g:message code="DNA_Extract.extractionDate.label" default="Extraction Date" /><span class="required-indicator">*</span></label>
				<div>
					<bs:datePicker name="extractionDate" precision="day"  value="${DNA_ExtractInstance?.extractionDate}"  />
					<span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'extractionDate', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: DNA_ExtractInstance, field: 'extractedBy', 'error')} ">
				<label for="extractedBy" class="control-label"><g:message code="DNA_Extract.extractedBy.label" default="Extracted By" /></label>
				<div>
					<g:select class="form-control" id="extractedBy" name="extractedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${DNA_ExtractInstance?.extractedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
					<span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'extractedBy', 'error')}</span>
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


			%{--<div class="${hasErrors(bean: DNA_ExtractInstance, field: 'dNA_Library', 'error')} ">--}%
				%{--<label for="dNA_Library" class="control-label"><g:message code="DNA_Extract.dNA_Library.label" default="D NA Library" /></label>--}%
				%{--<div>--}%
					%{----}%
					%{--<span class="help-inline">${hasErrors(bean: DNA_ExtractInstance, field: 'dNA_Library', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

