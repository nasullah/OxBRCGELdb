<%@ page import="geldb.Report" %>


            <g:if test="${reportInstance?.derivation?.id !=null}">
                <div class="${hasErrors(bean: reportInstance, field: 'derivation', 'error')} ">
                    <label for="derivation" class="control-label"><g:message code="report.derivation.label" default="Derivation" /></label>
                    <div>
                        <g:select class="form-control" id="derivation" name="derivation.id" from="${geldb.Derivation.list()}" optionKey="id" value="${reportInstance?.derivation?.id}" class="many-to-one" noSelection="['null': '']"/>
                        <span class="help-inline">${hasErrors(bean: reportInstance, field: 'derivation', 'error')}</span>
                    </div>
                </div>
            </g:if>
            <g:if test="${reportInstance?.specimen?.id !=null}">
                <div class="${hasErrors(bean: reportInstance, field: 'specimen', 'error')} ">
                    <label for="specimen" class="control-label"><g:message code="report.specimen.label" default="Specimen" /></label>
                    <div>
                        <g:select class="form-control" id="specimen" name="specimen.id" from="${geldb.Specimen.list()}" optionKey="id" value="${reportInstance?.specimen?.id}" class="many-to-one" noSelection="['null': '']"/>
                        <span class="help-inline">${hasErrors(bean: reportInstance, field: 'specimen', 'error')}</span>
                    </div>
                </div>
            </g:if>
			<div class="${hasErrors(bean: reportInstance, field: 'reportDate', 'error')} required">
				<label for="reportDate" class="control-label"><g:message code="report.reportDate.label" default="Report Date" /><span class="required-indicator">*</span></label>
				<div>
					<bs:datePicker name="reportDate" precision="day"  value="${reportInstance?.reportDate}"  />
					<span class="help-inline">${hasErrors(bean: reportInstance, field: 'reportDate', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: reportInstance, field: 'reportStaff', 'error')} required">
				<label for="reportStaff" class="control-label"><g:message code="report.reportStaff.label" default="Report Staff" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="reportStaff" name="reportStaff.id" from="${geldb.StaffMember.list()}" optionKey="id" required="" value="${reportInstance?.reportStaff?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: reportInstance, field: 'reportStaff', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: reportInstance, field: 'comments', 'error')} ">
                        <label for="comments" class="control-label"><g:message code="report.comments.label" default="Comments" /></label>
                        <div>
                            <g:textArea class="form-control" name="comments" cols="40" rows="5" value="${reportInstance?.comments}"/>
                            <span class="help-inline">${hasErrors(bean: reportInstance, field: 'comments', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

