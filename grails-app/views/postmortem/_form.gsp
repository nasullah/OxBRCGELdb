<%@ page import="geldb.Postmortem" %>



			<div class="${hasErrors(bean: postmortemInstance, field: 'solidSpecimenReport', 'error')} required">
				<label for="solidSpecimenReport" class="control-label"><g:message code="postmortem.solidSpecimenReport.label" default="Solid Specimen Report" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="solidSpecimenReport" name="solidSpecimenReport.id" from="${geldb.SolidSpecimenReport.list()}" optionKey="id" required="" value="${postmortemInstance?.solidSpecimenReport?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: postmortemInstance, field: 'solidSpecimenReport', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: postmortemInstance, field: 'delayInHours', 'error')} required">
                        <label for="delayInHours" class="control-label"><g:message code="postmortem.delayInHours.label" default="Delay In Hours" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:field class="form-control" name="delayInHours" type="number" value="${postmortemInstance.delayInHours}" required=""/>
                            <span class="help-inline">${hasErrors(bean: postmortemInstance, field: 'delayInHours', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: postmortemInstance, field: 'warmIschemiaTimeMin', 'error')} ">
                        <label for="warmIschemiaTimeMin" class="control-label"><g:message code="postmortem.warmIschemiaTimeMin.label" default="Warm Ischemia Time Min" /></label>
                        <div>
                            <g:field class="form-control" name="warmIschemiaTimeMin" value="${fieldValue(bean: postmortemInstance, field: 'warmIschemiaTimeMin')}"/>
                            <span class="help-inline">${hasErrors(bean: postmortemInstance, field: 'warmIschemiaTimeMin', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: postmortemInstance, field: 'coldIschemiaTimeMin', 'error')} ">
                        <label for="coldIschemiaTimeMin" class="control-label"><g:message code="postmortem.coldIschemiaTimeMin.label" default="Cold Ischemia Time Min" /></label>
                        <div>
                            <g:field class="form-control" name="coldIschemiaTimeMin" value="${fieldValue(bean: postmortemInstance, field: 'coldIschemiaTimeMin')}"/>
                            <span class="help-inline">${hasErrors(bean: postmortemInstance, field: 'coldIschemiaTimeMin', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

