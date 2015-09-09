<%@ page import="geldb.DispatchItem" %>


            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: dispatchItemInstance, field: 'dispatchedBox', 'error')} required">
                        <label for="dispatchedBox" class="control-label"><g:message code="dispatchItem.dispatchedBox.label" default="Dispatched Box" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="dispatchedBox" name="dispatchedBox.id" from="${geldb.DispatchedBox.list()}" optionKey="id" required="" value="${dispatchItemInstance?.dispatchedBox?.id}"/>
                            <span class="help-inline">${hasErrors(bean: dispatchItemInstance, field: 'dispatchedBox', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: dispatchItemInstance, field: 'positionIfPlated', 'error')} ">
                        <label for="positionIfPlated" class="control-label"><g:message code="dispatchItem.positionIfPlated.label" default="Position If Plated" /></label>
                        <div>
                            <g:textField class="form-control" name="positionIfPlated" value="${dispatchItemInstance?.positionIfPlated}"/>
                            <span class="help-inline">${hasErrors(bean: dispatchItemInstance, field: 'positionIfPlated', 'error')}</span>
                        </div>
                    </div>
                </div>

                %{--<div class="col-lg-6">--}%
                    %{--<div class="${hasErrors(bean: dispatchItemInstance, field: 'volume_ul', 'error')} required">--}%
                        %{--<label for="volume_ul" class="control-label"><g:message code="dispatchItem.volume_ul.label" default="Volume ul" /><span class="required-indicator">*</span></label>--}%
                        %{--<div>--}%
                            %{--<g:field class="form-control" name="volume_ul" value="${fieldValue(bean: dispatchItemInstance, field: 'volume_ul')}" required=""/>--}%
                            %{--<span class="help-inline">${hasErrors(bean: dispatchItemInstance, field: 'volume_ul', 'error')}</span>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%
                <g:if test="${dispatchItemInstance?.identifiedSample?.id == null}">
                    <div class="col-lg-6">
                        <div class="">
                            <label for="barcode" class="control-label">Barcode<span class="required-indicator">*</span></label>
                            <div>
                                <g:field class="form-control" name="barcode" value="" required=""/>
                            </div>
                        </div>
                    </div>
                </g:if>
            </div>

            <g:if test="${dispatchItemInstance?.identifiedSample?.id != null}">
                <div class="${hasErrors(bean: dispatchItemInstance, field: 'identifiedSample', 'error')} required">
                    <label for="identifiedSample" class="control-label"><g:message code="dispatchItem.identifiedSample.label" default="Sample" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" id="identifiedSample" name="identifiedSample.id" from="${geldb.IdentifiedSample.list()}" optionKey="id" size="1"  required="" value="${dispatchItemInstance?.identifiedSample?.id}" class="many-to-many"/>
                        <span class="help-inline">${hasErrors(bean: dispatchItemInstance, field: 'identifiedSample', 'error')}</span>
                    </div>
                </div>
            </g:if>

%{--<g:javascript plugin="jquery" library="jquery" />--}%
%{--<script>--}%
    %{--function getSample(){--}%
        %{--var search=$("#search").val;--}%
        %{--var selectType=$("#sampleType").val;--}%
        %{--${remoteFunction (controller: 'dispatchItem',--}%
                        %{--action: 'findSampleByGeLId',--}%
                        %{--params: '\'search=\' + $("#search").val() + \'&selectType=\' + $("#sampleType").val()',--}%
                        %{--update: 'selectFoundSamples',--}%
                        %{--onFailure:'error()'--}%
                %{--)}--}%
    %{--}--}%

    %{--function error(){--}%
        %{--var select = $("#selectFoundSamples");--}%
        %{--select.empty().append("Not found");--}%
        %{--$('#notFound').modal()--}%

    %{--}--}%
%{--</script>--}%

