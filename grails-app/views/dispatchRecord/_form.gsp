<%@ page import="geldb.DispatchRecord" %>


            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: dispatchRecordInstance, field: 'destination', 'error')} required">
                        <label for="destination" class="control-label"><g:message code="dispatchRecord.destination.label" default="Destination" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="destination" name="destination.id" from="${geldb.Destination.list()}" onchange="getDestination()" optionKey="id" required="" value="${dispatchRecordInstance?.destination?.id}" noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: dispatchRecordInstance, field: 'destination', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-3">
                    <div class="${hasErrors(bean: dispatchRecordInstance, field: 'sentOn', 'error')} ">
                        <label for="sentOn" class="control-label"><g:message code="dispatchRecord.sentOn.label" default="Sent On" /></label>
                        <div>
                            <bs:datePicker name="sentOn" precision="day"  value="${dispatchRecordInstance?.sentOn}" default="none" noSelection="['': '']" />
                            <span class="help-inline">${hasErrors(bean: dispatchRecordInstance, field: 'sentOn', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3">
                    <div class="${hasErrors(bean: dispatchRecordInstance, field: 'receivedOn', 'error')} ">
                        <label for="receivedOn" class="control-label"><g:message code="dispatchRecord.receivedOn.label" default="Received On" /></label>
                        <div>
                            <bs:datePicker name="receivedOn" precision="day"  value="${dispatchRecordInstance?.receivedOn}" default="none" noSelection="['': '']" />
                            <span class="help-inline">${hasErrors(bean: dispatchRecordInstance, field: 'receivedOn', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: dispatchRecordInstance, field: 'fAO', 'error')} ">
                        <label for="fAO" class="control-label"><g:message code="dispatchRecord.fAO.label" default="For the attention of" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="fAO" value="${dispatchRecordInstance?.fAO}" required=""/>
                            <span class="help-inline">${hasErrors(bean: dispatchRecordInstance, field: 'fAO', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: dispatchRecordInstance, field: 'companyName', 'error')} ">
                        <label for="companyName" class="control-label"><g:message code="dispatchRecord.companyName.label" default="Company Name" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" id="companyName" name="companyName" value="${dispatchRecordInstance?.companyName}" required="" />
                            <span class="help-inline">${hasErrors(bean: dispatchRecordInstance, field: 'companyName', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: dispatchRecordInstance, field: 'consignmentNumber', 'error')} ">
                        <label for="consignmentNumber" class="control-label"><g:message code="dispatchRecord.consignmentNumber.label" default="Consignment Number" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" id="consignmentNumber" name="consignmentNumber" value="${dispatchRecordInstance?.consignmentNumber}" required="" />
                            <span class="help-inline">${hasErrors(bean: dispatchRecordInstance, field: 'consignmentNumber', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: dispatchRecordInstance, field: 'companyAddress', 'error')} ">
                        <label for="companyAddress" class="control-label"><g:message code="dispatchRecord.companyAddress.label" default="Company Address" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textArea class="form-control" id="companyAddress" name="companyAddress" cols="40" required="" rows="4" value="${dispatchRecordInstance?.companyAddress}"/>
                            <span class="help-inline">${hasErrors(bean: dispatchRecordInstance, field: 'companyAddress', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: dispatchRecordInstance, field: 'companyPostalCode', 'error')} ">
                        <label for="companyPostalCode" class="control-label"><g:message code="dispatchRecord.companyPostalCode.label" default="Company Postal Code" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" id="companyPostalCode" name="companyPostalCode" value="${dispatchRecordInstance?.companyPostalCode}" required="" />
                            <span class="help-inline">${hasErrors(bean: dispatchRecordInstance, field: 'companyPostalCode', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: dispatchRecordInstance, field: 'companyCountry', 'error')} ">
                        <label for="companyCountry" class="control-label"><g:message code="dispatchRecord.companyCountry.label" default="Company Country" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" id="companyCountry" name="companyCountry" value="${dispatchRecordInstance?.companyCountry}" required="" />
                            <span class="help-inline">${hasErrors(bean: dispatchRecordInstance, field: 'companyCountry', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function getDestination(){
        var baseUrl = "${createLink(controller:'dispatchRecord', action:'findDestination')}";
        var destinationId = $('#destination').val();
        var url = baseUrl + "?destinationId="+destinationId;
        $.ajax({
            url:url,
            type: 'POST',
            dataType: 'xml',
            async:true,
            success: function(res) {
                if (res){
                    $(res).find('destination').each(function(){
                        var companyName = $(this).find("companyName").text();
                        var companyAddress = $(this).find("companyAddress").text();
                        var companyPostalCode = $(this).find("companyPostalCode").text();
                        var companyCountry = $(this).find("companyCountry").text();
                        $('#companyName').val(companyName);
                        $('#companyAddress').val(companyAddress);
                        $('#companyPostalCode').val(companyPostalCode);
                        $('#companyCountry').val(companyCountry);
                    });
                }
            },
            error: function(request, status, error) {
                $('#companyName').val("");
                $('#companyAddress').val("");
                $('#companyPostalCode').val("");
                $('#companyCountry').val("");
            }
        });
    }
</script>
