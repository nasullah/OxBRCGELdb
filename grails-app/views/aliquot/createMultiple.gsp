<%@ page import="geldb.UnitType; geldb.Aliquot" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Create Multiple Aliquots</title>
</head>

<body>

<section id="create-aliquot" class="first">

    <g:hasErrors bean="${aliquotInstance}">
        <div class="alert alert-danger">
            <g:renderErrors bean="${aliquotInstance}" as="list" />
        </div>
    </g:hasErrors>

    <g:form action="saveMultiple" method="post" class="form-horizontal" role="form">

        <div class="row">
            <div class="col-lg-6">
                <label class="control-label">Number of Aliquots<span class="required-indicator">*</span></label>
                <g:select class="form-control" id="aliquotNumber" name="aliquotNumber" from="${['1','2','3','4','5','6','7','8','9','10']}" required="" onchange="getAliquotNumber()" noSelection="['':'- Choose -']"/>
            </div>
        </div>

        <hr style="border:1; height:1px" />

        <div class="row">
            <div class="col-lg-6">
                <div class="input-group">
                    <g:textField type="text" id="search" name="search" class="form-control"  placeholder="GEL000" required="" ></g:textField>
                    <div class="input-group-btn">
                        <button type="button" class="btn btn-success" value="Find" onClick= 'getSpecimen()'><span class="glyphicon glyphicon-search"></span> Find Specimen</button>
                    </div>
                </div>
            </div>
        </div>
        <p>
        <div id="selectSpecimen"></div>

        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotType', 'error')} required">
                    <label for="aliquotType" class="control-label"><g:message code="aliquot.aliquotType.label" default="Aliquot Type" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" id="aliquotType" name="aliquotType.id" from="${geldb.AliquotType.list().sort{it.aliquotTypeName}}" optionKey="id" required="" value="${aliquotInstance?.aliquotType?.id}" noSelection="['':'- Choose -']" onchange="preFillCreatedOnFFAliquot()"/>
                        <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotType', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6" id="showCreatedOn">
                <div class="${hasErrors(bean: aliquotInstance, field: 'createdOn', 'error')} required">
                    <label for="createdOn" class="control-label"><g:message code="FFPE_Tissue_Report.createdOn.label" default="Created on" /></label>
                    <div>
                        <bs:datePicker id="createdOn" name="createdOn" precision="day"  value="${aliquotInstance?.createdOn}" default="none" noSelection="['': '']"/>
                        <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'createdOn', 'error')}</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="${hasErrors(bean: aliquotInstance, field: 'blockNumber', 'error')} ">
                    <label for="blockNumber" class="control-label"><g:message code="aliquot.blockNumber.label" default="Block number (in this format: path number, block number, size (small/XL))" /></label>
                    <div>
                        <g:textField class="form-control" id="blockNumber" name="blockNumber" value="${aliquotInstance?.blockNumber}" />
                        <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'blockNumber', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: aliquotInstance, field: 'aliquotRanking', 'error')} ">
                    <label for="aliquotRanking" class="control-label"><g:message code="aliquot.aliquotRanking.label" default="Aliquot Ranking" /></label>
                    <div>
                        <g:select class="form-control" name="aliquotRanking" from="${aliquotInstance.constraints.aliquotRanking.inList}" value="${aliquotInstance?.aliquotRanking}" valueMessagePrefix="aliquot.aliquotRanking"  noSelection="['':'- Choose -']"/>
                        <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'aliquotRanking', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: aliquotInstance, field: 'frozenBy', 'error')} required" id="frozenByWithLabel">
                    <label for="frozenBy" class="control-label"><g:message code="aliquot.frozenBy.label" default="Frozen By (frozen sample only)" /></label>
                    <div>
                        <g:select class="form-control" id="frozenBy" name="frozenBy" from="${geldb.FrozenBy?.values()}" keys="${geldb.FrozenBy.values()*.name()}" value="${aliquotInstance?.frozenBy?.name()}" noSelection="['':'- Choose -']"/>
                        <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'frozenBy', 'error')}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="${hasErrors(bean: aliquotInstance, field: 'notes', 'error')} ">
                    <label for="notes" class="control-label"><g:message code="aliquot.notes.label" default="Notes" /></label>
                    <div>
                        <g:textArea class="form-control" name="notes" cols="40" rows="4" value="${aliquotInstance?.notes}"/>
                        <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'notes', 'error')}</span>
                    </div>
                </div>
            </div>
        </div>

        <div id="listAliquotBarcodeAndVolume"></div>

        <div id="exhaustSpecimen"></div>

        <g:hiddenField id="createdTime" name="createdTime" value="${new Date().format('yyyy-MM-dd HH:MM')}"/>

        <div class="modal fade" id="notFound">
            <div class="modal-dialog" style="position: absolute; left: 0%;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">Not Found!</h4>
                    </div>
                    <div class="modal-body">
                        <p>No specimen found with the Gel Id you entered</p>
                    </div>
                    <div class="modal-footer">
                        <a class='btn btn-primary btn-small' <g:link controller="fluidSpecimen" action="create" ><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'fluidSpecimen.label', default: 'Fluid Specimen')])}</g:link>
                        <a class='btn btn-primary btn-small' <g:link controller="solidSpecimen" action="create" ><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'solidSpecimen.label', default: 'Solid Specimen')])}</g:link>
                        <button type="button" class="btn" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-actions margin-top-medium">
            <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'save', default: 'Save')}" />
            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
        </div>
    </g:form>

