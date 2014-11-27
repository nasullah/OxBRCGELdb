<%@ page import="geldb.CollectionMethod" %>



			<div class="${hasErrors(bean: collectionMethodInstance, field: 'collectionMethodName', 'error')} ">
				<label for="collectionMethodName" class="control-label"><g:message code="collectionMethod.collectionMethodName.label" default="Collection Method Name" /></label>
				<div>
					<g:textField class="form-control" name="collectionMethodName" value="${collectionMethodInstance?.collectionMethodName}"/>
					<span class="help-inline">${hasErrors(bean: collectionMethodInstance, field: 'collectionMethodName', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: collectionMethodInstance, field: 'collectionMethodDesc', 'error')} ">
				<label for="collectionMethodDesc" class="control-label"><g:message code="collectionMethod.collectionMethodDesc.label" default="Collection Method Desc" /></label>
				<div>
					<g:textField class="form-control" name="collectionMethodDesc" value="${collectionMethodInstance?.collectionMethodDesc}"/>
					<span class="help-inline">${hasErrors(bean: collectionMethodInstance, field: 'collectionMethodDesc', 'error')}</span>
				</div>
			</div>

