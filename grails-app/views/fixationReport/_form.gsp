<%@ page import="geldb.FixationReport" %>



			%{--<div class="${hasErrors(bean: fixationReportInstance, field: 'aliquot', 'error')} required">--}%
				%{--<label for="aliquot" class="control-label"><g:message code="fixationReport.aliquot.label" default="Aliquot" /><span class="required-indicator">*</span></label>--}%
				%{--<div>--}%
					%{--<g:select class="form-control" id="aliquot" name="aliquot.id" from="${geldb.Aliquot.list()}" optionKey="id" required="" value="${fixationReportInstance?.aliquot?.id}" class="many-to-one"/>--}%
					%{--<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'aliquot', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

			<p><b>${fixationReportInstance?.aliquot}</b></p>
			<g:hiddenField name="aliquot.id" id="aliquot" value="${fixationReportInstance?.aliquot?.id}"/>

			<div class="row">
				<div class="col-lg-6">
					<div class="${hasErrors(bean: fixationReportInstance, field: 'reportDate', 'error')} required">
						<label for="reportDate" class="control-label"><g:message code="fixationReport.reportDate.label" default="Recorded Date" /><span class="required-indicator">*</span></label>
						<div>
							<bs:datePicker name="reportDate" precision="day"  value="${fixationReportInstance?.reportDate}"  />
							<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'reportDate', 'error')}</span>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="${hasErrors(bean: fixationReportInstance, field: 'reportStaff', 'error')} required">
						<label for="reportStaff" class="control-label"><g:message code="fixationReport.reportStaff.label" default="Recorded By" /><span class="required-indicator">*</span></label>
						<div>
							<g:select class="form-control" id="reportStaff" name="reportStaff.id" from="${geldb.StaffMember.findAllByStaffRole('Other').sort{it.staffName}}" optionKey="id" required="" value="${fixationReportInstance?.reportStaff?.id}" noSelection="['': '- Choose -']"/>
							<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'reportStaff', 'error')}</span>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="${hasErrors(bean: fixationReportInstance, field: 'fixationTypeAliquot', 'error')} ">
						<label for="fixationTypeAliquot" class="control-label"><g:message code="fixationReport.fixationTypeAliquot.label" default="Fixation Type" /></label>
						<div>
							<g:select class="form-control" name="fixationTypeAliquot" from="${geldb.FixationType?.values()}" keys="${geldb.FixationType.values()*.name()}" value="${fixationReportInstance?.fixationTypeAliquot?.name()}" noSelection="['': '- Choose -']"/>
							<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationTypeAliquot', 'error')}</span>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="${hasErrors(bean: fixationReportInstance, field: 'processingScheduleAliquot', 'error')} ">
						<label for="processingScheduleAliquot" class="control-label"><g:message code="fixationReport.processingScheduleAliquot.label" default="Processing Schedule" /></label>
						<div>
							<g:select class="form-control" name="processingScheduleAliquot" from="${geldb.ProcessingSchedule?.values()}" keys="${geldb.ProcessingSchedule.values()*.name()}" value="${fixationReportInstance?.processingScheduleAliquot?.name()}" noSelection="['': '- Choose -']"/>
							<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'processingScheduleAliquot', 'error')}</span>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-6">
					<div class="${hasErrors(bean: fixationReportInstance, field: 'fixationStartDateAliquot', 'error')} ">
						<label for="fixationStartDateAliquot" class="control-label"><g:message code="fixationReport.fixationStartDateAliquot.label" default="Fixation Start Date" /></label>
						<div>
							<bs:datePicker name="fixationStartDateAliquot" precision="day"  value="${fixationReportInstance?.fixationStartDateAliquot}" default="none" noSelection="['': '']" />
							<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationStartDateAliquot', 'error')}</span>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="${hasErrors(bean: fixationReportInstance, field: 'fixationStartTimeAliquot', 'error')} ">
						<label for="fixationStartTimeAliquot" class="control-label"><g:message code="fixationReport.fixationStartTimeAliquot.label" default="Fixation Start Time" /></label>
						<div>
							<g:field type="time" class="form-control" name="fixationStartTimeAliquot" value="${fixationReportInstance?.fixationStartTimeAliquot}"/>
							<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationStartTimeAliquot', 'error')}</span>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="${hasErrors(bean: fixationReportInstance, field: 'fixationEndDateAliquot', 'error')} ">
						<label for="fixationEndDateAliquot" class="control-label"><g:message code="fixationReport.fixationEndDateAliquot.label" default="Fixation End Date" /></label>
						<div>
							<bs:datePicker name="fixationEndDateAliquot" precision="day"  value="${fixationReportInstance?.fixationEndDateAliquot}" default="none" noSelection="['': '']" />
							<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationEndDateAliquot', 'error')}</span>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="${hasErrors(bean: fixationReportInstance, field: 'fixationEndTimeAliquot', 'error')} ">
						<label for="fixationEndTimeAliquot" class="control-label"><g:message code="fixationReport.fixationEndTimeAliquot.label" default="Fixation End Time" /></label>
						<div>
							<g:field type="time" class="form-control" name="fixationEndTimeAliquot" value="${fixationReportInstance?.fixationEndTimeAliquot}"/>
							<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationEndTimeAliquot', 'error')}</span>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="${hasErrors(bean: fixationReportInstance, field: 'fixationTimeUnknownAliquot', 'error')} ">
						<label for="fixationTimeUnknownAliquot" class="control-label"><g:message code="fixationReport.fixationTimeUnknownAliquot.label" default="Fixation Time Unknown" /></label>
						<div>
							<div>
								<g:radioGroup name="fixationTimeUnknownAliquot"
											  values="[true, false]"
											  labels="['Yes', 'No']"
											  value="${fixationReportInstance?.fixationTimeUnknownAliquot}">
									${it.label}  ${it.radio} &nbsp; &nbsp;
								</g:radioGroup>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="${hasErrors(bean: fixationReportInstance, field: 'fixationPeriodAliquot', 'error')} ">
						<label for="fixationPeriodAliquot" class="control-label"><g:message code="fixationReport.fixationPeriodAliquot.label" default="Fixation Period" /></label>
						<div>
							<g:select class="form-control" name="fixationPeriodAliquot" from="${geldb.Time12Hourly?.values()}" keys="${geldb.Time12Hourly.values()*.name()}" value="${fixationReportInstance?.fixationPeriodAliquot?.name()}" noSelection="['': '- Choose -']"/>
							<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationPeriodAliquot', 'error')}</span>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="${hasErrors(bean: fixationReportInstance, field: 'fixationCommentsAliquot', 'error')} ">
						<label for="fixationCommentsAliquot" class="control-label"><g:message code="fixationReport.fixationCommentsAliquot.label" default="Fixation Comments" /></label>
						<div>
							<g:textField class="form-control" name="fixationCommentsAliquot" value="${fixationReportInstance?.fixationCommentsAliquot}"/>
							<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'fixationCommentsAliquot', 'error')}</span>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="${hasErrors(bean: fixationReportInstance, field: 'tissueProcessorUsed', 'error')} required">
						<label for="tissueProcessorUsed" class="control-label"><g:message code="fixationReport.tissueProcessorUsed.label" default="Tissue Processor Used" /><span class="required-indicator">*</span></label>
						<div>
							<g:select class="form-control" id="tissueProcessorUsed" name="tissueProcessorUsed.id" from="${geldb.TissueProcessor.list().sort{it.tissueProcessorName}}" optionKey="id" required="" value="${fixationReportInstance?.tissueProcessorUsed?.id}" noSelection="['': '- Choose -']" />
							<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'tissueProcessorUsed', 'error')}</span>
						</div>
					</div>
				</div>

				<g:if test="${fixationReportInstance.aliquot.aliquotType.aliquotTypeName != 'Punch biopsy, PAXgene'}">
					<div class="col-lg-6">
						<div class="${hasErrors(bean: fixationReportInstance, field: 'timeInProcessor', 'error')} ">
							<label for="timeInProcessor" class="control-label"><g:message code="fixationReport.timeInProcessor.label" default="Time in formalin on processor (time in hours)" /></label>
							<div>
								<g:field type="number decimal" class="form-control" name="timeInProcessor" value="${fixationReportInstance?.timeInProcessor}"/>
								<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'timeInProcessor', 'error')}</span>
							</div>
						</div>
					</div>
				</g:if>

				<div class="col-lg-6">
					<div class="${hasErrors(bean: fixationReportInstance, field: 'comments', 'error')} ">
						<label for="comments" class="control-label"><g:message code="fixationReport.comments.label" default="Comments" /></label>
						<div>
							<g:textArea class="form-control" name="comments" cols="40" rows="4" value="${fixationReportInstance?.comments}"/>
							<span class="help-inline">${hasErrors(bean: fixationReportInstance, field: 'comments', 'error')}</span>
						</div>
					</div>
				</div>
			</div>
