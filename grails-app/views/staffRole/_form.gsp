<%@ page import="geldb.StaffRole" %>


            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: staffRoleInstance, field: 'role', 'error')} ">
                        <label for="role" class="control-label"><g:message code="staffRole.role.label" default="Role" /></label>
                        <div>
                            <g:textField class="form-control" name="role" value="${staffRoleInstance?.role}"/>
                            <span class="help-inline">${hasErrors(bean: staffRoleInstance, field: 'role', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

