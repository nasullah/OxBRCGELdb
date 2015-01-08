<%@ page import="geldb.StaffMember" %>



            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: staffMemberInstance, field: 'centre', 'error')} required">
                        <label for="centre" class="control-label"><g:message code="staffMember.centre.label" default="Centre" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="centre" name="centre.id" from="${geldb.Centre.list()}" optionKey="id" required="" value="${staffMemberInstance?.centre?.id}" />
                            <span class="help-inline">${hasErrors(bean: staffMemberInstance, field: 'centre', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: staffMemberInstance, field: 'staffRole', 'error')} required">
                        <label for="staffRole" class="control-label"><g:message code="staffMember.staffRole.label" default="Staff Role" /></label>
                        <div>
                            <g:select class="form-control" name="staffRole" from="${staffMemberInstance.constraints.staffRole.inList}" value="${staffMemberInstance?.staffRole}" valueMessagePrefix="staffMemberInstance.staffRole"  noSelection="['':'- Choose role -']"/>
                            <span class="help-inline">${hasErrors(bean: staffMemberInstance, field: 'staffRole', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: staffMemberInstance, field: 'staffName', 'error')} ">
                        <label for="staffName" class="control-label"><g:message code="staffMember.staffName.label" default="Staff Name" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="staffName" value="${staffMemberInstance?.staffName}" required=""/>
                            <span class="help-inline">${hasErrors(bean: staffMemberInstance, field: 'staffName', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

