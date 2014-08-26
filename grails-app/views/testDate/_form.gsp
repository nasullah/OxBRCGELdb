<%@ page import="geldb.TestDate" %>



			<div class="${hasErrors(bean: testDateInstance, field: 'date', 'error')} required">
				<label for="date" class="control-label"><g:message code="testDate.date.label" default="Date" /><span class="required-indicator">*</span></label>
				<div>
					<bs:datePicker name="date" precision="day"  value="${testDateInstance?.date}"  />
					<span class="help-inline">${hasErrors(bean: testDateInstance, field: 'date', 'error')}</span>
				</div>
			</div>

