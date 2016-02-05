
<%@ page import="geldb.DNA_Extract" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'DNA_Extract.label', default: 'Available DNA/RNA Extract')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>

<body>

<sec:ifAnyGranted roles="ROLE_ADMIN">
    <div style="background: rgba(139, 240, 37, 0.14);">
        <div class="container">
            <p>
            <h5 class="text-center">Export Data</h5>
            <p>
            <div class="row">
                <div class="col-md-6">
                    <label class="control-label"><small>Export elements of DNA Extracts & GEL Suitability reports</small></label>
                    <a class='btn btn-success btn-sm' onclick="getExcel()"  <g:link controller="DNA_Extract" action="exportAllDNAExtracts" params="['format': 'excel', 'extension': 'xls']"><i class="glyphicon glyphicon-export"></i> Excel Format</g:link>
                    <div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Processing&hellip;"/>
                        <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="spinner" />
                    </div>
                </div>
            </div>
            <p>
            <p>
        </div>
    </div>
</sec:ifAnyGranted>
<p>
<p>
<div style="background: rgba(80, 110, 56, 0.04);">
    <div class="container">
        <p>
        <h5 class="text-center">Search Options</h5>
        <p>
            <filterpane:filterButton text="Filter This List" />
            <filterpane:filterPane domain="geldb.DNA_Extract"
                                   excludeProperties="extractionDate"
                                   associatedProperties="aliquot.specimen.participant.familyName, aliquot.specimen.participant.givenName, aliquot.specimen.participant.diagnosis,
                                             aliquot.specimen.participant.nHSNumber, aliquot.specimen.participant.hospitalNumber, extractionKit.extractionKitName,
                                             aliquot.specimen.participant.studySubject.studySubjectIdentifier"/>
        <p>
        <p>
    </div>
</div>

<hr/>

<div class="container">
    <div class="text-warning text-center">
        <b>
            <filterpane:isFiltered>Filter applied!</filterpane:isFiltered>
            <filterpane:isNotFiltered>Not filtered!</filterpane:isNotFiltered>
        </b>
    </div>
</div>

<section id="index-DNA_Extract" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>

                <g:sortableColumn property="extractionType" title="${message(code: 'DNA_Extract.extractionType.label', default: 'Extraction Type')}" />

                <g:sortableColumn property="extractionDate" title="${message(code: 'DNA_Extract.extractionDate.label', default: 'Extraction Date')}" />

                <g:sortableColumn property="sapphireIdentifier" title="${message(code: 'DNA_Extract.sapphireIdentifier.label', default: 'DNA/RNA Elution')}" />

				<g:sortableColumn property="passFail" title="${message(code: 'DNA_Extract.passFail.label', default: 'Pass Fail')}" />

				<g:sortableColumn property="aliquot.specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'aliquot.specimen.participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

                <th>Summary Report</th>

			</tr>
		</thead>
		<tbody>
		<g:each in="${DNA_ExtractInstanceList}" status="i" var="DNA_ExtractInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${DNA_ExtractInstance.id}">${fieldValue(bean: DNA_ExtractInstance, field: "extractionType")}</g:link></td>

                <td><g:formatDate format="yyyy-MM-dd" date="${DNA_ExtractInstance?.extractionDate}" /></td>

                <td>${fieldValue(bean: DNA_ExtractInstance, field: "sapphireIdentifier")}</td>

				<td><g:formatBoolean boolean="${DNA_ExtractInstance.passFail}" true="Pass" false="Fail" /></td>

                <% def gelId = DNA_ExtractInstance.aliquot.specimen.participant.studySubject %>
                <% gelId = gelId.first()%>
                <% gelId = gelId.findResult {it.studySubjectIdentifier ? it : null}%>

                <td>${fieldValue(bean: gelId, field: "studySubjectIdentifier")}</td>

                <g:if test="${gelId}">
                    <td><a class='btn btn-primary btn-xs' <g:link controller="participant" action="summaryReport" params="[gelStudyId : gelId.studySubjectIdentifier]"><i class="glyphicon glyphicon-info-sign"></i> View Summary Report</g:link></td>
                </g:if>
                <g:else>
                    <td></td>
                </g:else>

			</tr>
		</g:each>
		</tbody>
	</table>
    <div class="pagination">
        <g:paginate total="${DNA_ExtractInstanceTotal == null ? DNA_ExtractInstanceCount: DNA_ExtractInstanceTotal}" params="${filterParams}" />
        <a>Number of records: ${DNA_ExtractInstanceTotal == null ? DNA_ExtractInstanceCount: DNA_ExtractInstanceTotal}</a>
    </div>
</section>

<hr style="border:1; height:1px" />

<g:form action="uploadFile" method="post" enctype="multipart/form-data">
    <p>
    </p>
    <p class="text-success">Upload file to generate DNA extract records</p>
    <input type="file" name="file" id="file" />
    <p>
    </p>
    <button type="submit" class="btn btn-success btn-xs" value="Upload"><span class="glyphicon glyphicon-upload"></span> Upload</button>
</g:form>

<hr style="border:1; height:1px" />

<g:javascript plugin="jquery" library="jquery" />
<script>
    function showSpinner() {
        $('#spinner').show();
    }
    function hideSpinner() {
        $('#spinner').hide();
    }
    function getExcel(){
        showSpinner();
        ${remoteFunction (controller: 'DNA_Extract',
                        action: 'exportAllDNAExtracts',
                        params:[format:'excel',extension:'xls'],
                        onSuccess:'hideSpinner()'
                )}
    }
</script>

</body>

</html>
