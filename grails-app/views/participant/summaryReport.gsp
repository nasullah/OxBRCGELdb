<%@ page import="geldb.ExtractionType; geldb.DNA_Library; geldb.DNA_Extract; geldb.FluidSpecimen; geldb.Participant" %>
<%@ page import="geldb.SolidSpecimen" %>
<%@ page import="geldb.Aliquot" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Participant  Summary Report</title>
</head>

<body>

<div style="background: rgba(25, 105, 255, 0.14);">
    <div class="container">
        <h5 class="text-center">Find Summary Report</h5>
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

<g:if test="${participantSummary}">
    <p>
    <p>
    <center><p style="font-size: xx-large"><b>${participantSummary?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}}</b></p></center>

    <table border="1" width="100%">
        <tr>
            <th style="background: rgba(25, 105, 255, 0.33)"><center>Diagnosis</center></th>
        </tr>
    </table>
    <section id="show-diagnosis" class="first">
        <table class="table table-bordered margin-top-medium">
            <% def fFPE_Tissue_Report = SolidSpecimen.findByParticipant(participantSummary)?.fFPE_Tissue_Report
            def tumourType = ""
            if (fFPE_Tissue_Report && !fFPE_Tissue_Report?.empty){
                tumourType = fFPE_Tissue_Report?.first()?.tumourType
            }
            %>
            <g:if test="${tumourType != "" || participantSummary?.diagnosis}">
                <thead>
                <tr>

                    <th>ICD10 Code & Description</th>

                    <th>Tumour Type</th>

                </tr>
                </thead>
            </g:if>
            <tbody>
            <tr class="prop">

                <td>${fieldValue(bean: participantSummary, field: "diagnosis")}</td>

                <td>${tumourType}</td>

            </tr>
            </tbody>
        </table>
    </section>

    <table border="1" width="100%">
        <tr>
            <th style="background: rgba(25, 105, 255, 0.33)"><center>Centre</center></th>
        </tr>
    </table>

    <section id="show-centre" class="first">
        <table class="table table-bordered margin-top-medium">
            <tbody>
            <tr class="prop">
                <td>
                ${fieldValue(bean: participantSummary, field: "centre")}
                </td>
            </tr>
            </tbody>
        </table>
    </section>

    <table border="1" width="100%">
        <tr>
            <th style="background: rgba(25, 105, 255, 0.33)"><center>Consent Type</center></th>
        </tr>
    </table>

    <section id="show-consentType" class="first">
        <table class="table table-bordered margin-top-medium">
            <thead>
            <tr>

                <th>Consent Type</th>

                <th>Consent Status</th>

                <th>Consent Form Version</th>

                <th>Recruitment Date</th>

                <th>Recruited By</th>

                <th>Participant Id</th>

            </tr>
            </thead>
            <tbody>
            <% def studySubjectList = participantSummary.studySubject.sort{it.studySubjectIdentifier} %>
            <% studySubjectList = studySubjectList.reverse() %>
            <g:each in="${studySubjectList}" status="i" var="studySubjectInstance">
                <tr>

                    <td><g:link controller="studySubject" action="show" id="${studySubjectInstance.id}">${fieldValue(bean: studySubjectInstance, field: "study")}</g:link></td>

                    <td><g:formatBoolean false="No" true="Yes" boolean="${studySubjectInstance.consentStatus}" /></td>

                    <td>${fieldValue(bean: studySubjectInstance, field: "consentFormVersion")}</td>

                    <td><g:formatDate format="yyyy-MM-dd" date="${studySubjectInstance.recruitmentDate}" /></td>

                    <td>${fieldValue(bean: studySubjectInstance, field: "recruitedBy")}</td>

                    <td>${fieldValue(bean: studySubjectInstance, field: "studySubjectIdentifier")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </section>

    <table border="1" width="100%">
        <tr>
            <th style="background: rgba(25, 105, 255, 0.33)"><center>Main Specimen</center></th>
        </tr>
    </table>

    <% def solidSpecimen = SolidSpecimen.listOrderByCollectionDate() %>
    <g:if test="${participantSummary.solidSpecimenExpected != null && !participantSummary.solidSpecimenExpected && !SolidSpecimen.findByParticipant(participantSummary)}">
        <table border="1" width="100%">
            <tr>
                <td>
                    <a><mark>No associated solid specimen expected</mark></a>
                </td>
            </tr>
        </table>
    </g:if>

    <section id="show-mainSpecimen" class="first">
        <table class="table table-bordered margin-top-medium">
            <g:if test="${!SolidSpecimen.findAllByParticipant(participantSummary).empty}">
                <thead>
                <tr>

                    <th>Histology Number</th>

                    <th>Collection Method</th>

                    <th>Collection Date</th>

                    <th>Exhausted</th>

                    <th>Main Specimen Report</th>

                    <th>FF Sample Expected</th>

                    <th>Participant Id</th>

                </tr>
                </thead>
            </g:if>
            <tbody>
                <g:each in="${solidSpecimen}" var="item">
                    <g:each in="${participantSummary?.specimen}" var="solidSpecimenInstance">
                        <g:if test="${item.id == solidSpecimenInstance.id}">
                            <tr>

                                <td><g:link controller="solidSpecimen" action="show" id="${solidSpecimenInstance.id}">${fieldValue(bean: solidSpecimenInstance, field: "histologyNumber")}</g:link></td>

                                <td>${fieldValue(bean: solidSpecimenInstance, field: "collectionMethod")}</td>

                                <td><g:formatDate format="yyyy-MM-dd" date="${solidSpecimenInstance.collectionDate}" /></td>

                                <td>
                                    <g:if test="${solidSpecimenInstance.exhausted}">
                                        <a class="text-warning"><g:formatBoolean false="No" true="Yes" boolean="${solidSpecimenInstance.exhausted}" /></a>
                                    </g:if>
                                    <g:else>
                                        <g:formatBoolean false="No" true="Yes" boolean="${solidSpecimenInstance.exhausted}" />
                                    </g:else>
                                </td>

                                <td>
                                    <g:if test="${solidSpecimenInstance.fFPE_Tissue_Report}">
                                        <g:link controller="FFPE_Tissue_Report" action="show" id="${solidSpecimenInstance?.fFPE_Tissue_Report?.first()?.id}">Main Specimen Report</g:link>
                                    </g:if>
                                    <g:else>
                                        <a class="text-danger">Missing <a class='btn btn-primary btn-xs' <g:link controller="FFPE_Tissue_Report" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]"><i class="glyphicon glyphicon-plus"></i> Add</g:link><br/></a>
                                    </g:else>
                                </td>

                                <td>
                                    <g:if test="${!solidSpecimenInstance.noFFSampleExpected}">
                                        <a class="text-success">Yes</a>
                                    </g:if>
                                    <g:else>
                                        <a class="text-danger">No</a>
                                    </g:else>
                                </td>

                                <td>${fieldValue(bean: solidSpecimenInstance.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>
                            </tr>
                        </g:if>
                    </g:each>
                </g:each>
            </tbody>
        </table>
    </section>

    <table border="1" width="100%">
        <tr>
            <th style="background: rgba(25, 105, 255, 0.33)"><center>Main Specimen Aliquot</center></th>
        </tr>
    </table>

    <section id="show-solidSpecimenAliquots" class="first">
        <table class="table table-bordered margin-top-medium">
            <g:if test="${!Aliquot.findAllBySpecimenInList(SolidSpecimen.findAllByParticipant(participantSummary)).empty}">
                <thead>
                <tr>

                    <th>Aliquot Type</th>

                    <th>Identifier</th>

                    <th>Barcode</th>

                    <th>Histo. No.</th>

                    <th>Aliq. Rank.</th>

                    <th>GeL Suit. Rep.</th>

                    <th>Suitable</th>

                    <th>Geno. Bl. Fix. Rep.</th>

                    <th>Exh.</th>

                    <th>Participant Id</th>

                </tr>
                </thead>
            </g:if>
            <tbody>
            <% def solidSpecimenAliquots = Aliquot.findAll{specimen.participant == participantSummary}.sort {it.aliquotType.aliquotTypeName} %>
            <g:each in="${solidSpecimenAliquots}" var="aliquotInstance">
                <g:if test="${SolidSpecimen.findById(aliquotInstance.specimen.id)}">
                    <tr>

                        <td><g:link controller="aliquot" action="show" id="${aliquotInstance.id}">${fieldValue(bean: aliquotInstance, field: "aliquotType")}</g:link></td>

                        <td>
                            <g:if test="${aliquotInstance.blockNumber != null}">
                                ${fieldValue(bean: aliquotInstance, field: "blockNumber")}
                            </g:if>
                            <g:else>
                                ${fieldValue(bean: aliquotInstance, field: "sapphireIdentifier")}
                            </g:else>
                        </td>

                        <td>${fieldValue(bean: aliquotInstance, field: "barcode")}</td>

                        <td>${fieldValue(bean: aliquotInstance.specimen, field: "histologyNumber")}</td>

                        <td>${fieldValue(bean: aliquotInstance, field: "aliquotRanking")}</td>

                        <td>
                            <g:if test="${aliquotInstance.gelSuitabilityReport}">
                                <g:link controller="gelSuitabilityReport" action="show" id="${aliquotInstance?.gelSuitabilityReport?.first()?.id}">GeL Suit. Rep.</g:link><br/>
                            </g:if>
                            <g:elseif test="${(!aliquotInstance?.derivedFrom?.aliquot?.gelSuitabilityReport
                                    && !aliquotInstance?.derivedFrom?.aliquot?.gelSuitabilityReport
                                    && aliquotInstance?.aliquotType?.aliquotTypeName != 'Section'
                                    && aliquotInstance?.aliquotType?.aliquotTypeName != 'All Prep Lysate')}">
                                <a class="text-danger">Missing <a class='btn btn-primary btn-xs' <g:link controller="gelSuitabilityReport" action="create" params="['aliquot.id': aliquotInstance?.id]"><i class="glyphicon glyphicon-plus"></i> Add</g:link><br/>
                                </a>
                            </g:elseif>
                        </td>

                        <td>
                            <g:if test="${!aliquotInstance?.gelSuitabilityReport?.empty}">
                                <g:if test="${aliquotInstance?.gelSuitabilityReport?.first()?.suitableForGel == null}">
                                    <a class="text-danger">Not completed</a>
                                </g:if>
                                <g:elseif test="${aliquotInstance?.gelSuitabilityReport?.first()?.suitableForGel}">
                                    <a class="text-success">Yes</a>
                                </g:elseif>
                                <g:else>
                                    <a class="text-danger">No</a>
                                </g:else>
                            </g:if>
                        </td>

                        <td>
                            <g:if test="${aliquotInstance.fixationReport}">
                                <g:link controller="fixationReport" action="show" id="${aliquotInstance?.fixationReport?.first()?.id}">Geno. Bl. Fix. Rep.</g:link><br/>
                            </g:if>
                            <g:elseif test="${(!aliquotInstance.fixationReport
                                    && aliquotInstance.createdOn > new Date().parse('yyyy/MM/dd', '2015/11/01')
                                    && (aliquotInstance.aliquotType.aliquotTypeName == 'Punch Biopsy FFPE, NBF'
                                    || aliquotInstance.aliquotType.aliquotTypeName == 'Punch Biopsy FFPE'))}">
                                <a class="text-danger">Missing <a class='btn btn-primary btn-xs' <g:link controller="fixationReport" action="create" params="['aliquot.id': aliquotInstance?.id]"><i class="glyphicon glyphicon-plus"></i> Add</g:link><br/>
                                </a>
                            </g:elseif>
                        </td>

                        <td>
                            <g:if test="${aliquotInstance.exhausted}">
                                <a class="text-warning"><g:formatBoolean false="No" true="Yes" boolean="${aliquotInstance.exhausted}" /></a>
                            </g:if>
                            <g:else>
                                <g:formatBoolean false="No" true="Yes" boolean="${aliquotInstance.exhausted}" />
                            </g:else>
                        </td>

                        <td>${fieldValue(bean: aliquotInstance.specimen.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

                    </tr>
                </g:if>
            </g:each>
            </tbody>
        </table>
    </section>

    <table border="1" width="100%">
        <tr>
            <th style="background: rgba(25, 105, 255, 0.33)"><center>Fluid Specimen</center></th>
        </tr>
    </table>

    <section id="show-fluidSpecimen" class="first">
        <table class="table table-bordered margin-top-medium">
            <g:if test="${!FluidSpecimen.findAllByParticipant(participantSummary).empty}">
                <thead>
                <tr>

                    <th>Fluid Sample Type</th>

                    <th>Primary Container</th>

                    <th>Number of Aliquots</th>

                    <th>Time Point</th>

                    <th>Collection Date</th>

                    <th>Exhausted</th>

                    <th>Participant Id</th>

                </tr>
                </thead>
            </g:if>
            <tbody>
            <% def fluidSpecimen = FluidSpecimen.listOrderByCollectionDate() %>
            <g:each in="${fluidSpecimen}" var="item">
                <g:each in="${participantSummary?.specimen}" var="fluidSpecimenInstance">
                    <tr>
                        <g:if test="${item.id == fluidSpecimenInstance.id}">

                            <td><g:link controller="fluidSpecimen" action="show" id="${fluidSpecimenInstance.id}">${fieldValue(bean: fluidSpecimenInstance, field: "fluidSampleType")}</g:link></td>

                            <td>${fieldValue(bean: fluidSpecimenInstance, field: "primaryContainer")}</td>

                            <td>${fluidSpecimenInstance?.aliquot?.size()}</td>

                            <td>${fieldValue(bean: fluidSpecimenInstance, field: "timePoint")}</td>

                            <td><g:formatDate format="yyyy-MM-dd" date="${fluidSpecimenInstance.collectionDate}" /></td>

                            <td>
                                <g:if test="${fluidSpecimenInstance.exhausted}">
                                    <a class="text-warning"><g:formatBoolean false="No" true="Yes" boolean="${fluidSpecimenInstance.exhausted}" /></a>
                                </g:if>
                                <g:else>
                                    <g:formatBoolean false="No" true="Yes" boolean="${fluidSpecimenInstance.exhausted}" />
                                </g:else>
                            </td>

                            <td>${fieldValue(bean: fluidSpecimenInstance.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

                        </g:if>
                    </tr>
                </g:each>
            </g:each>
            </tbody>
        </table>
    </section>

    <table border="1" width="100%">
        <tr>
            <th style="background: rgba(25, 105, 255, 0.33)"><center>Fluid Specimen Aliquot</center></th>
        </tr>
    </table>

    <section id="show-fluidSpecimenAliquot" class="first">
        <table class="table table-bordered margin-top-medium">
            <g:if test="${!Aliquot.findAllBySpecimenInList(FluidSpecimen.findAllByParticipant(participantSummary)).empty}">
                <thead>
                <tr>

                    <th>Aliquot Type</th>

                    <th>Identifier</th>

                    <th>Barcode</th>

                    <th>Created On</th>

                    <th>Time Point</th>

                    <th>Exhausted</th>

                    <th>Participant Id</th>

                </tr>
                </thead>
            </g:if>
            <tbody>
            <% def fluidSpecimenAliquots = Aliquot.findAll{specimen.participant == participantSummary}.sort {it.aliquotType.aliquotTypeName} %>

            <g:each in="${fluidSpecimenAliquots}" var="aliquotInstance">
                <g:if test="${FluidSpecimen.findById(aliquotInstance.specimen.id)}">
                    <tr>

                    <td><g:link controller="aliquot" action="show" id="${aliquotInstance.id}">${fieldValue(bean: aliquotInstance, field: "aliquotType")}</g:link></td>

                    <td>${fieldValue(bean: aliquotInstance, field: "sapphireIdentifier")}</td>

                    <td>${fieldValue(bean: aliquotInstance, field: "barcode")}</td>

                    <td><g:formatDate format="yyyy-MM-dd" date="${aliquotInstance.createdOn}" /></td>

                    <td>
                        ${fieldValue(bean: aliquotInstance?.specimen, field: "timePoint")}
                    </td>

                    <td>
                        <g:if test="${aliquotInstance.exhausted}">
                            <a class="text-warning"><g:formatBoolean false="No" true="Yes" boolean="${aliquotInstance.exhausted}" /></a>
                        </g:if>
                        <g:else>
                            <g:formatBoolean false="No" true="Yes" boolean="${aliquotInstance.exhausted}" />
                        </g:else>
                    </td>

                    <td>${fieldValue(bean: aliquotInstance.specimen.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>
                    </tr>
                </g:if>
            </g:each>
            </tbody>
        </table>
    </section>

    <table border="1" width="100%">
        <tr>
            <th style="background: rgba(25, 105, 255, 0.33)"><center>DNA Extract</center></th>
        </tr>
    </table>

    <section id="show-dnaExtract" class="first">
        <table class="table table-bordered margin-top-medium">
            <% def dna_Extracts = DNA_Extract.findAll {aliquot.specimen.participant == participantSummary}
            dna_Extracts = dna_Extracts.findAll {d -> d.extractionType == ExtractionType.findByExtractionTypeName('DNA Extraction')}
            %>
            <g:if test="${!dna_Extracts.empty}">
                <thead>
                <tr>

                    <th>Sample Type</th>

                    <th>Elution</th>

                    <th>Pass Fail</th>

                    <th>DNA Quantity</th>

                    <th>Delta QC</th>

                    <th>Barcode</th>

                    <th>Extraction Date</th>

                    <th>Exhausted</th>

                    <th>Participant Id</th>

                </tr>
                </thead>
            </g:if>
            <tbody>
            <g:each in="${dna_Extracts}" var="DNA_ExtractInstance">
                <tr>
                    <td><g:link controller="DNA_Extract" action="show" id="${DNA_ExtractInstance?.id}">${fieldValue(bean: DNA_ExtractInstance?.aliquot?.first(), field: "aliquotType")}</g:link></td>

                    <td>${fieldValue(bean: DNA_ExtractInstance, field: "sapphireIdentifier")}</td>

                    <td>
                        <g:if test="${DNA_ExtractInstance.passFail}">
                            <g:formatBoolean true="Pass" false="Fail" boolean="${DNA_ExtractInstance.passFail}" />
                        </g:if>
                        <g:else>
                            <a class="text-danger"><g:formatBoolean boolean="${DNA_ExtractInstance.passFail}" true="Pass" false="Fail" /></a>
                        </g:else>
                    </td>

                    <% def dnaQuantity = (DNA_ExtractInstance.dNAConcentrationQubit * DNA_ExtractInstance.dNAAmount)/1000 %>
                    <td>${dnaQuantity.trunc(1)}</td>

                    <td>${fieldValue(bean: DNA_ExtractInstance, field: "delatQC")}</td>

                    <td>${fieldValue(bean: DNA_ExtractInstance, field: "barcode")}</td>

                    <td><g:formatDate format="yyyy-MM-dd" date="${DNA_ExtractInstance?.extractionDate}" /></td>

                    <td>
                        <g:if test="${DNA_ExtractInstance.exhausted}">
                            <a class="text-warning"><g:formatBoolean false="No" true="Yes" boolean="${DNA_ExtractInstance.exhausted}" /></a>
                        </g:if>
                        <g:else>
                            <g:formatBoolean false="No" true="Yes" boolean="${DNA_ExtractInstance.exhausted}" />
                        </g:else>
                    </td>

                    <% def gelId = DNA_ExtractInstance.aliquot.specimen.participant.studySubject %>
                    <% gelId = gelId.first()%>
                    <% gelId = gelId.findResult {it.studySubjectIdentifier ? it : null}%>

                    <td>${fieldValue(bean: gelId, field: "studySubjectIdentifier")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </section>

    <table border="1" width="100%">
        <tr>
            <th style="background: rgba(25, 105, 255, 0.33)"><center>RNA Extract</center></th>
        </tr>
    </table>

    <section id="show-dnaExtract" class="first">
        <table class="table table-bordered margin-top-medium">
            <% def rna_Extracts = DNA_Extract.findAll {aliquot.specimen.participant == participantSummary}
            rna_Extracts = rna_Extracts.findAll {r -> r.extractionType == ExtractionType.findByExtractionTypeName('RNA Extraction')}
            %>
            <g:if test="${!rna_Extracts.empty}">
                <thead>
                <tr>

                    <th>Sample Type</th>

                    <th>Elution</th>

                    <th>Pass Fail</th>

                    <th>Barcode</th>

                    <th>Extraction Date</th>

                    <th>RIN</th>

                    <th>Exhausted</th>

                    <th>Participant Id</th>

                </tr>
                </thead>
            </g:if>
            <tbody>
            <g:each in="${rna_Extracts}" var="RNA_ExtractInstance">
                <tr>
                    <td><g:link controller="DNA_Extract" action="show" id="${RNA_ExtractInstance?.id}">${fieldValue(bean: RNA_ExtractInstance?.aliquot?.first(), field: "aliquotType")}</g:link></td>

                    <td>${fieldValue(bean: RNA_ExtractInstance, field: "sapphireIdentifier")}</td>

                    <td>
                        <g:if test="${RNA_ExtractInstance.passFail}">
                            <g:formatBoolean true="Pass" false="Fail" boolean="${RNA_ExtractInstance.passFail}" />
                        </g:if>
                        <g:else>
                            <a class="text-danger"><g:formatBoolean boolean="${RNA_ExtractInstance.passFail}" true="Pass" false="Fail" /></a>
                        </g:else>
                    </td>

                    <td>${fieldValue(bean: RNA_ExtractInstance, field: "barcode")}</td>

                    <td><g:formatDate format="yyyy-MM-dd" date="${RNA_ExtractInstance?.extractionDate}" /></td>

                    <td>${fieldValue(bean: RNA_ExtractInstance, field: "rin")}</td>

                    <td>
                        <g:if test="${RNA_ExtractInstance.exhausted}">
                            <a class="text-warning"><g:formatBoolean false="No" true="Yes" boolean="${RNA_ExtractInstance.exhausted}" /></a>
                        </g:if>
                        <g:else>
                            <g:formatBoolean false="No" true="Yes" boolean="${RNA_ExtractInstance.exhausted}" />
                        </g:else>
                    </td>

                    <% def participantId = RNA_ExtractInstance.aliquot.specimen.participant.studySubject %>
                    <% participantId = participantId.first()%>
                    <% participantId = participantId.findResult {it.studySubjectIdentifier ? it : null}%>

                    <td>${fieldValue(bean: participantId, field: "studySubjectIdentifier")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </section>

    <table border="1" width="100%">
        <tr>
            <th style="background: rgba(25, 105, 255, 0.33)"><center>DNA Library</center></th>
        </tr>
    </table>

    <section id="show-dnaLibrary" class="first">
        <table class="table table-bordered margin-top-medium">
            <tbody>
            <% def dna_Libraries = DNA_Library.findAll {na_extract.aliquot.specimen.participant == participantSummary} %>
            <g:each in="${dna_Libraries}" var="dna_Library">
                <tr>
                    <td>
                        <g:link controller="DNA_Library" action="show" id="${dna_Library.id}">${dna_Library}</g:link><br/>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </section>
</g:if>


</body>

</html>