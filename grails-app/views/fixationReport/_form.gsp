<%@ page import="geldb.StaffRole; geldb.FixationReport" %>



            <g:if test="${fixationReportInstance?.solidSpecimen?.id !=null}">
                <div class="${hasErrors(bean: fixationReportInstance, field: 'solidSpecimen', 'error')} ">
                    <label for="solidSpecimen" class="control-label"><g:message code="fixationReport.solidSpecimen.label" default="Solid Specimen" /></label>
                    <div>
                        <g:select class="form-control" id="solidSpecimen" name="solidSpecimen.id" from="${geldb.SolidSpecimen.list()}" optionKey="id" value="${fixationReportInstance?.solidSpecimen?.id}" class="many-to-one" noSelection="['null': '']"/>
                        <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'solidSpecimen', 'error')}</span>
                    </div>
                </div>
            </g:if>

            <g:if test="${fixationReportInstance?.derivation?.id !=null}">
                <div class="${hasErrors(bean: fixationReportInstance, field: 'derivation', 'error')} ">
                    <label for="derivation" class="control-label"><g:message code="fixationReport.derivation.label" default="Derivation" /></label>
                    <div>
                        <g:select class="form-control" id="derivation" name="derivation.id" from="${geldb.Derivation.list()}" optionKey="id" value="${fixationReportInstance?.derivation?.id}" class="many-to-one" noSelection="['null': '']"/>
                        <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'derivation', 'error')}</span>
                    </div>
                </div>
            </g:if>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fixationReportInstance, field: 'reportDate', 'error')} required">
                        <label for="reportDate" class="control-label"><g:message code="fixationReport.reportDate.label" default="Report Date" /><span class="required-indicator">*</span></label>
                        <div>
                            <bs:datePicker name="reportDate" precision="day"  value="${fixationReportInstance?.reportDate}"  />
                            <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'reportDate', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fixationReportInstance, field: 'reportStaff', 'error')} required">
                        <label for="reportStaff" class="control-label"><g:message code="fixationReport.reportStaff.label" default="Report Staff" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="reportStaff" name="reportStaff.id" from="${geldb.StaffMember.findAllByStaffRole(StaffRole.findByRole('Pathologist'))}"
                                      optionKey="id" required="" value="${fixationReportInstance?.reportStaff?.id}" />
                            <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'reportStaff', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fixationReportInstance, field: 'comments', 'error')} ">
                        <label for="comments" class="control-label"><g:message code="fixationReport.comments.label" default="Comments" /></label>
                        <div>
                            <g:textArea class="form-control" name="comments" cols="40" rows="5" value="${fixationReportInstance?.comments}"/>
                            <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'comments', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fixationReportInstance, field: 'fixationType', 'error')} required">
                        <label for="fixationType" class="control-label"><g:message code="fixationReport.fixationType.label" default="Fixation Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" name="fixationType" from="${geldb.FixationType?.values()}" keys="${geldb.FixationType.values()*.name()}" required="" value="${fixationReportInstance?.fixationType?.name()}"/>
                            <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationType', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fixationReportInstance, field: 'fixationStartDate', 'error')} required">
                        <label for="fixationStartDate" class="control-label"><g:message code="fixationReport.fixationStartDate.label" default="Fixation Start Date" /><span class="required-indicator">*</span></label>
                        <div>
                            <bs:datePicker name="fixationStartDate" precision="day"  value="${fixationReportInstance?.fixationStartDate}"  />
                            <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationStartDate', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fixationReportInstance, field: 'fixationStartTime', 'error')} ">
                        <label for="fixationStartTime" class="control-label"><g:message code="fixationReport.fixationStartTime.label" default="Fixation Start Time" /></label>
                        <div>
                            <g:textField class="form-control" name="fixationStartTime" value="${fixationReportInstance?.fixationStartTime}"/>
                            <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationStartTime', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fixationReportInstance, field: 'fixationEndDate', 'error')} required">
                        <label for="fixationEndDate" class="control-label"><g:message code="fixationReport.fixationEndDate.label" default="Fixation End Date" /></label>
                        <div>
                            <bs:datePicker name="fixationEndDate" precision="day"  value="${fixationReportInstance?.fixationEndDate}"  />
                            <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationEndDate', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fixationReportInstance, field: 'fixationEndTime', 'error')} ">
                        <label for="fixationEndTime" class="control-label"><g:message code="fixationReport.fixationEndTime.label" default="Fixation End Time" /></label>
                        <div>
                            <g:textField class="form-control" name="fixationEndTime" value="${fixationReportInstance?.fixationEndTime}"/>
                            <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationEndTime', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fixationReportInstance, field: 'fixationPeriod', 'error')} ">
                        <label for="fixationPeriod" class="control-label"><g:message code="fixationReport.fixationPeriod.label" default="Fixation Period" /></label>
                        <div>
                            <g:select class="form-control" id="fixationPeriod" name="fixationPeriod.id" from="${geldb.Period.list()}" optionKey="id" value="${fixationReportInstance?.fixationPeriod?.id}"  noSelection="['null': '']"/>
                            <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationPeriod', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			<div class="${hasErrors(bean: fixationReportInstance, field: 'fixationTimeUnknown', 'error')} ">
				<label for="fixationTimeUnknown" class="control-label"><g:message code="fixationReport.fixationTimeUnknown.label" default="Fixation Time Unknown" /></label>
				<div>
					<bs:checkBox name="fixationTimeUnknown" value="${fixationReportInstance?.fixationTimeUnknown}" />
					<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationTimeUnknown', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fixationReportInstance, field: 'fixationTimeApproximate', 'error')} ">
                        <label for="fixationTimeApproximate" class="control-label"><g:message code="fixationReport.fixationTimeApproximate.label" default="Fixation Time Approximate" /></label>
                        <div>
                            <g:select class="form-control" name="fixationTimeApproximate" from="${geldb.FixationTime?.values()}" keys="${geldb.FixationTime.values()*.name()}" value="${fixationReportInstance?.fixationTimeApproximate?.name()}" noSelection="['': '']"/>
                            <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationTimeApproximate', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fixationReportInstance, field: 'fixationProcessingSchedule', 'error')} ">
                        <label for="fixationProcessingSchedule" class="control-label"><g:message code="fixationReport.fixationProcessingSchedule.label" default="Fixation Processing Schedule" /></label>
                        <div>
                            <g:select class="form-control" name="fixationProcessingSchedule" from="${geldb.FixationProcessingSchedule?.values()}" keys="${geldb.FixationProcessingSchedule.values()*.name()}" value="${fixationReportInstance?.fixationProcessingSchedule?.name()}" noSelection="['': '']"/>
                            <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationProcessingSchedule', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: fixationReportInstance, field: 'fixationNote', 'error')} ">
                        <label for="fixationNote" class="control-label"><g:message code="fixationReport.fixationNote.label" default="Fixation Note" /></label>
                        <div>
                            <g:textArea class="form-control" name="fixationNote" cols="40" rows="5" value="${fixationReportInstance?.fixationNote}"/>
                            <span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationNote', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>



