<%@ page import="geldb.StaffMember" %>



			<div class="${hasErrors(bean: staffMemberInstance, field: 'staffName', 'error')} ">
				<label for="staffName" class="control-label"><g:message code="staffMember.staffName.label" default="Staff Name" /></label>
				<div>
					<g:textField class="form-control" name="staffName" value="${staffMemberInstance?.staffName}"/>
					<span class="help-inline">${hasErrors(bean: staffMemberInstance, field: 'staffName', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: staffMemberInstance, field: 'staffRole', 'error')} required">
				<label for="staffRole" class="control-label"><g:message code="staffMember.staffRole.label" default="Staff Role" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" name="staffRole" from="${geldb.StaffRole?.values()}" keys="${geldb.StaffRole.values()*.name()}" required="" value="${staffMemberInstance?.staffRole?.name()}"/>
					<span class="help-inline">${hasErrors(bean: staffMemberInstance, field: 'staffRole', 'error')}</span>
				</div>
			</div>

