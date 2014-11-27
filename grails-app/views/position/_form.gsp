<%@ page import="geldb.Position" %>


            <div class="${hasErrors(bean: positionInstance, field: 'identifiedSample', 'error')} required">
                <label for="identifiedSample" class="control-label"><g:message code="position.identifiedSample.label" default="Contained Item" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="identifiedSample" name="identifiedSample.id" from="${geldb.IdentifiedSample.list()}" optionKey="id" required="" value="${positionInstance?.identifiedSample?.id}" class="many-to-one"/>
                    <span class="help-inline">${hasErrors(bean: positionInstance, field: 'identifiedSample', 'error')}</span>
                </div>
            </div>

			<div class="${hasErrors(bean: positionInstance, field: 'plateOrBox', 'error')} required">
				<label for="plateOrBox" class="control-label"><g:message code="position.plateOrBox.label" default="Plate Or Box" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="plateOrBox" name="plateOrBox.id" from="${geldb.PlateOrBox.list()}" optionKey="id" required="" value="${positionInstance?.plateOrBox?.id}" class="many-to-one"/>
					<span class="help-inline">${hasErrors(bean: positionInstance, field: 'plateOrBox', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: positionInstance, field: 'letter', 'error')} ">
                        <label for="letter" class="control-label"><g:message code="position.letter.label" default="Letter" /></label>
                        <div>
                            <g:textField class="form-control" name="letter" value="${positionInstance?.letter}"/>
                            <span class="help-inline">${hasErrors(bean: positionInstance, field: 'letter', 'error')}</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: positionInstance, field: 'number', 'error')} ">
                        <label for="number" class="control-label"><g:message code="position.number.label" default="Number" /></label>
                        <div>
                            <g:textField class="form-control" name="number" value="${positionInstance?.number}"/>
                            <span class="help-inline">${hasErrors(bean: positionInstance, field: 'number', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>


