<%@ page import="geldb.Aliquot" %>


<g:if test="${aliquotInstance?.derivedFrom?.id !=null}">
    <div class="${hasErrors(bean: aliquotInstance, field: 'derivedFrom', 'error')} ">
        <label for="derivedFrom" class="control-label"><g:message code="aliquot.derivedFrom.label" default="Derived From" /></label>
        <div>
            <g:select class="form-control" id="derivedFrom" name="derivedFrom.id" from="${geldb.Derivation.list()}" optionKey="id" value="${aliquotInstance?.derivedFrom?.id}" class="many-to-one" noSelection="['null': '']"/>
            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'derivedFrom', 'error')}</span>
        </div>
    </div>
</g:if>
<g:if test="${aliquotInstance?.colocationWith?.id !=null}">			<div class="${hasErrors(bean: aliquotInstance, field: 'colocationWith', 'error')} ">
    <label for="colocationWith" class="control-label"><g:message code="aliquot.colocationWith.label" default="Colocation With" /></label>
    <div>
        <g:select class="form-control" id="colocationWith" name="colocationWith.id" from="${geldb.Colocation.list()}" optionKey="id" value="${aliquotInstance?.colocationWith?.id}" class="many-to-one" noSelection="['null': '']"/>
        <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'colocationWith', 'error')}</span>
    </div>
</div>
</g:if>

            <div class="${hasErrors(bean: aliquotInstance, field: 'specimen', 'error')} required">
                <label for="specimen" class="control-label"><g:message code="aliquot.specimen.label" default="Specimen" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="specimen" name="specimen.id" from="${geldb.Specimen.list()}" optionKey="id" required="" value="${aliquotInstance?.specimen?.id}" class="many-to-one"/>
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'specimen', 'error')}</span>
                </div>
            </div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: aliquotInstance, field: 'localIdentifier', 'error')} ">
				<label for="localIdentifier" class="control-label"><g:message code="aliquot.localIdentifier.label" default="Local Identifier" /></label>
				<div>
					<g:textField class="form-control" name="localIdentifier" value="${aliquotInstance?.localIdentifier}"/>
					<span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'localIdentifier', 'error')}</span>
				</div>
			</div>
    </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: aliquotInstance, field: 'size', 'error')} required">
				<label for="size" class="control-label"><g:message code="aliquot.size.label" default="Size" /><span class="required-indicator">*</span></label>
				<div>
					<g:field class="form-control" name="size" value="${fieldValue(bean: aliquotInstance, field: 'size')}" required=""/>
					<span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'size', 'error')}</span>
				</div>
			</div>
    </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: aliquotInstance, field: 'unit', 'error')} ">
				<label for="unit" class="control-label"><g:message code="aliquot.unit.label" default="Unit" /></label>
				<div>
					<g:textField class="form-control" name="unit" value="${aliquotInstance?.unit}"/>
					<span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'unit', 'error')}</span>
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

            <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotPhotograph', 'error')} ">
                <label for="aliquotPhotograph" class="control-label"><g:message code="aliquot.aliquotPhotograph.label" default="Aliquot Photograph" /></label>
                <div>
                    <input class="" type="file" id="aliquotPhotograph" name="aliquotPhotograph" />
                    <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotPhotograph', 'error')}</span>
                </div>
            </div>

<div class="row">
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
        <div class="${hasErrors(bean: aliquotInstance, field: 'sampleType', 'error')} required">
            <label for="sampleType" class="control-label"><g:message code="aliquot.sampleType.label" default="Sample Type" /><span class="required-indicator">*</span></label>
            <div>
                <g:select class="form-control" name="sampleType" from="${geldb.SampleType?.values()}" keys="${geldb.SampleType.values()*.name()}" required="" value="${aliquotInstance?.sampleType?.name()}"/>
                <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'sampleType', 'error')}</span>
            </div>
        </div>
    </div>
    <div class="col-lg-6">
        <div class="${hasErrors(bean: aliquotInstance, field: 'slideNumber', 'error')} ">
            <label for="slideNumber" class="control-label"><g:message code="aliquot.slideNumber.label" default="Slide Number" /></label>
            <div>
                <g:textField class="form-control" name="slideNumber" value="${aliquotInstance?.slideNumber}"/>
                <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'slideNumber', 'error')}</span>
            </div>
        </div>
    </div>
</div>
<div class="row">
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



			%{--<div class="${hasErrors(bean: aliquotInstance, field: 'dNA_Extract', 'error')} ">--}%
				%{--<label for="dNA_Extract" class="control-label"><g:message code="aliquot.dNA_Extract.label" default="D NA Extract" /></label>--}%
				%{--<div>--}%
					%{----}%
					%{--<span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'dNA_Extract', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: aliquotInstance, field: 'derivation', 'error')} ">--}%
				%{--<label for="derivation" class="control-label"><g:message code="aliquot.derivation.label" default="Derivation" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${aliquotInstance?.derivation?}" var="d">--}%
    %{--<li><g:link controller="derivation" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="derivation" action="create" params="['aliquot.id': aliquotInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'derivation.label', default: 'Derivation')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'derivation', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

