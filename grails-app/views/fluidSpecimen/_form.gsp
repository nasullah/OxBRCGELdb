<%@ page import="geldb.FluidSpecimen" %>


<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'participant', 'error')} required">
    <label for="participant" class="control-label"><g:message code="fluidSpecimen.participant.label" default="Participant" /><span class="required-indicator">*</span></label>
    <div>
        <g:select class="form-control" id="participant" name="participant.id" from="${geldb.Participant.list()}" optionKey="id" required="" value="${fluidSpecimenInstance?.participant?.id}" class="many-to-one"/>
        <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'participant', 'error')}</span>
    </div>
</div>
<div class="row">
    <div class="col-lg-6">
        <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'localIdentifier', 'error')} ">
            <label for="localIdentifier" class="control-label"><g:message code="fluidSpecimen.localIdentifier.label" default="Local Identifier" /></label>
            <div>
                <g:textField class="form-control" name="localIdentifier" value="${fluidSpecimenInstance?.localIdentifier}"/>
                <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'localIdentifier', 'error')}</span>
            </div>
        </div>
    </div>
    <div class="col-lg-6">
        <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'size', 'error')} required">
            <label for="size" class="control-label"><g:message code="fluidSpecimen.size.label" default="Size" /><span class="required-indicator">*</span></label>
            <div>
                <g:field class="form-control" name="size" value="${fieldValue(bean: fluidSpecimenInstance, field: 'size')}" required=""/>
                <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'size', 'error')}</span>
            </div>
        </div>
    </div>
    <div class="col-lg-6">
        <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'unit', 'error')} ">
            <label for="unit" class="control-label"><g:message code="fluidSpecimen.unit.label" default="Unit" /></label>
            <div>
                <g:textField class="form-control" name="unit" value="${fluidSpecimenInstance?.unit}"/>
                <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'unit', 'error')}</span>
            </div>
        </div>
    </div>
</div>

<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'exhausted', 'error')} ">
    <label for="exhausted" class="control-label"><g:message code="fluidSpecimen.exhausted.label" default="Exhausted" /></label>
    <div>
        <bs:checkBox name="exhausted" value="${fluidSpecimenInstance?.exhausted}" />
        <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'exhausted', 'error')}</span>
    </div>
</div>

<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'passFail', 'error')} ">
    <label for="passFail" class="control-label"><g:message code="fluidSpecimen.passFail.label" default="Pass Fail" /></label>
    <div>
        <bs:checkBox name="passFail" value="${fluidSpecimenInstance?.passFail}" />
        <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'passFail', 'error')}</span>
    </div>
</div>
<div class="row">
    <div class="col-lg-6">
        <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'notes', 'error')} ">
            <label for="notes" class="control-label"><g:message code="fluidSpecimen.notes.label" default="Notes" /></label>
            <div>
                <g:textArea class="form-control" name="notes" cols="40" rows="5" value="${fluidSpecimenInstance?.notes}"/>
                <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'notes', 'error')}</span>
            </div>
        </div>
    </div>
    <div class="col-lg-6">
        <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'histologyNumber', 'error')} ">
            <label for="histologyNumber" class="control-label"><g:message code="fluidSpecimen.histologyNumber.label" default="Histology Number" /></label>
            <div>
                <g:textField class="form-control" name="histologyNumber" value="${fluidSpecimenInstance?.histologyNumber}"/>
                <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'histologyNumber', 'error')}</span>
            </div>
        </div>
    </div>
    <div class="col-lg-6">
    <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectionTime', 'error')} ">
        <label for="collectionTime" class="control-label"><g:message code="fluidSpecimen.collectionTime.label" default="Collection Time" /></label>
        <div>
            <g:textField class="form-control" name="collectionTime" value="${fluidSpecimenInstance?.collectionTime}"/>
            <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectionTime', 'error')}</span>
        </div>
    </div>
    </div>
</div>

<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectionDate', 'error')} required">
    <label for="collectionDate" class="control-label"><g:message code="fluidSpecimen.collectionDate.label" default="Collection Date" /><span class="required-indicator">*</span></label>
    <div>
        <bs:datePicker name="collectionDate" precision="day"  value="${fluidSpecimenInstance?.collectionDate}"  />
        <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectionDate', 'error')}</span>
    </div>
