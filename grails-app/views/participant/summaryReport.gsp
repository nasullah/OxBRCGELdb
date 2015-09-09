<%@ page import="geldb.DNA_Library; geldb.DNA_Extract; geldb.FluidSpecimen; geldb.Participant" %>
<%@ page import="geldb.SolidSpecimen" %>
<%@ page import="geldb.Aliquot" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Participant  Summary Report</title>
</head>

<body>

<hr style="border:1; height:1px" />

<sec:ifAnyGranted roles="ROLE_ADMIN">
    <div style="background: rgba(139, 240, 37, 0.14);">
        <div class="container">
            <p>
            <h5 class="text-center">Export Options</h5>
            <p>
            <div class="row">
                <div class="col-md-4">
                    <label class="control-label"><small>Export GEL IDs/Participant IDs</small></label>
                    <a class='btn btn-success btn-sm' onclick="getExcelGeLID()"  <g:link controller="participant" action="exportSummaryReport" params="['format': 'excel', 'extension': 'xls']"><i class="glyphicon glyphicon-export"></i> Excel Format</g:link>
                    <div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Processing&hellip;"/>
                        <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="spinner" />
                    </div>
                </div>
                %{--<div class="col-md-3">--}%
                    %{--<label class="control-label"><small>Export KPI Report</small></label>--}%
                    %{--<a class='btn btn-success btn-sm' onclick="getKPIReport()" <g:link controller="DNA_Extract" action="exportKPIReport" params="['format': 'excel', 'extension': 'xls']"><i class="glyphicon glyphicon-export"></i> Excel Format</g:link>--}%
                    %{--<div id="spinnerKPI" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Processing&hellip;"/>--}%
                        %{--<img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="spinner" />--}%
                    %{--</div>--}%
                %{--</div>--}%
            </div>
            <div class="row">
                <div class="col-md-11">
                <hr>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <g:form controller="aliquot" action="exportListOfMaterialSupplied" params="['format': 'excel', 'extension': 'xls']">
                        <label class="control-label"><small>Export List of Material Supplied</small></label>
                        <div class="input-group">
                            <div class="input-group-btn">
                            <label class="control-label"><small>Start Date </small></label>
                            <bs:datePicker id="startDate" name="startDate" precision="day"   value="" /><span class=""></span>
                            <label class="control-label"><small>End Date </small></label>
                            <bs:datePicker id="endDate" name="endDate" precision="day"   value="" /><span class=""></span>
                            <g:select class="form-control" id="aliquotType" name="aliquotType" from="${geldb.AliquotType.list().sort{it.aliquotTypeName}}" optionKey="id" noSelection="['':'- Choose Aliquot Type -']"/>
                                <button type="submit" class="btn btn-success btn-sm" ><span class="glyphicon glyphicon-export"></span> Excel Format</button>
                            </div>
                        </div>
                    </g:form>
                </div>
            </div>
            <p>
            <p>
            <div class="row">

            </div>
            <p>
            <p>
        </div>
    </div>
    <hr style="border:1; height:1px" />
</sec:ifAnyGranted>

<div style="background: rgba(139, 240, 37, 0.14);">
    <div class="container">
        <p>
        <h5 class="text-center">Find Summary Report</h5>
        <p>
        <div class="row">
            <div class="col-lg-6">
                <g:form controller="participant" action="summaryReport">
                    <label for="gelStudyId" class="control-label"><small>Enter GeL Id/Participant Id</small></label>
                    <div class="input-group">
                    <g:textField type="text" name="gelStudyId" class="form-control input-sm" ></g:textField>
                    <div class="input-group-btn">
                        <button type="submit" class="btn btn-success btn-sm" ><span class="glyphicon glyphicon-search"></span> Find</button>
                    </div>
                </g:form>
            </div>
            </div>
        </div>
        <p>
        <p>
    </div>
</div>

<hr style="border:1; height:1px" />

    <g:if test="${participantSummary}">
        <section id="show-participant" class="first">

            <table class="table">
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="participant.diagnosis.label" default="Diagnosis" /></td>

                    <td valign="top" class="value"><g:link controller="ICD10" action="show" id="${participantSummary?.diagnosis?.id}">${participantSummary?.diagnosis?.encodeAsHTML()}</g:link></td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="participant.centre.label" default="Centre" /></td>

                    <td valign="top" class="value"><g:link controller="centre" action="show" id="${participantSummary?.centre?.id}">${participantSummary?.centre?.encodeAsHTML()}</g:link></td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="participant.studySubject.label" default="Consent Type" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <ul>
                            <% def studySubjectList = participantSummary.studySubject.sort{it.studySubjectIdentifier} %>
                            <% studySubjectList = studySubjectList.reverse() %>
                            <g:each in="${studySubjectList}" var="s">
                                <li><g:link controller="studySubject" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
                            </g:each>
                            <p>
                            <p>
                        </ul>
                    </td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="participant.specimen.label" default="Specimen" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <% def solidSpecimen = SolidSpecimen.listOrderByCollectionDate() %>
                        <% def fluidSpecimen = FluidSpecimen.listOrderByCollectionDate() %>

                        <ul>
                            <g:each in="${solidSpecimen}" var="item">
                                <g:each in="${participantSummary?.specimen}" var="specimen">
                                    <g:if test="${item.id == specimen.id}">
                                        <g:if test="${specimen.exhausted}">
                                            <li><g:link controller="solidSpecimen" action="show" id="${specimen.id}">${specimen?.encodeAsHTML()}</g:link> <a class="text-warning">Exhausted</a></li>
                                        </g:if>
                                        <g:else>
                                            <li><g:link controller="solidSpecimen" action="show" id="${specimen.id}">${specimen?.encodeAsHTML()}</g:link></li>
                                        </g:else>
                                        <g:if test="${specimen.fFPE_Tissue_Report}">
                                            <li><g:link controller="FFPE_Tissue_Report" action="show" id="${specimen?.fFPE_Tissue_Report?.first()?.id}">${specimen?.fFPE_Tissue_Report?.first()}</g:link></li>
                                        </g:if>
                                        <g:else>
                                            <li class="text-danger">Main Specimen Report is missing. <a class='btn btn-primary btn-xs' <g:link controller="FFPE_Tissue_Report" action="create" params="['solidSpecimen.id': specimen?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'fFPE_Tissue_Report.label', default: 'Main Specimen Report')])}</g:link>
                                            </li>
                                        </g:else>
										<g:if test="${specimen.noFFSampleExpected}">
                                            <p><mark>No associated Fresh Frozen sample expected</mark></p>
                                        </g:if>
                                    </g:if>
                                </g:each>
                                <p>
                                <p>
                            </g:each>
                            <p>
                        <p>
                            <g:each in="${fluidSpecimen}" var="item">
                                <g:each in="${participantSummary?.specimen}" var="s">
                                    <g:if test="${item.id == s.id}">
                                        <g:if test="${s.exhausted}">
                                            <li><g:link controller="fluidSpecimen" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link> <a class="text-warning">Exhausted</a></li>
                                        </g:if>
                                        <g:else>
                                            <li><g:link controller="fluidSpecimen" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
                                        </g:else>
                                    </g:if>
                                </g:each>
                                <p>
                                <p>
                            </g:each>
                        </ul>
                    </td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="participant.studySubject.label" default="Aliquot" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <% def aliquots = Aliquot.findAll{specimen.participant == participantSummary}.sort {it.aliquotType.aliquotTypeName} %>
                        <ul>
                            <g:each in="${aliquots}" var="aliquot">
                                <g:if test="${aliquot.exhausted}">
                                    <li><g:link controller="aliquot" action="show" id="${aliquot.id}">${aliquot}</g:link> <a class="text-warning">Exhausted</a></li>
                                </g:if>
                                <g:else>
                                    <li><g:link controller="aliquot" action="show" id="${aliquot.id}">${aliquot}</g:link></li>
                                </g:else>
                                <g:if test="${aliquot.gelSuitabilityReport}">
                                    <li><g:link controller="gelSuitabilityReport" action="show" id="${aliquot?.gelSuitabilityReport?.first()?.id}">${aliquot?.gelSuitabilityReport?.first()}</g:link></li>
                                </g:if>
                                <g:elseif test="${(!aliquot?.derivedFrom?.aliquot?.gelSuitabilityReport
                                        && !aliquot?.derivedFrom?.aliquot?.gelSuitabilityReport
                                        && aliquot?.aliquotType?.aliquotTypeName != 'Buffy Coat'
                                        && aliquot?.aliquotType?.aliquotTypeName != 'Plasma'
                                        && aliquot?.aliquotType?.aliquotTypeName != 'Blood Germline'
                                        && aliquot?.aliquotType?.aliquotTypeName != 'Plasma EDTA cfDNA'
                                        && aliquot?.aliquotType?.aliquotTypeName != 'Plasma Strek cfDNA'
                                        && aliquot?.aliquotType?.aliquotTypeName != 'Plasma PST'
                                        && aliquot?.aliquotType?.aliquotTypeName != 'Blood PAXgene'
                                        && aliquot?.aliquotType?.aliquotTypeName != 'Serum SST'
                                        && aliquot?.aliquotType?.aliquotTypeName != 'Full Blood')}">
                                    <li class="text-danger">GeL Suitability Report is missing. <a class='btn btn-primary btn-xs' <g:link controller="gelSuitabilityReport" action="create" params="['aliquot.id': aliquot?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'gelSuitabilityReport.label', default: 'GeL Suitability Report')])}</g:link>
                                    </li>
                                </g:elseif>
                                <p>
                                <p>
                            </g:each>
                        </ul>
                    </td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="participant.studySubject.label" default="DNA Extract" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <% def dna_Extracts = DNA_Extract.findAll {aliquot.specimen.participant == participantSummary} %>
                        <ul>
                            <g:each in="${dna_Extracts}" var="dna_Extract">
                                <g:if test="${dna_Extract.exhausted}">
                                    <li><g:link controller="DNA_Extract" action="show" id="${dna_Extract.id}">${dna_Extract}</g:link> <a class="text-warning">Exhausted</a></li>
                                </g:if>
                                <g:else>
                                    <li><g:link controller="DNA_Extract" action="show" id="${dna_Extract.id}">${dna_Extract}</g:link></li>
                                </g:else>
                                <p>
                                <p>
                            </g:each>
                        </ul>
                    </td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="participant.studySubject.label" default="DNA Library" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <% def dna_Libraries = DNA_Library.findAll {na_extract.aliquot.specimen.participant == participantSummary} %>
                        <ul>
                            <g:each in="${dna_Libraries}" var="dna_Library">
                                <li><g:link controller="DNA_Library" action="show" id="${dna_Library.id}">${dna_Library}</g:link></li>
                            </g:each>
                            <p>
                            <p>
                        </ul>
                    </td>

                </tr>

                </tbody>
            </table>
        </section>
    </g:if>

