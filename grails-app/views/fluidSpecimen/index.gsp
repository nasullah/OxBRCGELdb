
<%@ page import="geldb.FluidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'fluidSpecimen.label', default: 'Available Fluid Specimen')}" />
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
                <div class="col-md-4">
                    <label class="control-label"><small>Export Fluid Specimens</small></label>
                    <a class='btn btn-success btn-sm' onclick="getExcel()"  <g:link controller="fluidSpecimen" action="exportFluidSpecimens" params="['format': 'excel', 'extension': 'xls']"><i class="glyphicon glyphicon-export"></i> Excel Format</g:link>
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

<hr/>

<filterpane:filterButton text="Filter This List" />
<filterpane:filterPane domain="geldb.FluidSpecimen"
                       excludeProperties="collectionDate, sapphireIdentifier"
                       associatedProperties="participant.familyName, participant.givenName,
                                             participant.nHSNumber,participant.hospitalNumber,
                                             participant.studySubject.studySubjectIdentifier,
                                             participant.centre.centreName"/>

<hr/>

<div class="container">
    <div class="text-warning text-center">
        <b>
            <filterpane:isFiltered>Filter applied!</filterpane:isFiltered>
            <filterpane:isNotFiltered>Not filtered!</filterpane:isNotFiltered>
        </b>
    </div>
</div>

<p>Number of records: ${fluidSpecimenInstanceTotal == null ? fluidSpecimenInstanceCount: fluidSpecimenInstanceTotal}</p>

<section id="index-fluidSpecimen" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>

				<g:sortableColumn property="fluidSampleType" title="${message(code: 'fluidSpecimen.fluidSampleType.label', default: 'Fluid Sample Type')}" />

                <g:sortableColumn property="primaryContainer" title="${message(code: 'fluidSpecimen.primaryContainer.label', default: 'Primary Container')}" />

                <g:sortableColumn property="collectionDate" title="${message(code: 'fluidSpecimen.collectionDate.label', default: 'Collection Date')}" />

				<g:sortableColumn property="timePoint" title="${message(code: 'fluidSpecimen.timePoint.label', default: 'Time Point')}" />

				<g:sortableColumn property="participant.studySubject.studySubjectIdentifier" title="${message(code: 'fluidSpecimen.participant.studySubject.studySubjectIdentifier.label', default: "GeL Id/Participant Id")}" />

                <th>Summary Report</th>

			</tr>
		</thead>
		<tbody>
		<g:each in="${fluidSpecimenInstanceList}" status="i" var="fluidSpecimenInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

				<td><g:link action="show" id="${fluidSpecimenInstance.id}">${fieldValue(bean: fluidSpecimenInstance, field: "fluidSampleType")}</g:link></td>

                <td>${fieldValue(bean: fluidSpecimenInstance, field: "primaryContainer")}</td>

                <td><g:formatDate format="yyyy-MM-dd" date="${fluidSpecimenInstance.collectionDate}" /></td>

                <td>${fieldValue(bean: fluidSpecimenInstance, field: "timePoint")}</td>

				<td>${fieldValue(bean: fluidSpecimenInstance.participant.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

                <%def gelID = fluidSpecimenInstance?.participant?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}%>
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
        <bs:paginate total="${fluidSpecimenInstanceTotal == null ? fluidSpecimenInstanceCount: fluidSpecimenInstanceTotal}" params="${filterParams}" />
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
        ${remoteFunction (controller: 'fluidSpecimen',
                        action: 'exportFluidSpecimens',
                        params:[format:'excel',extension:'xls'],
                        onSuccess:'hideSpinner()'
                )}
    }
</script>

</body>

</html>