</div>

<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectedBy', 'error')} ">
    <label for="collectedBy" class="control-label"><g:message code="fluidSpecimen.collectedBy.label" default="Collected By" /></label>
    <div>
        <g:select class="form-control" id="collectedBy" name="collectedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${fluidSpecimenInstance?.collectedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
        <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectedBy', 'error')}</span>
    </div>
</div>

<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'preparedBy', 'error')} ">
    <label for="preparedBy" class="control-label"><g:message code="fluidSpecimen.preparedBy.label" default="Prepared By" /></label>
    <div>
        <g:select class="form-control" id="preparedBy" name="preparedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${fluidSpecimenInstance?.preparedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
        <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'preparedBy', 'error')}</span>
    </div>
</div>
<div class="row">
    <div class="col-lg-6">
        <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectionLocation', 'error')} ">
            <label for="collectionLocation" class="control-label"><g:message code="fluidSpecimen.collectionLocation.label" default="Collection Location" /></label>
            <div>
                <g:textField class="form-control" name="collectionLocation" value="${fluidSpecimenInstance?.collectionLocation}"/>
                <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectionLocation', 'error')}</span>
            </div>
        </div>
    </div>
    <div class="col-lg-6">
        <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'sampleType', 'error')} required">
            <label for="sampleType" class="control-label"><g:message code="fluidSpecimen.sampleType.label" default="Sample Type" /><span class="required-indicator">*</span></label>
            <div>
                <g:select class="form-control" name="sampleType" from="${geldb.PrimarySampleType?.values()}" keys="${geldb.PrimarySampleType.values()*.name()}" required="" value="${fluidSpecimenInstance?.sampleType?.name()}"/>
                <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'sampleType', 'error')}</span>
            </div>
        </div>
    </div>
    <div class="col-lg-6">
        <div class="${hasErrors(bean: fluidSpecimenInstance, field: 'primaryContainerType', 'error')} ">
            <label for="primaryContainerType" class="control-label"><g:message code="fluidSpecimen.primaryContainerType.label" default="Primary Container Type" /></label>
            <div>
                <g:select class="form-control" name="primaryContainerType" from="${geldb.PrimaryContainerType?.values()}" keys="${geldb.PrimaryContainerType.values()*.name()}" value="${fluidSpecimenInstance?.primaryContainerType?.name()}" noSelection="['': '']"/>
                <span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'primaryContainerType', 'error')}</span>
            </div>
        </div>
    </div>
</div>

