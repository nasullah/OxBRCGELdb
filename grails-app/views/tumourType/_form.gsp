<%@ page import="geldb.TumourType" %>


			<div class="${hasErrors(bean: tumourTypeInstance, field: 'tumourLocation', 'error')} required">
				<label for="tumourLocation" class="control-label"><g:message code="tumourType.tumourLocation.label" default="Tumour Location" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="tumourLocation" name="tumourLocation.id" from="${geldb.TumourLocation.list()}" optionKey="id" required="" value="${tumourTypeInstance?.tumourLocation?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: tumourTypeInstance, field: 'tumourLocation', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: tumourTypeInstance, field: 'tumourType', 'error')} ">
                        <label for="tumourType" class="control-label"><g:message code="tumourType.tumourType.label" default="Tumour Type" /></label>
                        <div>
                            <g:textField class="form-control" name="tumourType" value="${tumourTypeInstance?.tumourType}"/>
                            <span class="help-inline">${hasErrors(bean: tumourTypeInstance, field: 'tumourType', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

