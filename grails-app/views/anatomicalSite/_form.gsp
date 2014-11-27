<%@ page import="geldb.AnatomicalSite" %>



			<div class="${hasErrors(bean: anatomicalSiteInstance, field: 'anatomicalSiteCode', 'error')} ">
				<label for="anatomicalSiteCode" class="control-label"><g:message code="anatomicalSite.anatomicalSiteCode.label" default="Anatomical Site Code" /></label>
				<div>
					<g:textField class="form-control" name="anatomicalSiteCode" value="${anatomicalSiteInstance?.anatomicalSiteCode}"/>
					<span class="help-inline">${hasErrors(bean: anatomicalSiteInstance, field: 'anatomicalSiteCode', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: anatomicalSiteInstance, field: 'anatomicalSiteName', 'error')} ">
				<label for="anatomicalSiteName" class="control-label"><g:message code="anatomicalSite.anatomicalSiteName.label" default="Anatomical Site Name" /></label>
				<div>
					<g:textField class="form-control" name="anatomicalSiteName" value="${anatomicalSiteInstance?.anatomicalSiteName}"/>
					<span class="help-inline">${hasErrors(bean: anatomicalSiteInstance, field: 'anatomicalSiteName', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: anatomicalSiteInstance, field: 'anatomicalSiteDescription', 'error')} ">
				<label for="anatomicalSiteDescription" class="control-label"><g:message code="anatomicalSite.anatomicalSiteDescription.label" default="Anatomical Site Description" /></label>
				<div>
					<g:textField class="form-control" name="anatomicalSiteDescription" value="${anatomicalSiteInstance?.anatomicalSiteDescription}"/>
					<span class="help-inline">${hasErrors(bean: anatomicalSiteInstance, field: 'anatomicalSiteDescription', 'error')}</span>
				</div>
			</div>

