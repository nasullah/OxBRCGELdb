<%@ page import="geldb.SolidSpecimenReport" %>



<g:if test="${solidSpecimenReportInstance?.solidSpecimen?.id !=null}">
    <div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'solidSpecimen', 'error')} ">
        <label for="solidSpecimen" class="control-label"><g:message code="solidSpecimenReport.solidSpecimen.label" default="Solid Specimen" /></label>
        <div>
            <g:select class="form-control" id="solidSpecimen" name="solidSpecimen.id" from="${geldb.SolidSpecimen.list()}" optionKey="id" value="${solidSpecimenReportInstance?.solidSpecimen?.id}" class="many-to-one" noSelection="['null': '']"/>
            <span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'solidSpecimen', 'error')}</span>
        </div>
    </div>
</g:if>

<g:if test="${solidSpecimenReportInstance?.derivation?.id !=null}">
    <div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'derivation', 'error')} ">
        <label for="derivation" class="control-label"><g:message code="solidSpecimenReport.derivation.label" default="Derivation" /></label>
        <div>
            <g:select class="form-control" id="derivation" name="derivation.id" from="${geldb.Derivation.list()}" optionKey="id" value="${solidSpecimenReportInstance?.derivation?.id}" class="many-to-one" noSelection="['null': '']"/>
            <span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'derivation', 'error')}</span>
        </div>
    </div>
</g:if>
<g:if test="${solidSpecimenReportInstance?.specimen?.id !=null}">
    <div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'specimen', 'error')} ">
        <label for="specimen" class="control-label"><g:message code="solidSpecimenReport.specimen.label" default="Specimen" /></label>
        <div>
            <g:select class="form-control" id="specimen" name="specimen.id" from="${geldb.Specimen.list()}" optionKey="id" value="${solidSpecimenReportInstance?.specimen?.id}" class="many-to-one" noSelection="['null': '']"/>
            <span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'specimen', 'error')}</span>
        </div>
    </div>
</g:if>

			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'reportDate', 'error')} required">
				<label for="reportDate" class="control-label"><g:message code="solidSpecimenReport.reportDate.label" default="Report Date" /><span class="required-indicator">*</span></label>
				<div>
					<bs:datePicker name="reportDate" precision="day"  value="${solidSpecimenReportInstance?.reportDate}"  />
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'reportDate', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'reportStaff', 'error')} required">
				<label for="reportStaff" class="control-label"><g:message code="solidSpecimenReport.reportStaff.label" default="Report Staff" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="reportStaff" name="reportStaff.id" from="${geldb.StaffMember.list()}" optionKey="id" required="" value="${solidSpecimenReportInstance?.reportStaff?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'reportStaff', 'error')}</span>
				</div>
			</div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'comments', 'error')} ">
				<label for="comments" class="control-label"><g:message code="solidSpecimenReport.comments.label" default="Comments" /></label>
				<div>
					<g:textArea class="form-control" name="comments" cols="40" rows="5" value="${solidSpecimenReportInstance?.comments}"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'comments', 'error')}</span>
				</div>
			</div>
        </div>
</div>

            <div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'sampleSitePhoto', 'error')} ">
                <label for="sampleSitePhoto" class="control-label"><g:message code="solidSpecimenReport.sampleSitePhoto.label" default="Sample Site Photo" /></label>
                <div>
                    <input class="" type="file" id="sampleSitePhoto" name="sampleSitePhoto" />
                    <span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'sampleSitePhoto', 'error')}</span>
                </div>
            </div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'percentageOfTumourInSample', 'error')} ">
				<label for="percentageOfTumourInSample" class="control-label"><g:message code="solidSpecimenReport.percentageOfTumourInSample.label" default="Percentage Of Tumour In Sample" /></label>
				<div>
					<g:field class="form-control" name="percentageOfTumourInSample" type="number" value="${solidSpecimenReportInstance.percentageOfTumourInSample}"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'percentageOfTumourInSample', 'error')}</span>
				</div>
			</div>
    </div>
        <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'cellularity', 'error')} ">
				<label for="cellularity" class="control-label"><g:message code="solidSpecimenReport.cellularity.label" default="Cellularity" /></label>
				<div>
					<g:select class="form-control" name="cellularity" from="${geldb.Cellularity?.values()}" keys="${geldb.Cellularity.values()*.name()}" value="${solidSpecimenReportInstance?.cellularity?.name()}" noSelection="['': '']"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'cellularity', 'error')}</span>
				</div>
			</div>
        </div>
        <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'stage', 'error')} ">
				<label for="stage" class="control-label"><g:message code="solidSpecimenReport.stage.label" default="Stage" /></label>
				<div>
					<g:textField class="form-control" name="stage" value="${solidSpecimenReportInstance?.stage}"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'stage', 'error')}</span>
				</div>
			</div>
        </div>
        <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'stagingSystem', 'error')} ">
				<label for="stagingSystem" class="control-label"><g:message code="solidSpecimenReport.stagingSystem.label" default="Staging System" /></label>
				<div>
					<g:textField class="form-control" name="stagingSystem" value="${solidSpecimenReportInstance?.stagingSystem}"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'stagingSystem', 'error')}</span>
				</div>
			</div>
        </div>
        <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'primaryOrMetastatic', 'error')} ">
				<label for="primaryOrMetastatic" class="control-label"><g:message code="solidSpecimenReport.primaryOrMetastatic.label" default="Primary Or Metastatic" /></label>
				<div>
					<g:select class="form-control" name="primaryOrMetastatic" from="${geldb.PrimaryOrMetastatic?.values()}" keys="${geldb.PrimaryOrMetastatic.values()*.name()}" value="${solidSpecimenReportInstance?.primaryOrMetastatic?.name()}" noSelection="['': '']"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'primaryOrMetastatic', 'error')}</span>
				</div>
			</div>
        </div>
