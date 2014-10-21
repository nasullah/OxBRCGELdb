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

<div class="${hasErrors(bean: aliquotInstance, field: 'specimen', 'error')} required">
    <label for="specimen" class="control-label"><g:message code="aliquot.specimen.label" default="Specimen" /><span class="required-indicator">*</span></label>
    <div>
        <g:select class="form-control" id="specimen" name="specimen.id" from="${geldb.Specimen.list()}" optionKey="id" required="" value="${aliquotInstance?.specimen?.id}" class="many-to-one"/>
        <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'specimen', 'error')}</span>
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

%{--<div class="${hasErrors(bean: aliquotInstance, field: 'position', 'error')} ">--}%
%{--<label for="position" class="control-label"><g:message code="aliquot.position.label" default="Position" /></label>--}%
%{--<div>--}%
%{--<g:select class="form-control" id="position" name="position.id" from="${geldb.Position.list()}" optionKey="id" value="${aliquotInstance?.position?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
%{--<span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'position', 'error')}</span>--}%
%{--</div>--}%
%{--</div>--}%

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

%{--<div class="${hasErrors(bean: aliquotInstance, field: 'aliquotReport', 'error')} ">--}%
%{--<label for="aliquotReport" class="control-label"><g:message code="aliquot.aliquotReport.label" default="Aliquot Report" /></label>--}%
%{--<div>--}%
%{--<g:select class="form-control" id="aliquotReport" name="aliquotReport.id" from="${geldb.AliquotReport.list()}" optionKey="id" value="${aliquotInstance?.aliquotReport?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
%{--<span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotReport', 'error')}</span>--}%
%{--</div>--}%
%{--</div>--}%

%{--<div class="${hasErrors(bean: aliquotInstance, field: 'colocationWith', 'error')} ">--}%
%{--<label for="colocationWith" class="control-label"><g:message code="aliquot.colocationWith.label" default="Colocation With" /></label>--}%
%{--<div>--}%
%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${aliquotInstance?.colocationWith?}" var="c">--}%
%{--<li><g:link controller="colocation" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="colocation" action="create" params="['aliquot.id': aliquotInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'colocation.label', default: 'Colocation')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

%{--<span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'colocationWith', 'error')}</span>--}%
%{--</div>--}%
%{--</div>--}%

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

