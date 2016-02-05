
<%@ page import="geldb.SolidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'solidSpecimen.label', default: 'Available Main Specimen')}" />
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
                    <label class="control-label"><small>Export Main Specimens & Main Specimens Reports</small></label>
                    <a class='btn btn-success btn-sm' onclick="getExcel()"  <g:link controller="solidSpecimen" action="exportSolidSpecimens" params="['format': 'excel', 'extension': 'xls']"><i class="glyphicon glyphicon-export"></i> Excel Format</g:link>
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
            <filterpane:filterPane domain="geldb.SolidSpecimen"
                                   excludeProperties="vasculerClampingTimeAtSurgery, collectionDate, sapphireIdentifier"
                                   associatedProperties="participant.familyName,participant.givenName,
                                             participant.nHSNumber,participant.hospitalNumber,
                                             participant.diagnosis, participant.studySubject.studySubjectIdentifier"/>
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

<section id="index-solidSpecimen" class="first">

	<table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <g:sortableColumn property="sapphireIdentifier" title="${message(code: 'solidSpecimen.histologyNumber.label', default: 'Histology Number')}" />

            <g:sortableColumn property="anatomicalSite" title="${message(code: 'solidSpecimen.anatomicalSite.label', default: 'Anatomical Site')}" />

            <g:sortableColumn property="pathologist" title="${message(code: 'solidSpecimen.pathologist.label', default: 'Reporting Pathologist')}" />

            <g:sortableColumn property="participant.studySubject.studySubjectIdentifier" title="${message(code: 'participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

            <th>Summary Report</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${solidSpecimenInstanceList}" status="i" var="solidSpecimenInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${solidSpecimenInstance.id}">${fieldValue(bean: solidSpecimenInstance, field: "histologyNumber")}</g:link></td>

                <td>${fieldValue(bean: solidSpecimenInstance, field: "anatomicalSite")}</td>

                <td>${fieldValue(bean: solidSpecimenInstance, field: "pathologist")}</td>

                <td>${fieldValue(bean: solidSpecimenInstance.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

                <%def gelID = solidSpecimenInstance?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}%>
                <g:if test="${gelID}">
                    <td><a class='btn btn-primary btn-xs' <g:link controller="participant" action="summaryReport" params="[gelStudyId : gelID]"><i class="glyphicon glyphicon-info-sign"></i> View Summary Report</g:link></td>
                </g:if>
                <g:else>
                    <td></td>
                </g:else>

            </tr>
        </g:each>
        </tbody>
	</table>
    <div class="pagination">
        <g:paginate total="${solidSpecimenInstanceTotal == null ? solidSpecimenInstanceCount: solidSpecimenInstanceTotal}" params="${filterParams}" />
        <a>Number of records: ${solidSpecimenInstanceTotal == null ? solidSpecimenInstanceCount: solidSpecimenInstanceTotal}</a>
    </div>
</section>

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
        ${remoteFunction (controller: 'solidSpecimen',
                        action: 'exportSolidSpecimens',
                        params:[format:'excel',extension:'xls'],
                        onSuccess:'hideSpinner()'
                )}
    }
</script>

</body>

</html>