<g:javascript plugin="jquery" library="jquery" />
<script>
    function getMaterialSupplied(){
        ${remoteFunction (controller: 'aliquot',
                        action: 'exportListOfMaterialSupplied',
                        params: '[startDate:$("#startDate").val(), endDate:$("#endDate").val(), aliquotType:$("#aliquotType").val()]',
                        onFailure:'error()'
                )}
    }

    function error(){
        var select = $("#selectICD10");
        select.empty().append("Not found");
        $('#notFound').modal()
    }

    function showSpinner() {
        $('#spinner').show();
    }
    function hideSpinner() {
        $('#spinner').hide();
    }
    function hideSpinnerKPI() {
        $('#spinnerKPI').hide();
    }
    function getExcelGeLID(){
        showSpinner();
        ${remoteFunction (controller: 'participant',
                        action: 'exportSummaryReport',
                        params:[format:'excel',extension:'xls'],
                        onSuccess:'hideSpinner()'
                )}
    }

    function getKPIReport(){
        $('#spinnerKPI').show();
        ${remoteFunction (controller: 'DNA_Extract',
                        action: 'exportKPIReport',
                        params:[format:'excel',extension:'xls'],
                        onSuccess:'hideSpinnerKPI()'
                )}
    }

</script>
</body>

</html>