</div>

			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'dysplasticNonInvasiveElements', 'error')} ">
				<label for="dysplasticNonInvasiveElements" class="control-label"><g:message code="solidSpecimenReport.dysplasticNonInvasiveElements.label" default="Dysplastic Non Invasive Elements" /></label>
				<div>
					<bs:checkBox name="dysplasticNonInvasiveElements" value="${solidSpecimenReportInstance?.dysplasticNonInvasiveElements}" />
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'dysplasticNonInvasiveElements', 'error')}</span>
				</div>
			</div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'dysplasticNonInvasiveNotes', 'error')} ">
				<label for="dysplasticNonInvasiveNotes" class="control-label"><g:message code="solidSpecimenReport.dysplasticNonInvasiveNotes.label" default="Dysplastic Non Invasive Notes" /></label>
				<div>
					<g:textArea class="form-control" name="dysplasticNonInvasiveNotes" cols="40" rows="5" value="${solidSpecimenReportInstance?.dysplasticNonInvasiveNotes}"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'dysplasticNonInvasiveNotes', 'error')}</span>
				</div>
			</div>
    </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'tumourContentVerifiedBy', 'error')} ">
				<label for="tumourContentVerifiedBy" class="control-label"><g:message code="solidSpecimenReport.tumourContentVerifiedBy.label" default="Tumour Content Verified By" /></label>
				<div>
					<g:select class="form-control" name="tumourContentVerifiedBy" from="${geldb.TumourContentVerification?.values()}" keys="${geldb.TumourContentVerification.values()*.name()}" value="${solidSpecimenReportInstance?.tumourContentVerifiedBy?.name()}" noSelection="['': '']"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'tumourContentVerifiedBy', 'error')}</span>
				</div>
			</div>
    </div>
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'tumourContentVerificationOther', 'error')} ">
				<label for="tumourContentVerificationOther" class="control-label"><g:message code="solidSpecimenReport.tumourContentVerificationOther.label" default="Tumour Content Verification Other" /></label>
				<div>
					<g:textField class="form-control" name="tumourContentVerificationOther" value="${solidSpecimenReportInstance?.tumourContentVerificationOther}"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'tumourContentVerificationOther', 'error')}</span>
				</div>
			</div>
    </div>
</div>

			%{--<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'instrumentsUsedByPathologist', 'error')} ">--}%
				%{--<label for="instrumentsUsedByPathologist" class="control-label"><g:message code="solidSpecimenReport.instrumentsUsedByPathologist.label" default="Instruments Used By Pathologist" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${solidSpecimenReportInstance?.instrumentsUsedByPathologist?}" var="i">--}%
    %{--<li><g:link controller="instrumentsUsedByPathologist" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="instrumentsUsedByPathologist" action="create" params="['solidSpecimenReport.id': solidSpecimenReportInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'instrumentsUsedByPathologist.label', default: 'InstrumentsUsedByPathologist')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'instrumentsUsedByPathologist', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'handE_created', 'error')} ">
				<label for="handE_created" class="control-label"><g:message code="solidSpecimenReport.handE_created.label" default="H and E created" /></label>
				<div>
					<bs:checkBox name="handE_created" value="${solidSpecimenReportInstance?.handE_created}" />
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'handE_created', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'handE_pathreview', 'error')} ">
				<label for="handE_pathreview" class="control-label"><g:message code="solidSpecimenReport.handE_pathreview.label" default="H and E pathreview" /></label>
				<div>
					<bs:checkBox name="handE_pathreview" value="${solidSpecimenReportInstance?.handE_pathreview}" />
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'handE_pathreview', 'error')}</span>
				</div>
			</div>
<div class="row">
    <div class="col-lg-6">
			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'failureReason', 'error')} ">
				<label for="failureReason" class="control-label"><g:message code="solidSpecimenReport.failureReason.label" default="Failure Reason" /></label>
				<div>
					<g:textArea class="form-control" name="failureReason" cols="40" rows="5" value="${solidSpecimenReportInstance?.failureReason}"/>
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'failureReason', 'error')}</span>
				</div>
			</div>
        </div>
</div>

