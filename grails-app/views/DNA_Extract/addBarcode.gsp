
<%@ page import="geldb.AliquotType; geldb.DNA_Extract" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Add Barcode</title>
</head>

<body>

<hr/>

<div class="row">
    <div class="col-md-3">
        <g:form controller="DNA_Extract" action="addBarcode">
            <div class="input-group">
                <div class="input-group-btn">
                    <label class="control-label"><small>Start Date </small></label>
                    <bs:datePicker name="startDateDNA" precision="day" value="${Date.parse("yyyy-MM-dd", params.startDateDNA ?: new Date().format('yyy-MM-dd').toString() )}"/>
                    <label class="control-label"><small>End Date </small></label>
                    <bs:datePicker name="endDateDNA" precision="day" value="${Date.parse("yyyy-MM-dd", params.endDateDNA ?: new Date().format('yyy-MM-dd').toString())}"/>
                    <g:select class="form-control" id="aliquotTypeDNA" name="aliquotTypeDNA" from="${AliquotType.list().sort{it.aliquotTypeName}}" required="" value="${params.aliquotTypeDNA}" optionKey="id" noSelection="['':'- Choose Sample Type -']"/>
                    <button type="submit" class="btn btn-primary btn" ><span class="glyphicon glyphicon-search"></span> Find</button>
                </div>
            </div>
        </g:form>
    </div>
</div>

<section id="list-DNA_Extract" class="first">

    <table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <g:sortableColumn property="extractionType" title="${message(code: 'DNA_Extract.extractionType.label', default: 'Extraction Type')}" />

            <g:sortableColumn property="sapphireIdentifier" title="${message(code: 'DNA_Extract.sapphireIdentifier.label', default: 'DNA/RNA Elution')}" />

            <g:sortableColumn property="extractionDate" title="${message(code: 'DNA_Extract.extractionDate.label', default: 'Extraction Date')}" />

            <g:sortableColumn property="extractedBy" title="${message(code: 'DNA_Extract.extractedBy.label', default: 'Extracted By')}" />

            <g:sortableColumn property="dNAConcentrationQubit" title="${message(code: 'DNA_Extract.dNAConcentrationQubit.label', default: 'Conc. (Qubit)')}" />

            <g:sortableColumn property="aliquot.specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'aliquot.specimen.participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

            <g:sortableColumn property="barcode" title="${message(code: 'DNA_Extract.barcode.label', default: "Barcode")}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${listDNA}" status="i" var="DNA_ExtractInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${DNA_ExtractInstance.id}">${fieldValue(bean: DNA_ExtractInstance, field: "extractionType")}</g:link></td>

                <td>${fieldValue(bean: DNA_ExtractInstance, field: "sapphireIdentifier")}</td>

                <td><g:formatDate format="yyyy-MM-dd" date="${DNA_ExtractInstance?.extractionDate}" /></td>

                <td>${fieldValue(bean: DNA_ExtractInstance, field: "extractedBy")}</td>

                <td>${fieldValue(bean: DNA_ExtractInstance, field: "dNAConcentrationQubit")}</td>

                <% def gelId = DNA_ExtractInstance.aliquot.specimen.participant.studySubject %>
                <% gelId = gelId.first()%>
                <% gelId =gelId.findResult {it.studySubjectIdentifier ? it : null}%>

                <td>${fieldValue(bean: gelId, field: "studySubjectIdentifier")}</td>

                <td style="padding:0">
                    <g:form action="updateBarcode" params="[startDateDNA:params.startDateDNA, endDateDNA: params.endDateDNA, aliquotTypeDNA:params.aliquotTypeDNA]" role="form" >
                        <g:hiddenField name="DNA_ExtractInstance" value="${DNA_ExtractInstance.id}" />
                        <g:if test="${DNA_ExtractInstance.barcode}">
                            <g:textField class="form-control" name="barcode" value="${DNA_ExtractInstance?.barcode}" readonly="" />
                        </g:if>
                        <g:else>
                            <g:textField class="form-control" name="barcode" value="${DNA_ExtractInstance?.barcode}" />
                        </g:else>
                    </g:form>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</section>

</body>

</html>