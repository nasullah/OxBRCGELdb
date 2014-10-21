<%@ page import="geldb.StaffRole; geldb.SolidSpecimenReport" %>



            <div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'solidSpecimen', 'error')} required">
                <label for="solidSpecimen" class="control-label"><g:message code="solidSpecimenReport.solidSpecimen.label" default="Solid Specimen" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="solidSpecimen" name="solidSpecimen.id" from="${geldb.SolidSpecimen.list()}" optionKey="id" required="" value="${solidSpecimenReportInstance?.solidSpecimen?.id}" class="many-to-one"/>
                    <span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'solidSpecimen', 'error')}</span>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'reportDate', 'error')} required">
                        <label for="reportDate" class="control-label"><g:message code="solidSpecimenReport.reportDate.label" default="Report Date" /><span class="required-indicator">*</span></label>
                        <div>
                            <bs:datePicker name="reportDate" precision="day"  value="${solidSpecimenReportInstance?.reportDate}"  />
                            <span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'reportDate', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'reportStaff', 'error')} required">
                        <label for="reportStaff" class="control-label"><g:message code="solidSpecimenReport.reportStaff.label" default="Report Staff" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="reportStaff" name="reportStaff.id" from="${geldb.StaffMember.findAllByStaffRole(StaffRole.findByRole('Pathologist'))}" optionKey="id" required="" value="${solidSpecimenReportInstance?.reportStaff?.id}" />
                            <span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'reportStaff', 'error')}</span>
                        </div>
                    </div>
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
                            <g:select class="form-control" id="stagingSystem" name="stagingSystem.id" from="${geldb.StagingSystem.list()}" optionKey="id" value="${solidSpecimenReportInstance?.stagingSystem?.id}"  noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'stagingSystem', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
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

			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'handE_created', 'error')} ">
				<label for="handE_created" class="control-label"><g:message code="solidSpecimenReport.handE_created.label" default="H and E created" /></label>
				<div>
					<bs:checkBox name="handE_created" value="${solidSpecimenReportInstance?.handE_created}" />
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'handE_created', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'handE_pathreview', 'error')} ">
				<label for="handE_pathreview" class="control-label"><g:message code="solidSpecimenReport.handE_pathreview.label" default="H and E path review" /></label>
				<div>
					<bs:checkBox name="handE_pathreview" value="${solidSpecimenReportInstance?.handE_pathreview}" />
					<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'handE_pathreview', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'vascularClampingTimeAtSurgery', 'error')} ">
                        <label for="vascularClampingTimeAtSurgery" class="control-label"><g:message code="solidSpecimenReport.vascularClampingTimeAtSurgery.label" default="Vascular Clamping Time At Surgery" /></label>
                        <div>
                            <g:textField class="form-control" name="vascularClampingTimeAtSurgery" value="${solidSpecimenReportInstance?.vascularClampingTimeAtSurgery}"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'vascularClampingTimeAtSurgery', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'warmIschemiaTimeIfClampingNotKnown', 'error')} ">
                        <label for="warmIschemiaTimeIfClampingNotKnown" class="control-label"><g:message code="solidSpecimenReport.warmIschemiaTimeIfClampingNotKnown.label" default="Warm Ischemia Time If Clamping Not Known" /></label>
                        <div>
                            <g:select class="form-control" name="warmIschemiaTimeIfClampingNotKnown" from="${geldb.WarmIschemiaTime?.values()}" keys="${geldb.WarmIschemiaTime.values()*.name()}" value="${solidSpecimenReportInstance?.warmIschemiaTimeIfClampingNotKnown?.name()}" noSelection="['': '']"/>
                            <span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'warmIschemiaTimeIfClampingNotKnown', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			%{--<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'postmortem', 'error')} ">--}%
				%{--<label for="postmortem" class="control-label"><g:message code="solidSpecimenReport.postmortem.label" default="Postmortem" /></label>--}%
				%{--<div>--}%
					%{--<g:select class="form-control" id="postmortem" name="postmortem.id" from="${geldb.Postmortem.list()}" optionKey="id" value="${solidSpecimenReportInstance?.postmortem?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'postmortem', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			%{--<div class="${hasErrors(bean: solidSpecimenReportInstance, field: 'samplePhoto', 'error')} ">--}%
				%{--<label for="samplePhoto" class="control-label"><g:message code="solidSpecimenReport.samplePhoto.label" default="Sample Photo" /></label>--}%
				%{--<div>--}%
					
%{--<ul class="one-to-many">--}%
%{--<g:each in="${solidSpecimenReportInstance?.samplePhoto?}" var="s">--}%
    %{--<li><g:link controller="samplePhoto" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="samplePhoto" action="create" params="['solidSpecimenReport.id': solidSpecimenReportInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'samplePhoto.label', default: 'SamplePhoto')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: solidSpecimenReportInstance, field: 'samplePhoto', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