</section>
<hr style="border:1; height:1px" />

<g:javascript plugin="jquery" library="jquery" />
<script>
    function getSpecimen(){
        ${remoteFunction (controller: 'aliquot',
                        action: 'findSpecimenByGeLId',
                        params: '"search=" + $("#search").val()',
                        update: 'selectSpecimen',
                        onFailure:'error()'
                )}
    }

    function error(){
        var select = $("#selectSpecimen");
        select.empty().append("Not found");
        $('#notFound').modal()
    }

    function exhaustFluidSpecimen(){
        ${remoteFunction (controller: 'aliquot',
                        action: 'exhaustSpecimen',
                        params: '"selectedSpecimen=" + $("#specimen").val()',
                        update: 'exhaustSpecimen',
                        onSuccess: '$("#exhaustSpecimen").show()',
                        onFailure:'$("#exhaustSpecimen").hide()'
                )}
    }

    function preFillCreatedOn(){
        var baseUrl = "${createLink(controller:'aliquot', action:'preFillCreatedOn')}";
        var specimenId = $('#specimen').val();
        var url = baseUrl + "?specimenId=" + specimenId;
        $.ajax({
            url:url,
            type: 'POST',
            dataType: 'xml',
            async:true,
            success: function(res) {
                if (res){
                    var createdOn = $(res).find('timestamp').text();
                    createdOn = createdOn.toString().substr(0,10);
                    $('#createdOn').val(createdOn);
                }
            },
            error: function(request, status, error) {
                $('#createdOn').val("");
            }
        });
    }

    function preFillCreatedOnFFAliquot(){
        var baseUrl = "${createLink(controller:'aliquot', action:'preFillCreatedOnFFAliquot')}";
        var specimenId = $('#specimen').val();
        var aliquotType = $('#aliquotType').val();
        var url = baseUrl + "?specimenId=" + specimenId + "&aliquotType=" + aliquotType;
        $.ajax({
            url:url,
            type: 'POST',
            dataType: 'xml',
            async:true,
            success: function(res) {
                if (res){
                    var createdOn = $(res).find('timestamp').text();
                    createdOn = createdOn.toString().substr(0,10);
                    $('#createdOn').val(createdOn);
                }
            },
            error: function(request, status, error) {
            }
        });
    }

    function getAliquotNumber(){
        ${remoteFunction (controller: 'aliquot',
                        action: 'aliquotNumber',
                        params: '"aliquotNumber=" + $("#aliquotNumber").val()',
                        update: 'listAliquotBarcodeAndVolume',
                        onFailure:'errorAliquotNumber()'
                )}
    }

    function errorAliquotNumber(){
        var select = $("#listAliquotBarcodeAndVolume");
        select.empty();

    }
</script>

</body>

</html>