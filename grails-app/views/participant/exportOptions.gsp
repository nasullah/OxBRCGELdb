<%@ page import="geldb.AliquotType" %>

<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Export Options</title>
</head>

<body>

<p></p>

<div style="background: rgba(139, 240, 37, 0.14);">
    <div class="container">
        <sec:ifAnyGranted roles="ROLE_ADMIN">
            <p>
            <h5 class="text-center">Export Options</h5>
            <p>
            <div class="row">
                <div class="col-md-2">
                    <label class="control-label"><small>GEL/Participant IDs</small></label>
                    <a class='btn btn-success btn-sm' onclick="getExcelGeLID()" <g:link controller="participant" action="exportSummaryReport" params="['format': 'excel', 'extension': 'xls']"><i class="glyphicon glyphicon-export"></i> Excel Format</g:link>
                    <div id="spinnerGELID" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Processing&hellip;"/>
                        <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="spinner" />
                    </div>
                </div>

                <div class="col-md-2">
                    <label class="control-label"><small>FFPE Tissue Handling</small></label>
                    <a class='btn btn-success btn-sm' onclick="getExcelFFPETissueHandling()" <g:link controller="aliquot" action="exportFFPETissueHandling" params="['format': 'excel', 'extension': 'xls']"><i class="glyphicon glyphicon-export"></i> Excel Format</g:link>
                    <div id="spinnerFFPETissueHandling" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Processing&hellip;"/>
                        <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="spinner" />
                    </div>
                </div>

                <div class="col-md-2">
                    <label class="control-label"><small>All Dispatched DNA</small></label>
                    <a class='btn btn-success btn-sm' onclick="getAllDispatchedDNASamples()" <g:link controller="dispatchRecord" action="exportAllDispatchedDNASamples" params="['format': 'excel', 'extension': 'xls']"><i class="glyphicon glyphicon-export"></i> Excel Format</g:link>
                    <div id="spinnerAllDispatchedDNASamples" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Processing&hellip;"/>
                        <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="spinner" />
                    </div>
                </div>

                <div class="col-md-2">
                    <label class="control-label"><small>All Dispatched Omics</small></label>
                    <a class='btn btn-success btn-sm' onclick="getAllDispatchedOmicsSamples()" <g:link controller="dispatchRecord" action="exportAllDispatchedOmicsSamples" params="['format': 'excel', 'extension': 'xls']"><i class="glyphicon glyphicon-export"></i> Excel Format</g:link>
                    <div id="spinnerAllDispatchedOmicsSamples" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Processing&hellip;"/>
                        <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="spinner" />
                    </div>
                </div>

                %{--<div class="col-md-2">--}%
                    %{--<label class="control-label"><small>Dispatched Items Data</small></label>--}%
                    %{--<a class='btn btn-success btn-sm' onclick="getCSVDispatchedItemsData()" <g:link controller="dispatchRecord" action="exportAllDispatchedItemsData" params="['format': 'csv', 'extension': 'csv']"><i class="glyphicon glyphicon-export"></i> CSV Format</g:link>--}%
                    %{--<div id="spinnerDispatchedItemsData" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Processing&hellip;"/>--}%
                        %{--<img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="spinner" />--}%
                    %{--</div>--}%
                %{--</div>--}%

                <div class="col-md-2">
                    <label class="control-label"><small>FFPE, NBF & Fixation Period</small></label>
                    <a class='btn btn-success btn-sm' onclick="getExcelFFPEList()" <g:link controller="aliquot" action="exportFFPEList" params="['format': 'excel', 'extension': 'xls']"><i class="glyphicon glyphicon-export"></i> Excel Format</g:link>
                    <div id="spinnerFFPEList" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Processing&hellip;"/>
                        <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="spinner" />
                    </div>
                </div>

                <div class="col-md-2">
                    <label class="control-label"><small>FF Aliquots Per Part.</small></label>
                    <a class='btn btn-success btn-sm' onclick="getNumberOfFFAliquots()" <g:link controller="aliquot" action="exportFFAliquotsNumbersList" params="['format': 'excel', 'extension': 'xls']"><i class="glyphicon glyphicon-export"></i> Excel Format</g:link>
                    <div id="spinnerFFList" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Processing&hellip;"/>
                        <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="spinner" />
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-11">
                        <hr>
                    </div>
                </div>

                <div class="col-md-6">
                    <label class="control-label"><small>Export barcode file (upload the csv file generated by the box scanner)</small></label>
                    <g:uploadForm class="form-inline" controller="solidSpecimen" action="renderBarcode" role="form">
                        <div class="form-group">
                            <input type="file" id="csvFile" name="csvFile" />
                        </div>
                        <div class="form-group">
                            <button type="submit" name="upload" class="btn btn-success  btn-sm"><i class="glyphicon glyphicon-upload"></i> Upload</button>
                        </div>
                    </g:uploadForm>
                </div>

                <div class="col-md-6">
                    <label class="control-label"><small>Export barcode file with sample type(upload the csv file generated by the box scanner)</small></label>
                    <g:uploadForm class="form-inline" controller="solidSpecimen" action="renderBarcodeAndSampleType" role="form">
                        <div class="form-group">
                            <input type="file" id="csvFileWithSampleType" name="csvFileWithSampleType" />
                        </div>
                        <div class="form-group">
                            <button type="submit" name="upload" class="btn btn-success  btn-sm"><i class="glyphicon glyphicon-upload"></i> Upload</button>
                        </div>
                    </g:uploadForm>
                </div>
            </div>

            <div class="row">
                <div class="col-md-11">
                    <hr>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <g:form controller="aliquot" action="exportListOfMaterialSupplied" params="['format': 'excel', 'extension': 'xls']">
                        <label class="control-label"><small>Export List of Material Supplied</small></label>
                        <div class="form-inline">
                            <label class="control-label"><small>Start Date </small></label>
                            <bs:datePicker id="startDate" name="startDate" precision="day" value="${params.startDate}"/>
                            <label class="control-label"><small>End Date </small></label>
                            <bs:datePicker id="endDate" name="endDate" precision="day" value="${params.endDate}" />
                            <g:select class="form-control" id="aliquotType" name="aliquotType" from="${AliquotType.list().sort{it.aliquotTypeName}}" required="" value="${params.aliquotType}" optionKey="id" noSelection="['':'- Choose Aliquot Type -']"/>
                            <button type="submit"  class="btn btn-success btn-sm" ><span class="glyphicon glyphicon-export"></span> Excel Format</button>
                        </div>
                    </g:form>
                </div>
            </div>
        </sec:ifAnyGranted>

        <div class="row">
            <div class="col-md-11">
                <hr>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <g:form controller="DNA_Extract" action="exportDNAExportListToCheck" params="['format': 'pdf', 'extension': 'pdf']">
                    <label class="control-label"><small>Export DNA list to check </small></label>
                    <div class="form-inline">
                        <label class="control-label"><small>Start Date </small></label>
                        <bs:datePicker id="startDateDNA" name="startDateDNA" precision="day" value="${params.startDateDNA}" />
                        <label class="control-label"><small>End Date </small></label>
                        <bs:datePicker id="endDateDNA" name="endDateDNA" precision="day" value="${params.endDateDNA}" />
                        <g:select class="form-control" id="aliquotTypeDNA" name="aliquotTypeDNA" from="${AliquotType.list().sort{it.aliquotTypeName}}" required="" value="${params.aliquotTypeDNA}" optionKey="id" noSelection="['':'- Choose Sample Type -']"/>
                        <button type="submit"  class="btn btn btn-sm" ><span class="glyphicon glyphicon-export"></span> PDF Format</button>
                    </div>
                </g:form>
            </div>
        </div>

        <div class="row">
            <div class="col-md-11">
                <hr>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <g:form controller="participant" action="exportParticipantsBySites" params="['format': 'excel', 'extension': 'xls']">
                    <label class="control-label"><small>Export Participants by Anatomical sites</small></label>
                    <div class="form-inline">
                        <label class="control-label"><small>Start Date </small></label>
                        <bs:datePicker id="startDateAnatomicalSite" name="startDateAnatomicalSite" precision="day" value="${params.startDateAnatomicalSite}"/>
                        <label class="control-label"><small>End Date </small></label>
                        <bs:datePicker id="endDateAnatomicalSite" name="endDateAnatomicalSite" precision="day" value="${params.endDateAnatomicalSite}" />
                        <g:select class="form-control" id="anatomicalSite" name="anatomicalSite" from="${geldb.AnatomicalSite.list().sort {it.anatomicalSiteName}}" optionKey="id" value="${solidSpecimenInstance?.anatomicalSite?.id}" noSelection="['':'- Choose Anatomical Site-']"/>
                        <button type="submit"  class="btn btn-success btn-sm" ><span class="glyphicon glyphicon-export"></span> Excel Format</button>
                    </div>
                </g:form>
            </div>
        </div>

        <div class="row">
            <div class="col-md-11">
                <hr>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <label class="control-label"><small>Export Pre-dispatch Report (upload the csv file generated by the box scanner)</small></label>
                <g:uploadForm class="form-inline" controller="DNA_Extract" action="preDispatchReport" role="form" params="['format': 'excel', 'extension': 'xls']">
                    <div class="form-group">
                        <input type="file" id="preDispatchCsvFile" name="preDispatchCsvFile" />
                    </div>
                    <div class="form-group">
                        <button type="submit" name="upload" class="btn btn-success  btn-sm"><i class="glyphicon glyphicon-upload"></i> Upload</button>
                    </div>
                </g:uploadForm>
            </div>
        </div>
        <p>
    </div>
</div>

<hr/>

<g:javascript plugin="jquery" library="jquery" />
<script>

    function getMaterialSupplied(){
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        var aliquotType = $("#aliquotType").val();
        ${remoteFunction (controller: 'aliquot',
                        action: 'exportListOfMaterialSupplied',
                        params:'\'startDate=\' + startDate +  \'&endDate=\' + endDate +\'&aliquotType=\' + aliquotType'
                )}
    }

    function getExcelGeLID(){
        $('#spinnerGELID').show();
        ${remoteFunction (controller: 'participant',
                        action: 'exportSummaryReport',
                        params:[format:'excel',extension:'xls'],
                        onSuccess:'$("#spinnerGELID").hide()'
                )}
    }

    function getExcelFFPETissueHandling(){
        $('#spinnerFFPETissueHandling').show();
        ${remoteFunction (controller: 'aliquot',
                        action: 'exportFFPETissueHandling',
                        params:[format:'excel',extension:'xls'],
                        onSuccess:'$("#spinnerFFPETissueHandling").hide()'
                )}
    }

    function getAllDispatchedDNASamples(){
        $('#spinnerAllDispatchedDNASamples').show();
        ${remoteFunction (controller: 'dispatchRecord',
                        action: 'exportAllDispatchedDNASamples',
                        params:[format:'csv',extension:'csv'],
                        onSuccess:'$("#spinnerAllDispatchedDNASamples").hide()'
                )}
    }

    function getAllDispatchedOmicsSamples(){
        $('#spinnerAllDispatchedOmicsSamples').show();
        ${remoteFunction (controller: 'dispatchRecord',
                        action: 'exportAllDispatchedOmicsSamples',
                        params:[format:'csv',extension:'csv'],
                        onSuccess:'$("#spinnerAllDispatchedOmicsSamples").hide()'
                )}
    }

    function getCSVDispatchedItemsData(){
        $('#spinnerDispatchedItemsData').show();
        ${remoteFunction (controller: 'dispatchRecord',
                        action: 'exportAllDispatchedItemsData',
                        params:[format:'csv',extension:'csv'],
                        onSuccess:'$("#spinnerDispatchedItemsData").hide()'
                )}
    }

    function getExcelFFPEList(){
        $('#spinnerFFPEList').show();
        ${remoteFunction (controller: 'aliquot',
                        action: 'exportFFPEList',
                        params:[format:'excel',extension:'xls'],
                        onSuccess:'$("#spinnerFFPEList").hide()'
                )}
    }

    function getNumberOfFFAliquots(){
        $('#spinnerFFList').show();
        ${remoteFunction (controller: 'aliquot',
                        action: 'exportFFAliquotsNumbersList',
                        params:[format:'excel',extension:'xls'],
                        onSuccess:'$("#spinnerFFList").hide()'
                )}
    }
</script>

</body>
</html>

