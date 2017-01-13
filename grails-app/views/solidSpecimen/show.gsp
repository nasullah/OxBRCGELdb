
<%@ page import="geldb.FFPE_Tissue_Report; geldb.SolidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'solidSpecimen.label', default: 'Main Specimen')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-solidSpecimen" class="first">

	<table class="table">
		<tbody>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimen.participant.label" default="Participant" /></td>

                <td valign="top" class="value"><g:link controller="participant" action="show" id="${solidSpecimenInstance?.participant?.id}">${solidSpecimenInstance?.participant?.encodeAsHTML()}</g:link></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimen.histologyNumber.label" default="Histology Number" /></td>

                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "histologyNumber")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimen.collectionMethod.label" default="Collection Method" /></td>

                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "collectionMethod")}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimen.anatomicalSite.label" default="Anatomical Site" /></td>

                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "anatomicalSite")}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimen.barcode.label" default="Barcode" /></td>

                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "barcode")}</td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.exhausted.label" default="Exhausted" /></td>
				
                <g:if test="${solidSpecimenInstance.exhausted == null}">
                    <td valign="top" class="value"><p class="text-danger">Not completed</p></td>
                </g:if>
                <g:else >
                    <td valign="top" class="value"><g:formatBoolean boolean="${solidSpecimenInstance?.exhausted}" true="Yes" false="No"/></td>
                </g:else>
			</tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="fluidSpecimen.passFailReason.label" default="Reference" /></td>

                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "reference")}</td>

            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.notes.label" default="Notes" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "notes")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.collectionDate.label" default="Collection Date" /></td>
				
				<td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${solidSpecimenInstance?.collectionDate}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.collectionTime.label" default="Collection Time" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "collectionTime")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.collectionLocation.label" default="Collection Location" /></td>
				
                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "collectionLocation")}</td>
			</tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="solidSpecimen.methodOfTransportToPathologist.label" default="Method Of Transport To Pathologist" /></td>

                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "methodOfTransportToPathologist")}</td>
            </tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.collectedBy.label" default="Collected By" /></td>
				
                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "collectedBy")}</td>
			</tr>
		
			%{--<tr class="prop">--}%
				%{--<td valign="top" class="name"><g:message code="solidSpecimen.preparedBy.label" default="Prepared By" /></td>--}%
				%{----}%
				%{--<td valign="top" class="value"><g:link controller="staffMember" action="show" id="${solidSpecimenInstance?.preparedBy?.id}">${solidSpecimenInstance?.preparedBy?.encodeAsHTML()}</g:link></td>--}%
				%{----}%
			%{--</tr>--}%
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.surgeon.label" default="Surgeon" /></td>
				
                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "surgeon")}</td>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="solidSpecimen.pathologist.label" default="Pathologist" /></td>
				
                <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "pathologist")}</td>
			</tr>

            <g:if test="${solidSpecimenInstance?.collectionMethod?.collectionMethodName == 'Biopsy'}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="solidSpecimen. numberOfBiopsies.label" default="Number of Biopsies" /></td>

                    <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "numberOfBiopsies")}</td>
                </tr>
            </g:if>
		
			<tr class="prop">
                <g:if test="${solidSpecimenInstance?.collectionMethod?.collectionMethodName == 'Biopsy'}">
                    <td valign="top" class="name"><g:message code="solidSpecimen.specimenWeight.label" default="Gauge of Biopsies (mm)" /></td>
                </g:if>
                <g:else >
                    <td valign="top" class="name"><g:message code="solidSpecimen.specimenWeight.label" default="Specimen Weight" /></td>
                </g:else>
				
				<td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "specimenWeight")}</td>
				
			</tr>

            <g:if test="${solidSpecimenInstance?.collectionMethod?.collectionMethodName != 'Biopsy'}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="solidSpecimen.massUnit.label" default="Unit" /></td>

                    <td valign="top" class="value">${fieldValue(bean: solidSpecimenInstance, field: "massUnit")}</td>
                </tr>
            </g:if>

            <g:if test="${solidSpecimenInstance.postmortem}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="solidSpecimen.postmortem.label" default="Postmortem" /></td>

                    <td valign="top" class="value"><g:link controller="postmortem" action="show" id="${solidSpecimenInstance?.postmortem?.id}">${solidSpecimenInstance?.postmortem?.encodeAsHTML()}</g:link></td>

                </tr>
            </g:if>

            <g:if test="${solidSpecimenInstance.position}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="solidSpecimen.position.label" default="Position" /></td>

                    <td valign="top" class="value"><g:link controller="position" action="show" id="${solidSpecimenInstance?.position?.id}">${solidSpecimenInstance?.position?.encodeAsHTML()}</g:link></td>

                </tr>
            </g:if>

            <g:if test="${solidSpecimenInstance.fFPE_Tissue_Report}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="solidSpecimen.fFPE_Tissue_Report.label" default="Main Specimen Report" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <ul>
                            <g:each in="${solidSpecimenInstance.fFPE_Tissue_Report}" var="f">
                                <li><g:link controller="FFPE_Tissue_Report" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                            </g:each>
                        </ul>
                    </td>

                </tr>
            </g:if>

            <g:if test="${solidSpecimenInstance.sampleTrackingEvent}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="solidSpecimen.sampleTrackingEvent.label" default="Sample Tracking Event" /></td>

                    <td valign="top" style="text-align: left;" class="value">
                        <ul>
                        <g:each in="${solidSpecimenInstance.sampleTrackingEvent?.sort{it?.date?.toString() + it.time}}" var="t">
                            <li><g:link controller="sampleTrackingEvent" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
                        </g:each>
                        </ul>
                    </td>

                </tr>
            </g:if>

            %{--<tr class="prop">--}%
                %{--<td valign="top" class="name"> Dispatched</td>--}%

                %{--<td valign="top" style="text-align: left;" class="value">--}%
                    %{--<% def dispatchItem = DispatchItem?.listOrderById() %>--}%
                    %{--<ul>--}%
                        %{--<g:each in="${dispatchItem}" var="item">--}%
                            %{--<g:if test="${item.identifiedSample.id == solidSpecimenInstance.id}">--}%
                                %{--<li><g:link controller="dispatchItem" action="show" id="${item.id}">${item?.encodeAsHTML()}</g:link></li>--}%
                            %{--</g:if>--}%
                        %{--</g:each>--}%
                    %{--</ul>--}%
                %{--</td>--}%

            %{--</tr>--}%
		
		</tbody>
	</table>
