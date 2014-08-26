<%@ page import="geldb.Specimen" %>



			<div class="${hasErrors(bean: specimenInstance, field: 'localIdentifier', 'error')} ">
				<label for="localIdentifier" class="control-label"><g:message code="specimen.localIdentifier.label" default="Local Identifier" /></label>
				<div>
					<g:textField class="form-control" name="localIdentifier" value="${specimenInstance?.localIdentifier}"/>
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'localIdentifier', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'size', 'error')} required">
				<label for="size" class="control-label"><g:message code="specimen.size.label" default="Size" /><span class="required-indicator">*</span></label>
				<div>
					<g:field class="form-control" name="size" value="${fieldValue(bean: specimenInstance, field: 'size')}" required=""/>
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'size', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'unit', 'error')} ">
				<label for="unit" class="control-label"><g:message code="specimen.unit.label" default="Unit" /></label>
				<div>
					<g:textField class="form-control" name="unit" value="${specimenInstance?.unit}"/>
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'unit', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'exhausted', 'error')} ">
				<label for="exhausted" class="control-label"><g:message code="specimen.exhausted.label" default="Exhausted" /></label>
				<div>
					<bs:checkBox name="exhausted" value="${specimenInstance?.exhausted}" />
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'exhausted', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'passFail', 'error')} ">
				<label for="passFail" class="control-label"><g:message code="specimen.passFail.label" default="Pass Fail" /></label>
				<div>
					<bs:checkBox name="passFail" value="${specimenInstance?.passFail}" />
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'passFail', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'notes', 'error')} ">
				<label for="notes" class="control-label"><g:message code="specimen.notes.label" default="Notes" /></label>
				<div>
					<g:textArea class="form-control" name="notes" cols="40" rows="5" value="${specimenInstance?.notes}"/>
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'notes', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'participant', 'error')} required">
				<label for="participant" class="control-label"><g:message code="specimen.participant.label" default="Participant" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="participant" name="participant.id" from="${geldb.Participant.list()}" optionKey="id" required="" value="${specimenInstance?.participant?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'participant', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'histologyNumber', 'error')} ">
				<label for="histologyNumber" class="control-label"><g:message code="specimen.histologyNumber.label" default="Histology Number" /></label>
				<div>
					<g:textField class="form-control" name="histologyNumber" value="${specimenInstance?.histologyNumber}"/>
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'histologyNumber', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'collectionDate', 'error')} required">
				<label for="collectionDate" class="control-label"><g:message code="specimen.collectionDate.label" default="Collection Date" /><span class="required-indicator">*</span></label>
				<div>
					<bs:datePicker name="collectionDate" precision="day"  value="${specimenInstance?.collectionDate}"  />
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'collectionDate', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'collectionTime', 'error')} ">
				<label for="collectionTime" class="control-label"><g:message code="specimen.collectionTime.label" default="Collection Time" /></label>
				<div>
					<g:textField class="form-control" name="collectionTime" value="${specimenInstance?.collectionTime}"/>
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'collectionTime', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'collectionLocation', 'error')} ">
				<label for="collectionLocation" class="control-label"><g:message code="specimen.collectionLocation.label" default="Collection Location" /></label>
				<div>
					<g:textField class="form-control" name="collectionLocation" value="${specimenInstance?.collectionLocation}"/>
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'collectionLocation', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'collectedBy', 'error')} ">
				<label for="collectedBy" class="control-label"><g:message code="specimen.collectedBy.label" default="Collected By" /></label>
				<div>
					<g:select class="form-control" id="collectedBy" name="collectedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${specimenInstance?.collectedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'collectedBy', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'preparedBy', 'error')} ">
				<label for="preparedBy" class="control-label"><g:message code="specimen.preparedBy.label" default="Prepared By" /></label>
				<div>
					<g:select class="form-control" id="preparedBy" name="preparedBy.id" from="${geldb.StaffMember.list()}" optionKey="id" value="${specimenInstance?.preparedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'preparedBy', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'sampleType', 'error')} required">
				<label for="sampleType" class="control-label"><g:message code="specimen.sampleType.label" default="Sample Type" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" name="sampleType" from="${geldb.PrimarySampleType?.values()}" keys="${geldb.PrimarySampleType.values()*.name()}" required="" value="${specimenInstance?.sampleType?.name()}"/>
					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'sampleType', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'aliquot', 'error')} ">
				<label for="aliquot" class="control-label"><g:message code="specimen.aliquot.label" default="Aliquot" /></label>
				<div>
					
<ul class="one-to-many">
<g:each in="${specimenInstance?.aliquot?}" var="a">
    <li><g:link controller="aliquot" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="aliquot" action="create" params="['specimen.id': specimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Aliquot')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'aliquot', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'postmortem', 'error')} ">
				<label for="postmortem" class="control-label"><g:message code="specimen.postmortem.label" default="Postmortem" /></label>
				<div>
					
<ul class="one-to-many">
<g:each in="${specimenInstance?.postmortem?}" var="p">
    <li><g:link controller="postmortem" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="postmortem" action="create" params="['specimen.id': specimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'postmortem.label', default: 'Postmortem')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'postmortem', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'report', 'error')} ">
				<label for="report" class="control-label"><g:message code="specimen.report.label" default="Report" /></label>
				<div>
					
<ul class="one-to-many">
<g:each in="${specimenInstance?.report?}" var="r">
    <li><g:link controller="report" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="report" action="create" params="['specimen.id': specimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'report.label', default: 'Report')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'report', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: specimenInstance, field: 'trackingEvent', 'error')} ">
				<label for="trackingEvent" class="control-label"><g:message code="specimen.trackingEvent.label" default="Tracking Event" /></label>
				<div>
					
<ul class="one-to-many">
<g:each in="${specimenInstance?.trackingEvent?}" var="t">
    <li><g:link controller="sampleTrackingEvent" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="sampleTrackingEvent" action="create" params="['specimen.id': specimenInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sampleTrackingEvent.label', default: 'SampleTrackingEvent')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: specimenInstance, field: 'trackingEvent', 'error')}</span>
				</div>
			</div>

