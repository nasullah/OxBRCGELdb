<%@ page import="geldb.Shelf" %>



			<div class="${hasErrors(bean: shelfInstance, field: 'freezer', 'error')} required">
				<label for="freezer" class="control-label"><g:message code="shelf.freezer.label" default="Freezer" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="freezer" name="freezer.id" from="${geldb.Freezer.list()}" optionKey="id" required="" value="${shelfInstance?.freezer?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: shelfInstance, field: 'freezer', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: shelfInstance, field: 'shelfName', 'error')} ">
                        <label for="shelfName" class="control-label"><g:message code="shelf.shelfName.label" default="Shelf/Tower Name" /></label>
                        <div>
                            <g:textField class="form-control" name="shelfName" value="${shelfInstance?.shelfName}"/>
                            <span class="help-inline">${hasErrors(bean: shelfInstance, field: 'shelfName', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>


