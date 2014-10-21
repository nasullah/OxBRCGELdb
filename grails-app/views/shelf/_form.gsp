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
                        <label for="shelfName" class="control-label"><g:message code="shelf.shelfName.label" default="Shelf Name" /></label>
                        <div>
                            <g:textField class="form-control" name="shelfName" value="${shelfInstance?.shelfName}"/>
                            <span class="help-inline">${hasErrors(bean: shelfInstance, field: 'shelfName', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			%{--<div class="${hasErrors(bean: shelfInstance, field: 'plateOrBox', 'error')} ">--}%
				%{--<label for="plateOrBox" class="control-label"><g:message code="shelf.plateOrBox.label" default="Plate Or Box" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${shelfInstance?.plateOrBox?}" var="p">--}%
    %{--<li><g:link controller="plateOrBox" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="plateOrBox" action="create" params="['shelf.id': shelfInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'plateOrBox.label', default: 'PlateOrBox')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: shelfInstance, field: 'plateOrBox', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

