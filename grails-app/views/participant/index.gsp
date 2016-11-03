
<%@ page import="geldb.StudySubject; geldb.Participant" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'participant.label', default: 'Participant')}" />
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
                    <label class="control-label"><small>Export Participants</small></label>
                    <a class='btn btn-success btn-sm' onclick="getExcel()"  <g:link controller="participant" action="exportParticipants" params="['format': 'excel', 'extension': 'xls']"><i class="glyphicon glyphicon-export"></i> Excel Format</g:link>
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
            <filterpane:filterPane domain="geldb.Participant"
                                   excludeProperties="dateOfBirth"
                                   associatedProperties="studySubject.studySubjectIdentifier, studySubject.consentFormNumber, studySubject.consentFormVersion,
                                   studySubject.recruitedBy, studySubject.study.studyName"/>
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

<p>Number of records: ${participantInstanceTotal == null ? Participant.count(): participantInstanceTotal}</p>

<section id="index-participant" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
                <g:sortableColumn property="hospitalNumber" title="${message(code: 'participant.hospitalNumber.label', default: 'Hospital Number')}" />

                <g:sortableColumn property="familyName" title="${message(code: 'participant.familyName.label', default: 'Family Name')}" />
			
				<g:sortableColumn property="givenName" title="${message(code: 'participant.givenName.label', default: 'Given Name')}" />

				<g:sortableColumn property="centre" title="${message(code: 'participant.centre.label', default: 'Centre')}" />

                <g:sortableColumn property="studySubject.studySubjectIdentifier" title="${message(code: 'studySubject.studySubjectIdentifier.label', default: 'GeL Id/Participant Id')}"/>

                <th>Summary Report</th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${participantInstanceList}" status="i" var="participantInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${participantInstance.id}">${fieldValue(bean: participantInstance, field: "hospitalNumber")}</g:link></td>

                <td>${fieldValue(bean: participantInstance, field: "familyName")}</td>
			
				<td>${fieldValue(bean: participantInstance, field: "givenName")}</td>
			
				<td>${fieldValue(bean: participantInstance, field: "centre")}</td>

                <td>${fieldValue(bean: participantInstance.studySubject.findResult {it.studySubjectIdentifier ? it : null}, field: "studySubjectIdentifier")}</td>

                <%def gelID = participantInstance?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}%>
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
        <bs:paginate total="${participantInstanceTotal == null ? Participant.count(): participantInstanceTotal}" params="${filterParams}" />
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
        ${remoteFunction (controller: 'participant',
                        action: 'exportParticipants',
                        params:[format:'excel',extension:'xls'],
                        onSuccess:'hideSpinner()'
                )}
    }
</script>

</body>

</html>
