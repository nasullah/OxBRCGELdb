<%@ page import="geldb.SolidSpecimen" %>


            <div class="${hasErrors(bean: solidSpecimenInstance, field: 'participant', 'error')} required">
                <label for="participant" class="control-label"><g:message code="solidSpecimen.participant.label" default="Participant" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="participant" name="participant.id" from="${geldb.Participant.list()}" optionKey="id" required="" value="${solidSpecimenInstance?.participant?.id}" class="many-to-one"/>
                    <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'participant', 'error')}</span>
                </div>
            </div>

<div class="row">
    <div class="col-lg-6">
        <div class="${hasErrors(bean: solidSpecimenInstance, field: 'localIdentifier', 'error')} ">
            <label for="localIdentifier" class="control-label"><g:message code="solidSpecimen.localIdentifier.label" default="Local Identifier" /></label>
            <div>
                <g:textField class="form-control" name="localIdentifier" value="${solidSpecimenInstance?.localIdentifier}"/>
                <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'localIdentifier', 'error')}</span>
            </div>
        </div>
    </div>
    <div class="col-lg-6">
        <div class="${hasErrors(bean: solidSpecimenInstance, field: 'size', 'error')} required">
            <label for="size" class="control-label"><g:message code="solidSpecimen.size.label" default="Size" /><span class="required-indicator">*</span></label>
            <div>
                <g:field class="form-control" name="size" value="${fieldValue(bean: solidSpecimenInstance, field: 'size')}" required=""/>
                <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'size', 'error')}</span>
            </div>
        </div>
    </div>
    <div class="col-lg-6">
        <div class="${hasErrors(bean: solidSpecimenInstance, field: 'unit', 'error')} ">
            <label for="unit" class="control-label"><g:message code="solidSpecimen.unit.label" default="Unit" /></label>
            <div>
                <g:textField class="form-control" name="unit" value="${solidSpecimenInstance?.unit}"/>
                <span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'unit', 'error')}</span>
            </div>
        </div>
    </div>
</div>

			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'exhausted', 'error')} ">
				<label for="exhausted" class="control-label"><g:message code="solidSpecimen.exhausted.label" default="Exhausted" /></label>
				<div>
					<bs:checkBox name="exhausted" value="${solidSpecimenInstance?.exhausted}" />
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'exhausted', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'passFail', 'error')} ">
				<label for="passFail" class="control-label"><g:message code="solidSpecimen.passFail.label" default="Pass Fail" /></label>
				<div>
					<bs:checkBox name="passFail" value="${solidSpecimenInstance?.passFail}" />
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'passFail', 'error')}</span>
				</div>
			</div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'notes', 'error')} ">
				<label for="notes" class="control-label"><g:message code="solidSpecimen.notes.label" default="Notes" /></label>
				<div>
					<g:textArea class="form-control" name="notes" cols="40" rows="5" value="${solidSpecimenInstance?.notes}"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'notes', 'error')}</span>
				</div>
			</div>
    </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'histologyNumber', 'error')} ">
				<label for="histologyNumber" class="control-label"><g:message code="solidSpecimen.histologyNumber.label" default="Histology Number" /></label>
				<div>
					<g:textField class="form-control" name="histologyNumber" value="${solidSpecimenInstance?.histologyNumber}"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'histologyNumber', 'error')}</span>
				</div>
			</div>
    </div>
</div>

			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'collectionDate', 'error')} required">
				<label for="collectionDate" class="control-label"><g:message code="solidSpecimen.collectionDate.label" default="Collection Date" /><span class="required-indicator">*</span></label>
				<div>
					<bs:datePicker name="collectionDate" precision="day"  value="${solidSpecimenInstance?.collectionDate}"  />
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'collectionDate', 'error')}</span>
				</div>
			</div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'collectionTime', 'error')} ">
				<label for="collectionTime" class="control-label"><g:message code="solidSpecimen.collectionTime.label" default="Collection Time" /></label>
				<div>
					<g:textField class="form-control" name="collectionTime" value="${solidSpecimenInstance?.collectionTime}"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'collectionTime', 'error')}</span>
				</div>
			</div>
    </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'collectionLocation', 'error')} ">
				<label for="collectionLocation" class="control-label"><g:message code="solidSpecimen.collectionLocation.label" default="Collection Location" /></label>
				<div>
					<g:textField class="form-control" name="collectionLocation" value="${solidSpecimenInstance?.collectionLocation}"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'collectionLocation', 'error')}</span>
				</div>
			</div>
    </div>
