<%@ page import="geldb.Freezer" %>


        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: freezerInstance, field: 'centre', 'error')} required">
                    <label for="centre" class="control-label"><g:message code="freezerInstance.centre.label" default="Centre" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" id="centre" name="centre.id" from="${geldb.Centre.list()}" optionKey="id" required="" value="${freezerInstance?.centre?.id}" />
                        <span class="help-inline">${hasErrors(bean: freezerInstance, field: 'centre', 'error')}</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: freezerInstance, field: 'freezerName', 'error')} ">
                    <label for="freezerName" class="control-label"><g:message code="freezer.freezerName.label" default="Freezer Name" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:textField class="form-control" name="freezerName" required="" value="${freezerInstance?.freezerName}"/>
                        <span class="help-inline">${hasErrors(bean: freezerInstance, field: 'freezerName', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: freezerInstance, field: 'freezerTemperature', 'error')} ">
                    <label for="freezerTemperature" class="control-label"><g:message code="freezer.freezerTemperature.label" default="Freezer Temperature" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:textField class="form-control" name="freezerTemperature" required="" value="${freezerInstance?.freezerTemperature}"/>
                        <span class="help-inline">${hasErrors(bean: freezerInstance, field: 'freezerTemperature', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: freezerInstance, field: 'room', 'error')} ">
                    <label for="room" class="control-label"><g:message code="freezer.room.label" default="Room" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:textField class="form-control" name="room" required="" value="${freezerInstance?.room}"/>
                        <span class="help-inline">${hasErrors(bean: freezerInstance, field: 'room', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: freezerInstance, field: 'freezerNotes', 'error')} ">
                    <label for="freezerNotes" class="control-label"><g:message code="freezer.freezerNotes.label" default="Freezer Notes" /></label>
                    <div>
                        <g:textField class="form-control" name="freezerNotes" value="${freezerInstance?.freezerNotes}"/>
                        <span class="help-inline">${hasErrors(bean: freezerInstance, field: 'freezerNotes', 'error')}</span>
                    </div>
                </div>
            </div>
        </div>

			%{--<div class="${hasErrors(bean: freezerInstance, field: 'shelfs', 'error')} ">--}%
				%{--<label for="shelfs" class="control-label"><g:message code="freezer.shelfs.label" default="Shelfs" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${freezerInstance?.shelfs?}" var="s">--}%
    %{--<li><g:link controller="shelf" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="shelf" action="create" params="['freezer.id': freezerInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'shelf.label', default: 'Shelf')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: freezerInstance, field: 'shelfs', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