</section>

<g:if test="${solidSpecimenInstance.aliquot}">
    <table border="1" width="100%">
        <tr>
            <th style="background: rgba(25, 105, 255, 0.33)"><center>Aliquots</center></th>
        </tr>
    </table>

    <section id="show-solidSpecimenAliquots" class="first">
        <table class="table table-bordered margin-top-medium">
            <thead>
            <tr>

                <th>Aliquot Type</th>

                <th>Identifier</th>

                <th>Barcode</th>

                <th>Aliq. Rank.</th>

                <th>GeL Suit. Rep.</th>

                <th>Suitable</th>

                <th>Geno. Bl. Fix. Rep.</th>

                <th>Exhausted</th>

                <th>Participant Id</th>

            </tr>
            </thead>
            <tbody>
            <g:each in="${solidSpecimenInstance?.aliquot?.sort{it?.aliquotType?.aliquotTypeName}}" var="aliquotInstance">
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
            </g:each>
            </tbody>
        </table>
    </section>
</g:if>

<hr/>

<p class="text-primary">Available Actions</p>

<g:if test="${!solidSpecimenInstance.fFPE_Tissue_Report}">
        <a class='btn btn-primary btn-xs' <g:link controller="FFPE_Tissue_Report" action="create" params="['solidSpecimen.id': solidSpecimenInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'fFPE_Tissue_Report.label', default: 'Main Specimen Report')])}</g:link>
</g:if>

%{--<g:if test="${!solidSpecimenInstance.postmortem}">--}%
        %{--<a class='btn btn-primary btn-small' <g:link controller="postmortem" action="create" params="['specimen.id': solidSpecimenInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'postmortem.label', default: 'Postmortem')])}</g:link>--}%
%{--</g:if>--}%

<hr/>

<sec:ifAnyGranted roles="ROLE_ADMIN">
    <h2>Audit</h2>
    <section id="list-participant" class="first">

        <table class="table table-bordered margin-top-medium">
            <thead>
            <tr>
                <g:sortableColumn property="dateCreated" title="Date & Time" />

                <g:sortableColumn property="actor" title="Username" />

                <g:sortableColumn property="eventName" title="Event" />

                <g:sortableColumn property="persistedObjectId" title="Record" />

                <g:sortableColumn property="oldValue" title="Old Value" />

                <g:sortableColumn property="newValue" title="New Value" />

            </tr>
            </thead>
            <tbody>
            <g:each in="${listAuditLogData}" status="i" var="auditLogInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:formatDate date="${auditLogInstance.dateCreated}" /></td>

                    <td>${fieldValue(bean: auditLogInstance, field: "actor")}</td>

                    <g:if test="${auditLogInstance.className == 'SolidSpecimen'}">
                        <td>${fieldValue(bean: auditLogInstance, field: "eventName")} Solid Specimen</td>
                    </g:if>
                    <g:elseif test="${auditLogInstance.className == 'FFPE_Tissue_Report'}">
                        <td>${fieldValue(bean: auditLogInstance, field: "eventName")} Main Specimen Report</td>
                    </g:elseif>

                    <td>${fieldValue(bean: auditLogInstance, field: "persistedObjectId")}</td>

                    <td>${fieldValue(bean: auditLogInstance, field: "oldValue")}</td>

                    <td>${fieldValue(bean: auditLogInstance, field: "newValue")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>

    </section>
</sec:ifAnyGranted>

</body>

</html>
