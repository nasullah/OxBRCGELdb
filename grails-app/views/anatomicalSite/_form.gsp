<%@ page import="geldb.AnatomicalSite" %>



            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: anatomicalSiteInstance, field: 'anatomicalSiteCode', 'error')} ">
                        <label for="anatomicalSiteCode" class="control-label"><g:message code="anatomicalSite.anatomicalSiteCode.label" default="Anatomical Site Code" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="anatomicalSiteCode" required="" value="${anatomicalSiteInstance?.anatomicalSiteCode}"/>
                            <span class="help-inline">${hasErrors(bean: anatomicalSiteInstance, field: 'anatomicalSiteCode', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: anatomicalSiteInstance, field: 'anatomicalSiteName', 'error')} ">
                        <label for="anatomicalSiteName" class="control-label"><g:message code="anatomicalSite.anatomicalSiteName.label" default="Anatomical Site Name" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="anatomicalSiteName" required="" value="${anatomicalSiteInstance?.anatomicalSiteName}"/>
                            <span class="help-inline">${hasErrors(bean: anatomicalSiteInstance, field: 'anatomicalSiteName', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: anatomicalSiteInstance, field: 'anatomicalSiteDescription', 'error')} ">
                        <label for="anatomicalSiteDescription" class="control-label"><g:message code="anatomicalSite.anatomicalSiteDescription.label" default="Anatomical Site Description" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="anatomicalSiteDescription" required="" value="${anatomicalSiteInstance?.anatomicalSiteDescription}"/>
                            <span class="help-inline">${hasErrors(bean: anatomicalSiteInstance, field: 'anatomicalSiteDescription', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

