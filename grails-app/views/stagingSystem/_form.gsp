<%@ page import="geldb.StagingSystem" %>



			<div class="${hasErrors(bean: stagingSystemInstance, field: 'stagingSystem', 'error')} ">
				<label for="stagingSystem" class="control-label"><g:message code="stagingSystem.stagingSystem.label" default="Staging System" /></label>
				<div>
					<g:textField class="form-control" name="stagingSystem" value="${stagingSystemInstance?.stagingSystem}"/>
					<span class="help-inline">${hasErrors(bean: stagingSystemInstance, field: 'stagingSystem', 'error')}</span>
				</div>
			</div>