</div>

			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'collectedBy', 'error')} ">
				<label for="collectedBy" class="control-label"><g:message code="solidSpecimen.collectedBy.label" default="Collected By" /></label>
				<div>
					<g:select class="form-control" id="collectedBy" name="collectedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${solidSpecimenInstance?.collectedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'collectedBy', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'preparedBy', 'error')} ">
				<label for="preparedBy" class="control-label"><g:message code="solidSpecimen.preparedBy.label" default="Prepared By" /></label>
				<div>
					<g:select class="form-control" id="preparedBy" name="preparedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${solidSpecimenInstance?.preparedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'preparedBy', 'error')}</span>
				</div>
			</div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'sampleType', 'error')} required">
				<label for="sampleType" class="control-label"><g:message code="solidSpecimen.sampleType.label" default="Sample Type" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" name="sampleType" from="${geldb.PrimarySampleType?.values()}" keys="${geldb.PrimarySampleType.values()*.name()}" required="" value="${solidSpecimenInstance?.sampleType?.name()}"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'sampleType', 'error')}</span>
				</div>
			</div>
        </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'anatomicSite', 'error')} ">
				<label for="anatomicSite" class="control-label"><g:message code="solidSpecimen.anatomicSite.label" default="Anatomic Site" /></label>
				<div>
					<g:select class="form-control" name="anatomicSite" from="${geldb.SampleSite?.values()}" keys="${geldb.SampleSite.values()*.name()}" value="${solidSpecimenInstance?.anatomicSite?.name()}" noSelection="['': '']"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'anatomicSite', 'error')}</span>
				</div>
			</div>
        </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'collectionMethod', 'error')} ">
				<label for="collectionMethod" class="control-label"><g:message code="solidSpecimen.collectionMethod.label" default="Collection Method" /></label>
				<div>
					<g:select class="form-control" name="collectionMethod" from="${geldb.CollectionMethodType?.values()}" keys="${geldb.CollectionMethodType.values()*.name()}" value="${solidSpecimenInstance?.collectionMethod?.name()}" noSelection="['': '']"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'collectionMethod', 'error')}</span>
				</div>
			</div>
        </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'vasculerClampingTimeAtSurgery', 'error')} ">
				<label for="vasculerClampingTimeAtSurgery" class="control-label"><g:message code="solidSpecimen.vasculerClampingTimeAtSurgery.label" default="Vasculer Clamping Time At Surgery" /></label>
				<div>
					<g:textField class="form-control" name="vasculerClampingTimeAtSurgery" value="${solidSpecimenInstance?.vasculerClampingTimeAtSurgery}"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'vasculerClampingTimeAtSurgery', 'error')}</span>
				</div>
			</div>
        </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'warmIschemiaTimeIfClampingNotKnown', 'error')} ">
				<label for="warmIschemiaTimeIfClampingNotKnown" class="control-label"><g:message code="solidSpecimen.warmIschemiaTimeIfClampingNotKnown.label" default="Warm Ischemia Time If Clamping Not Known" /></label>
				<div>
					<g:select class="form-control" name="warmIschemiaTimeIfClampingNotKnown" from="${geldb.WarmIschemiaTime?.values()}" keys="${geldb.WarmIschemiaTime.values()*.name()}" value="${solidSpecimenInstance?.warmIschemiaTimeIfClampingNotKnown?.name()}" noSelection="['': '']"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'warmIschemiaTimeIfClampingNotKnown', 'error')}</span>
				</div>
			</div>
        </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenInstance, field: 'methodOfTransportToPathologist', 'error')} ">
				<label for="methodOfTransportToPathologist" class="control-label"><g:message code="solidSpecimen.methodOfTransportToPathologist.label" default="Method Of Transport To Pathologist" /></label>
				<div>
					<g:select class="form-control" name="methodOfTransportToPathologist" from="${geldb.MethodOfTransport?.values()}" keys="${geldb.MethodOfTransport.values()*.name()}" value="${solidSpecimenInstance?.methodOfTransportToPathologist?.name()}" noSelection="['': '']"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'methodOfTransportToPathologist', 'error')}</span>
				</div>
			</div>
        </div>
</div>

			%{--<div class="${hasErrors(bean: solidSpecimenInstance, field: 'fixationReport', 'error')} ">--}%
				%{--<label for="fixationReport" class="control-label"><g:message code="solidSpecimen.fixationReport.label" default="Fixation Report" /></label>--}%
				%{--<div>--}%
					%{--<g:select class="form-control" id="fixationReport" name="fixationReport.id" from="${geldb.FixationReport.list()}" optionKey="id" value="${solidSpecimenInstance?.fixationReport?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'fixationReport', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: solidSpecimenInstance, field: 'solidSpecimenReport', 'error')} ">--}%
				%{--<label for="solidSpecimenReport" class="control-label"><g:message code="solidSpecimen.solidSpecimenReport.label" default="Solid Specimen Report" /></label>--}%
				%{--<div>--}%
					%{--<g:select class="form-control" id="solidSpecimenReport" name="solidSpecimenReport.id" from="${geldb.SolidSpecimenReport.list()}" optionKey="id" value="${solidSpecimenInstance?.solidSpecimenReport?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'solidSpecimenReport', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: solidSpecimenInstance, field: 'aliquot', 'error')} ">--}%
				%{--<label for="aliquot" class="control-label"><g:message code="solidSpecimen.aliquot.label" default="Aliquot" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${solidSpecimenInstance?.aliquot?}" var="a">--}%
    %{--<li><g:link controller="aliquot" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="aliquot" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Aliquot')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'aliquot', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: solidSpecimenInstance, field: 'postmortem', 'error')} ">--}%
				%{--<label for="postmortem" class="control-label"><g:message code="solidSpecimen.postmortem.label" default="Postmortem" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${solidSpecimenInstance?.postmortem?}" var="p">--}%
    %{--<li><g:link controller="postmortem" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="postmortem" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'postmortem.label', default: 'Postmortem')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'postmortem', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: solidSpecimenInstance, field: 'report', 'error')} ">--}%
				%{--<label for="report" class="control-label"><g:message code="solidSpecimen.report.label" default="Report" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${solidSpecimenInstance?.report?}" var="r">--}%
    %{--<li><g:link controller="report" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="report" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'report.label', default: 'Report')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'report', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: solidSpecimenInstance, field: 'trackingEvent', 'error')} ">--}%
				%{--<label for="trackingEvent" class="control-label"><g:message code="solidSpecimen.trackingEvent.label" default="Tracking Event" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${solidSpecimenInstance?.trackingEvent?}" var="t">--}%
    %{--<li><g:link controller="sampleTrackingEvent" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="sampleTrackingEvent" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sampleTrackingEvent.label', default: 'SampleTrackingEvent')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: solidSpecimenInstance, field: 'trackingEvent', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