%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'aliquot', 'error')} ">--}%
%{--<label for="aliquot" class="control-label"><g:message code="fluidSpecimen.aliquot.label" default="Aliquot" /></label>--}%
%{--<div>--}%
%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${fluidSpecimenInstance?.aliquot?}" var="a">--}%
%{--<li><g:link controller="aliquot" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="aliquot" action="create" params="['fluidSpecimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Aliquot')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'aliquot', 'error')}</span>--}%
%{--</div>--}%
%{--</div>--}%

%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'postmortem', 'error')} ">--}%
%{--<label for="postmortem" class="control-label"><g:message code="fluidSpecimen.postmortem.label" default="Postmortem" /></label>--}%
%{--<div>--}%
%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${fluidSpecimenInstance?.postmortem?}" var="p">--}%
%{--<li><g:link controller="postmortem" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="postmortem" action="create" params="['fluidSpecimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'postmortem.label', default: 'Postmortem')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'postmortem', 'error')}</span>--}%
%{--</div>--}%
%{--</div>--}%

%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'report', 'error')} ">--}%
%{--<label for="report" class="control-label"><g:message code="fluidSpecimen.report.label" default="Report" /></label>--}%
%{--<div>--}%
%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${fluidSpecimenInstance?.report?}" var="r">--}%
%{--<li><g:link controller="report" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="report" action="create" params="['fluidSpecimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'report.label', default: 'Report')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'report', 'error')}</span>--}%
%{--</div>--}%
%{--</div>--}%

%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'trackingEvent', 'error')} ">--}%
%{--<label for="trackingEvent" class="control-label"><g:message code="fluidSpecimen.trackingEvent.label" default="Tracking Event" /></label>--}%
%{--<div>--}%
%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${fluidSpecimenInstance?.trackingEvent?}" var="t">--}%
%{--<li><g:link controller="sampleTrackingEvent" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="sampleTrackingEvent" action="create" params="['fluidSpecimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sampleTrackingEvent.label', default: 'SampleTrackingEvent')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'trackingEvent', 'error')}</span>--}%
%{--</div>--}%
%{--</div>--}%






%{--<%@ page import="geldb.FluidSpecimen" %>--}%



			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'localIdentifier', 'error')} ">--}%
				%{--<label for="localIdentifier" class="control-label"><g:message code="fluidSpecimen.localIdentifier.label" default="Local Identifier" /></label>--}%
				%{--<div>--}%
					%{--<g:textField class="form-control" name="localIdentifier" value="${fluidSpecimenInstance?.localIdentifier}"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'localIdentifier', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'size', 'error')} required">--}%
				%{--<label for="size" class="control-label"><g:message code="fluidSpecimen.size.label" default="Size" /><span class="required-indicator">*</span></label>--}%
				%{--<div>--}%
					%{--<g:field class="form-control" name="size" value="${fieldValue(bean: fluidSpecimenInstance, field: 'size')}" required=""/>--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'size', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'unit', 'error')} ">--}%
				%{--<label for="unit" class="control-label"><g:message code="fluidSpecimen.unit.label" default="Unit" /></label>--}%
				%{--<div>--}%
					%{--<g:textField class="form-control" name="unit" value="${fluidSpecimenInstance?.unit}"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'unit', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'exhausted', 'error')} ">--}%
				%{--<label for="exhausted" class="control-label"><g:message code="fluidSpecimen.exhausted.label" default="Exhausted" /></label>--}%
				%{--<div>--}%
					%{--<bs:checkBox name="exhausted" value="${fluidSpecimenInstance?.exhausted}" />--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'exhausted', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'passFail', 'error')} ">--}%
				%{--<label for="passFail" class="control-label"><g:message code="fluidSpecimen.passFail.label" default="Pass Fail" /></label>--}%
				%{--<div>--}%
					%{--<bs:checkBox name="passFail" value="${fluidSpecimenInstance?.passFail}" />--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'passFail', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'notes', 'error')} ">--}%
				%{--<label for="notes" class="control-label"><g:message code="fluidSpecimen.notes.label" default="Notes" /></label>--}%
				%{--<div>--}%
					%{--<g:textArea class="form-control" name="notes" cols="40" rows="5" value="${fluidSpecimenInstance?.notes}"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'notes', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'participant', 'error')} required">--}%
				%{--<label for="participant" class="control-label"><g:message code="fluidSpecimen.participant.label" default="Participant" /><span class="required-indicator">*</span></label>--}%
				%{--<div>--}%
					%{--<g:select class="form-control" id="participant" name="participant.id" from="${geldb.Participant.list()}" optionKey="id" required="" value="${fluidSpecimenInstance?.participant?.id}" class="many-to-one"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'participant', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'histologyNumber', 'error')} ">--}%
				%{--<label for="histologyNumber" class="control-label"><g:message code="fluidSpecimen.histologyNumber.label" default="Histology Number" /></label>--}%
				%{--<div>--}%
					%{--<g:textField class="form-control" name="histologyNumber" value="${fluidSpecimenInstance?.histologyNumber}"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'histologyNumber', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectionDate', 'error')} required">--}%
				%{--<label for="collectionDate" class="control-label"><g:message code="fluidSpecimen.collectionDate.label" default="Collection Date" /><span class="required-indicator">*</span></label>--}%
				%{--<div>--}%
					%{--<bs:datePicker name="collectionDate" precision="day"  value="${fluidSpecimenInstance?.collectionDate}"  />--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectionDate', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectionTime', 'error')} ">--}%
				%{--<label for="collectionTime" class="control-label"><g:message code="fluidSpecimen.collectionTime.label" default="Collection Time" /></label>--}%
				%{--<div>--}%
					%{--<g:textField class="form-control" name="collectionTime" value="${fluidSpecimenInstance?.collectionTime}"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectionTime', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectionLocation', 'error')} ">--}%
				%{--<label for="collectionLocation" class="control-label"><g:message code="fluidSpecimen.collectionLocation.label" default="Collection Location" /></label>--}%
				%{--<div>--}%
					%{--<g:textField class="form-control" name="collectionLocation" value="${fluidSpecimenInstance?.collectionLocation}"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectionLocation', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'collectedBy', 'error')} ">--}%
				%{--<label for="collectedBy" class="control-label"><g:message code="fluidSpecimen.collectedBy.label" default="Collected By" /></label>--}%
				%{--<div>--}%
					%{--<g:select class="form-control" id="collectedBy" name="collectedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${fluidSpecimenInstance?.collectedBy?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'collectedBy', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'preparedBy', 'error')} ">--}%
				%{--<label for="preparedBy" class="control-label"><g:message code="fluidSpecimen.preparedBy.label" default="Prepared By" /></label>--}%
				%{--<div>--}%
					%{--<g:select class="form-control" id="preparedBy" name="preparedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${fluidSpecimenInstance?.preparedBy?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'preparedBy', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'sampleType', 'error')} required">--}%
				%{--<label for="sampleType" class="control-label"><g:message code="fluidSpecimen.sampleType.label" default="Sample Type" /><span class="required-indicator">*</span></label>--}%
				%{--<div>--}%
					%{--<g:select class="form-control" name="sampleType" from="${geldb.PrimarySampleType?.values()}" keys="${geldb.PrimarySampleType.values()*.name()}" required="" value="${fluidSpecimenInstance?.sampleType?.name()}"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'sampleType', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'primaryContainerType', 'error')} ">--}%
				%{--<label for="primaryContainerType" class="control-label"><g:message code="fluidSpecimen.primaryContainerType.label" default="Primary Container Type" /></label>--}%
				%{--<div>--}%
					%{--<g:select class="form-control" name="primaryContainerType" from="${geldb.PrimaryContainerType?.values()}" keys="${geldb.PrimaryContainerType.values()*.name()}" value="${fluidSpecimenInstance?.primaryContainerType?.name()}" noSelection="['': '']"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'primaryContainerType', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'aliquot', 'error')} ">--}%
				%{--<label for="aliquot" class="control-label"><g:message code="fluidSpecimen.aliquot.label" default="Aliquot" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${fluidSpecimenInstance?.aliquot?}" var="a">--}%
    %{--<li><g:link controller="aliquot" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="aliquot" action="create" params="['fluidSpecimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Aliquot')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'aliquot', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'postmortem', 'error')} ">--}%
				%{--<label for="postmortem" class="control-label"><g:message code="fluidSpecimen.postmortem.label" default="Postmortem" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${fluidSpecimenInstance?.postmortem?}" var="p">--}%
    %{--<li><g:link controller="postmortem" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="postmortem" action="create" params="['fluidSpecimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'postmortem.label', default: 'Postmortem')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'postmortem', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'report', 'error')} ">--}%
				%{--<label for="report" class="control-label"><g:message code="fluidSpecimen.report.label" default="Report" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${fluidSpecimenInstance?.report?}" var="r">--}%
    %{--<li><g:link controller="report" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="report" action="create" params="['fluidSpecimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'report.label', default: 'Report')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'report', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: fluidSpecimenInstance, field: 'trackingEvent', 'error')} ">--}%
				%{--<label for="trackingEvent" class="control-label"><g:message code="fluidSpecimen.trackingEvent.label" default="Tracking Event" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${fluidSpecimenInstance?.trackingEvent?}" var="t">--}%
    %{--<li><g:link controller="sampleTrackingEvent" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="sampleTrackingEvent" action="create" params="['fluidSpecimen.id': fluidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sampleTrackingEvent.label', default: 'SampleTrackingEvent')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: fluidSpecimenInstance, field: 'trackingEvent', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

