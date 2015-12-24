
<%@ page import="geldb.ExtractionType; geldb.DNA_Extract" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Worklists</title>

</head>

<body>

<p>
<p>

<div class="row">
    <div class="col-lg-6">
        <label class="control-label"> Worklists</label>
        <g:form controller="DNA_Extract" action="workLists">
            <div class="input-group">
                <g:select class="form-control" id="sampleType" name="sampleType" from="${['Samples awaiting FF DNA extraction', 'Samples awaiting FFPE DNA extraction', 'Samples awaiting Germline DNA extraction']}" onchange="getSelectedType()" required="" noSelection="['':'- Choose Worklist Type -']"/>
                <div class="input-group-btn">
                    <button type="submit" class="btn btn-success" ><span class="glyphicon glyphicon-search"></span> Find Work List</button>
                </div>
            </div>
        </g:form>
    </div>
</div>

<hr/>

<p class="text-danger">${title}</p>

<section id="index-aliquot" class="first">

    <table class="table table-bordered margin-top-medium">
        <thead>
        <tr>
            <g:sortableColumn property="aliquotType" title="${message(code: 'aliquot.aliquotType.label', default: 'Aliquot Type')}" />

            <g:sortableColumn property="blockNumber" title="${message(code: 'aliquot.blockNumber.label', default: 'Aliquot Identifier')}" />

            <g:sortableColumn property="specimen.timePoint" title="${message(code: 'aliquot.specimen.timePoint.label', default: 'Time Point')}" />

            <g:sortableColumn property="aliquotRanking" title="${message(code: 'aliquot.aliquotRanking.label', default: 'Aliquot Ranking')}" />

            <g:sortableColumn property="specimen.collectionDate" title="${message(code: 'aliquot.specimen.collectionDate.label', default: "Specimen Collection Date")}" />

            <g:sortableColumn property="specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'specimen.participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

            <th><g:message code="specimen.label" default="Action" /></th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${aliquotInstanceList}" status="i" var="aliquotInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link controller="aliquot" action="show" id="${aliquotInstance.id}">${fieldValue(bean: aliquotInstance, field: "aliquotType")}</g:link></td>

                <g:if test="${aliquotInstance.blockNumber != null}">
                    <td>${fieldValue(bean: aliquotInstance, field: "blockNumber")}</td>
                </g:if>

                <g:else>
                    <td>${fieldValue(bean: aliquotInstance, field: "sapphireIdentifier")}</td>
                </g:else>

                <g:if test="${geldb.SolidSpecimen.find{aliquot.id == aliquotInstance.id }}">
                    <td></td>
                </g:if>

                <g:else>
                    <td>${fieldValue(bean: aliquotInstance?.specimen, field: "timePoint")}</td>
                </g:else>

                <td>${fieldValue(bean: aliquotInstance, field: "aliquotRanking")}</td>

                <td><g:formatDate format="yyyy-MM-dd" date="${aliquotInstance.specimen.collectionDate}" /></td>

                <td>${fieldValue(bean: aliquotInstance.specimen.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

                <td><a class='btn btn-primary btn-xs' <g:link controller="DNA_Extract" action="create" params="['aliquot': aliquotInstance?.id,'extractionType':geldb.ExtractionType?.findByExtractionTypeName('DNA Extraction')?.id]"><i class="glyphicon glyphicon-plus"></i> Add DNA Extract</g:link></td>

            </tr>
        </g:each>
        </tbody>
    </table>
</section>

</body>

</html>