
<%@ page import="geldb.DispatchItem; geldb.SampleTrackingEvent; geldb.FixationReport; geldb.GelSuitabilityReport; geldb.SampleTrackingEventType; geldb.DNA_Extract; geldb.ExtractionType; geldb.AliquotType; groovy.time.TimeCategory; groovy.time.TimeDuration; geldb.Aliquot" %>
<%@ page import="geldb.SolidSpecimen" %>
<%@ page import="geldb.FluidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'aliquot.label', default: 'Aliquot')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-aliquot" class="first">

    <table class="table">
        <tbody>

        %{--<g:if test="${aliquotInstance?.derivedFrom?.id !=null}">--}%
            %{--<tr class="prop">--}%
                %{--<td valign="top" class="name"><g:message code="aliquot.derivedFrom.label" default="Derived From" /></td>--}%

                %{--<td valign="top" class="value"><g:link controller="derivation" action="show" id="${aliquotInstance?.derivedFrom?.id}">${aliquotInstance?.derivedFrom?.encodeAsHTML()}</g:link></td>--}%

            %{--</tr>--}%
        %{--</g:if>--}%

        <g:if test="${aliquotInstance?.derivedFrom?.id != null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.derivedFrom.aliquot.label" default="Parent Aliquot" /></td>

                <td valign="top" class="value"><g:link controller="aliquot" action="show" id="${aliquotInstance?.derivedFrom?.aliquot?.id}">${aliquotInstance?.derivedFrom?.aliquot?.encodeAsHTML()}</g:link></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="derivation.derivationDate.label" default="Derivation Date" /></td>

                <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${aliquotInstance?.derivedFrom?.derivationDate}" /></td>

            </tr>

            %{--<tr class="prop">--}%
                %{--<td valign="top" class="name"><g:message code="derivation.derivationTime.label" default="Derivation Time" /></td>--}%

                %{--<td valign="top" class="value">${fieldValue(bean: aliquotInstance?.derivedFrom, field: "derivationTime")}</td>--}%

            %{--</tr>--}%

            <tr class="prop">
                <td valign="top" class="name"><g:message code="derivation.derivedBy.label" default="Derived By" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance?.derivedFrom, field: "derivedBy")}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="derivation.derivationProcess.label" default="Derivation Process" /></td>

                <td valign="top" class="value">${aliquotInstance?.derivedFrom?.derivationProcess?.encodeAsHTML()}</td>

            </tr>
        </g:if>

        %{--<g:if test="${aliquotInstance?.colocation?.id !=null}">--}%
            %{--<tr class="prop">--}%
                %{--<td valign="top" class="name"><g:message code="aliquot.colocation.label" default="Colocation" /></td>--}%

                %{--<td valign="top" class="value"><g:link controller="colocation" action="show" id="${aliquotInstance?.colocation?.id}">${aliquotInstance?.colocation?.encodeAsHTML()}</g:link></td>--}%

            %{--</tr>--}%
        %{--</g:if>--}%

        <g:if test="${aliquotInstance?.derivedFrom?.id == null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.specimen.label" default="Specimen" /></td>

            <td valign="top" class="value">

                <% def fluidSpecimen = FluidSpecimen.listOrderById() %>
                <% def solidSpecimen = SolidSpecimen.listOrderById() %>

                <g:each in="${solidSpecimen}" var="item">
                    <g:if test="${item.id == aliquotInstance?.specimen?.id}">
                        <g:link controller="solidSpecimen" action="show" id="${aliquotInstance?.specimen?.id}">${aliquotInstance?.specimen?.encodeAsHTML()}</g:link>
                    </g:if>
                </g:each>

                <g:each in="${fluidSpecimen}" var="item">
                    <g:if test="${item.id == aliquotInstance?.specimen?.id}">
                        <g:link controller="fluidSpecimen" action="show" id="${aliquotInstance?.specimen?.id}">${aliquotInstance?.specimen?.encodeAsHTML()}</g:link></td>
                    </g:if>
                </g:each>

            </tr>
        </g:if>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.aliquotType.label" default="Aliquot Type" /></td>

            <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "aliquotType")}</td>
        </tr>

        <g:if test="${aliquotInstance?.derivedFrom?.id == null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.blockNumber.label" default="Block Number" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "blockNumber")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.createdOn.label" default="Created on" /></td>

                <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${aliquotInstance?.createdOn}" /></td>

            </tr>

            <%  TimeDuration duration = null;
                def isFluidSpecimen = aliquotInstance?.specimen?.instanceOf(FluidSpecimen)
                def formatCollectionTime = aliquotInstance?.specimen?.collectionTime?.toString()?.replace('.',':')?.replace(';',':')
                if (formatCollectionTime && aliquotInstance?.createdOn && aliquotInstance?.createdTime && isFluidSpecimen){
                    def collectionTime =  new Date().parse("yyy-MM-dd HH:mm", aliquotInstance?.createdOn?.format('yyy-MM-dd')?.toString() + " " + formatCollectionTime)
                    def createdTime = new Date().parse("yyy-MM-dd HH:mm", aliquotInstance?.createdTime?.toString())
                    duration = TimeCategory.minus(createdTime, collectionTime)
                    }
            %>
            <g:if test="${duration}">
                <tr class="prop">
                    <td valign="top" class="name">Processing Time</td>

                    <td valign="top" class="value">${duration}</td>

                </tr>
            </g:if>
        </g:if>

        <g:if test="${aliquotInstance?.derivedFrom?.id == null}">
            <tr class="prop">

                <td valign="top" class="name"><g:message code="aliquot.sapphireIdentifier.label" default="Biobanking Identifier" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "sapphireIdentifier")}</td>

            </tr>
        </g:if>

        <g:if test="${aliquotInstance?.derivedFrom?.id != null && aliquotInstance?.aliquotType?.aliquotTypeName == 'Section'}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.sapphireIdentifier.label" default="Slide Id (Frozen only)" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "sapphireIdentifier")}</td>
            </tr>
        </g:if>

        <g:if test="${aliquotInstance?.derivedFrom?.derivationProcess?.name() == 'Tissue_disruption' || aliquotInstance?.derivedFrom?.derivationProcess?.name() == 'Tissue_disruption_centrifugation_with_buffer'}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.sapphireIdentifier.label" default="Identifier" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "sapphireIdentifier")}</td>
            </tr>
        </g:if>

        <g:if test="${aliquotInstance?.aliquotType?.aliquotTypeName != "Section" }">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.barcode.label" default="Barcode" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "barcode")}</td>

            </tr>
        </g:if>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.exhausted.label" default="Exhausted"/></td>

            <g:if test="${aliquotInstance.exhausted == null}">
                <td valign="top" class="value"></td>
            </g:if>
            <g:else >
                <td valign="top" class="value"><g:formatBoolean boolean="${aliquotInstance?.exhausted}" true="Yes" false="No"/></td>
            </g:else>
        </tr>

        <g:if test="${aliquotInstance?.derivedFrom?.id == null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.notes.label" default="Notes" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "notes")}</td>

            </tr>
        </g:if>

        <g:if test="${aliquotInstance?.derivedFrom?.id == null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.aliquotVolumeMass.label" default="Aliquot Volume/Mass" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "aliquotVolumeMass")}</td>

            </tr>
        </g:if>

        <g:if test="${aliquotInstance?.derivedFrom?.id == null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.unit.label" default="Unit" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "unit")}</td>
            </tr>
        </g:if>

        <g:if test="${aliquotInstance?.derivedFrom?.derivationProcess?.name() == 'Tissue_disruption' || aliquotInstance?.derivedFrom?.derivationProcess?.name() == 'Tissue_disruption_centrifugation_with_buffer'}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.aliquotVolumeMass.label" default="Volume/Mass" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "aliquotVolumeMass")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.unit.label" default="Unit" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "unit")}</td>

            </tr>
        </g:if>

        <g:if test="${aliquotInstance?.derivedFrom?.id == null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.aliquotRanking.label" default="Aliquot Ranking" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "aliquotRanking")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.frozenBy.label" default="Frozen By (frozen sample only)" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "frozenBy")}</td>
            </tr>
        </g:if>

        <g:if test="${aliquotInstance?.position?.id != null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.position.label" default="Position" /></td>

                <g:if test="${aliquotInstance?.exhausted}">
                    <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "position")} <mark>(This position was occupied by the aliquot prior to exhaustion)</mark></td>
                </g:if>
                <g:else>
                    <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "position")}</td>
                </g:else>

            </tr>
        </g:if>

        <g:if test="${aliquotInstance.sampleTrackingEvent}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.sampleTrackingEvent.label" default="Tracking Event" /></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${aliquotInstance?.sampleTrackingEvent?.sort{it?.date?.toString() + it.time}}" var="t">
                            <li><g:link controller="sampleTrackingEvent" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>
        </g:if>

        <g:if test="${aliquotInstance.colocationWith || aliquotInstance.colocation}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.colocationWith.label" default="Colocation With" /></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${aliquotInstance.colocationWith}" var="c">
                            <li><g:link controller="colocation" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    <g:if test="${aliquotInstance.colocation}">
                        <li><g:link controller="colocation" action="show" id="${aliquotInstance?.colocation?.id}">${aliquotInstance?.colocation?.encodeAsHTML()}</g:link></li>
                    </g:if>
                    </ul>
                </td>
            </tr>
        </g:if>

        <g:if test="${aliquotInstance.derivation}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.derivation.label" default="Associated Derivatives" /></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${aliquotInstance.derivation}" var="d">
                            <g:each in="${d.derivedAliquots}" var="a">
                                <li><g:link controller="aliquot" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                            </g:each>
                        </g:each>
                    </ul>
                </td>

            </tr>
        </g:if>

        <g:if test="${aliquotInstance.gelSuitabilityReport}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.gelSuitabilityReport.label" default="GeL Suitability Report" /></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${aliquotInstance.gelSuitabilityReport}" var="d">
                            <li><g:link controller="gelSuitabilityReport" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>
        </g:if>

        <g:if test="${aliquotInstance.fixationReport}">
            <tr class="prop">
                <g:if test="${aliquotInstance.aliquotType.aliquotTypeName == 'Punch biopsy, PAXgene'}">
                    <td valign="top" class="name"><g:message code="aliquot.fixationReport.label" default="Fixation Report" /></td>
                </g:if>
                <g:else>
                    <td valign="top" class="name"><g:message code="aliquot.fixationReport.label" default="Genomic Block Fixation Report" /></td>
                </g:else>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${aliquotInstance.fixationReport}" var="f">
                            <li><g:link controller="fixationReport" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>
        </g:if>

        <tr class="prop">
            <td valign="top" class="name"> Dispatched</td>

            <td valign="top" style="text-align: left;" class="value">
                <% def dispatchItem = DispatchItem?.listOrderById() %>
                <g:each in="${dispatchItem}" var="item">
                    <g:if test="${item?.identifiedSample?.id == aliquotInstance?.id}">
                        <g:link controller="dispatchRecord" action="show" id="${item?.dispatchedBox?.dispatchRecord?.id}">${item?.dispatchedBox?.dispatchRecord}</g:link>
                    </g:if>
                </g:each>
            </td>

        </tr>

        </tbody>
    </table>
</section>

<g:if test="${aliquotInstance.dNA_Extract}">
    <table border="1" width="100%">
        <tr>
            <th style="background: rgba(25, 105, 255, 0.33)"><center>DNA/RNA Extract</center></th>
        </tr>
    </table>

    <section id="show-dnaExtract" class="first">
        <table class="table table-bordered margin-top-medium">

            <thead>
            <tr>
                <th>Extraction Type</th>

                <th>Sample Type</th>

                <th>Elution</th>

                <th>Pass Fail</th>

                <th>Barcode</th>

                <th>Extraction Date</th>

                <th>Exhausted</th>

                <th>Participant Id</th>

            </tr>
            </thead>
            <tbody>
            <g:each in="${aliquotInstance?.dNA_Extract?.sort{it?.extractionType?.extractionTypeName}}" var="DNA_ExtractInstance">
                <tr>
                    <td><g:link controller="DNA_Extract" action="show" id="${DNA_ExtractInstance?.id}">${fieldValue(bean: DNA_ExtractInstance, field: "extractionType")}</g:link></td>

                    <td>${fieldValue(bean: DNA_ExtractInstance?.aliquot?.first(), field: "aliquotType")}</td>

                    <td>${fieldValue(bean: DNA_ExtractInstance, field: "sapphireIdentifier")}</td>

                    <td>
                        <g:if test="${DNA_ExtractInstance.passFail}">
                            <g:formatBoolean true="Pass" false="Fail" boolean="${DNA_ExtractInstance.passFail}" />
                        </g:if>
                        <g:else>
                            <a class="text-danger"><g:formatBoolean boolean="${DNA_ExtractInstance.passFail}" true="Pass" false="Fail" /></a>
                        </g:else>
                    </td>

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
</g:if>

<hr/>

<p class="text-primary">Available Actions</p>

<g:if test="${aliquotInstance?.position?.id == null && aliquotInstance?.exhausted != true}">
    <a class='btn btn-primary btn-xs' <g:link controller="position" action="create" params="['containedSamples': aliquotInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'position.label', default: 'Position')])}</g:link>
</g:if>

<g:if test="${aliquotInstance?.specimen?.instanceOf(SolidSpecimen)}">
    <a class='btn btn-primary btn-xs' <g:link controller="colocation" action="create" params="['aliquot.id': aliquotInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'colocation.label', default: 'Colocation')])}</g:link>
</g:if>

<g:if test="${!aliquotInstance.fixationReport && (aliquotInstance.aliquotType.aliquotTypeName == 'Punch Biopsy FFPE, NBF' || aliquotInstance.aliquotType.aliquotTypeName == 'Punch Biopsy FFPE')}">
    <a class='btn btn-primary btn-xs' <g:link controller="fixationReport" action="create" params="['aliquot.id': aliquotInstance?.id, 'fixationStartDateAliquot': aliquotInstance?.specimen?.collectionDate]"><i class="glyphicon glyphicon-plus"></i> Add Genomic Block Fixation Report</g:link>
</g:if>

<g:if test="${!aliquotInstance.fixationReport && aliquotInstance.aliquotType.aliquotTypeName == 'Punch biopsy, PAXgene'}">
    <a class='btn btn-primary btn-xs' <g:link controller="fixationReport" action="create" params="['aliquot.id': aliquotInstance?.id, 'fixationTypeAliquot':'PAXgene']"><i class="glyphicon glyphicon-plus"></i> Add Fixation Report</g:link>
</g:if>

<g:if test="${(aliquotInstance?.aliquotType?.aliquotTypeName == 'Fresh Frozen Tissue' && aliquotInstance?.derivedFrom?.id == null) || (aliquotInstance?.aliquotType?.aliquotTypeName == 'Punch Biopsy Frozen' && aliquotInstance?.derivedFrom?.id == null)}">
    <a class='btn btn-primary btn-xs' <g:link controller="derivation" action="create" params="['aliquot.id': aliquotInstance?.id, 'derivationProcess':'FrozenSection', 'aliquotType':geldb.AliquotType.findAllByAliquotTypeName('Section')?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'derivation.label', default: 'Derivation (Section)')])}</g:link>
    <a class='btn btn-primary btn-xs' <g:link controller="derivation" action="create" params="['aliquot.id': aliquotInstance?.id, 'derivationProcess':'Tissue_disruption', 'aliquotType':geldb.AliquotType.findAllByAliquotTypeName('All Prep Lysate')?.id, aliquotVolumeMass:'0.6']"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'derivation.label', default: 'Derivation (All Prep lysate)')])}</g:link>
</g:if>

<g:if test="${aliquotInstance?.aliquotType?.aliquotTypeName == 'All Prep Lysate' && aliquotInstance?.derivedFrom?.id != null}">
    <a class='btn btn-primary btn-xs' <g:link controller="derivation" action="create" params="['aliquot.id': aliquotInstance?.derivedFrom?.aliquot?.id, 'derivationProcess':aliquotInstance?.derivedFrom?.derivationProcess?.getKey(),
                                                                                                  'aliquotType':aliquotInstance?.aliquotType?.id, 'derivationDate':aliquotInstance?.derivedFrom?.derivationDate,
                                                                                                  'derivedBy.id':aliquotInstance?.derivedFrom?.derivedBy?.id, aliquotVolumeMass:aliquotInstance?.aliquotVolumeMass]"><i class="glyphicon glyphicon-plus"></i> Add Duplicate Aliquot</g:link>
</g:if>

<g:if test="${(!aliquotInstance?.derivedFrom?.aliquot?.gelSuitabilityReport && aliquotInstance?.aliquotType?.aliquotTypeName != 'Buffy Coat' && aliquotInstance?.aliquotType?.aliquotTypeName != 'Plasma' && !aliquotInstance?.gelSuitabilityReport && aliquotInstance?.aliquotType?.aliquotTypeName != 'Section'
        && aliquotInstance?.aliquotType?.aliquotTypeName != 'Blood Germline'&& aliquotInstance?.aliquotType?.aliquotTypeName != 'Plasma EDTA cfDNA'&& aliquotInstance?.aliquotType?.aliquotTypeName != 'Plasma Strek cfDNA'&& aliquotInstance?.aliquotType?.aliquotTypeName != 'Plasma PST'
        && aliquotInstance?.aliquotType?.aliquotTypeName != 'Blood PAXgene'&& aliquotInstance?.aliquotType?.aliquotTypeName != 'Serum SST' && aliquotInstance?.aliquotType?.aliquotTypeName != 'Full Blood' && aliquotInstance?.aliquotType?.aliquotTypeName != 'All Prep Lysate')}">
    <a class='btn btn-primary btn-xs' <g:link controller="gelSuitabilityReport" action="create" params="['aliquot.id': aliquotInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'gelSuitabilityReport.label', default: 'GeL Suitability Report')])}</g:link>
</g:if>

<g:if test="${aliquotInstance?.derivedFrom?.id == null && aliquotInstance?.exhausted != true}">
    <a class='btn btn-primary btn-xs' <g:link controller="aliquot" action="create" params="['specimen.id': aliquotInstance?.specimen?.id,'exhausted': aliquotInstance?.exhausted,'passFail': aliquotInstance?.passFail,
                                                                                           'passFailReason': aliquotInstance?.passFailReason,'notes': aliquotInstance?.notes,'createdOn':aliquotInstance?.createdOn,
                                                                                           'aliquotVolumeMass': aliquotInstance?.aliquotVolumeMass,'unit': aliquotInstance?.unit?.id,'blockNumber': aliquotInstance?.blockNumber,
                                                                                           'aliquotType': aliquotInstance?.aliquotType?.id, 'aliquotRanking': aliquotInstance?.aliquotRanking]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Duplicate Aliquot')])}</g:link>

</g:if>

<g:if test="${((aliquotInstance.aliquotType.aliquotTypeName == 'Punch Biopsy Frozen' || aliquotInstance.aliquotType.aliquotTypeName == 'Punch Biopsy FFPE, NBF' || aliquotInstance.aliquotType.aliquotTypeName == 'Punch Biopsy FFPE') || aliquotInstance.aliquotType.aliquotTypeName == 'Section' ||
        aliquotInstance.aliquotType.aliquotTypeName == 'Punch biopsy, PAXgene' || aliquotInstance.aliquotType.aliquotTypeName == 'FNA' || aliquotInstance.aliquotType.aliquotTypeName == 'Needle biopsy') && (aliquotInstance?.sampleTrackingEvent?.empty)}">
    <a class='btn btn-primary btn-xs' <g:link controller="sampleTrackingEvent" action="create" params="['identifiedSample.id': aliquotInstance?.id, 'sampleTrackingEventType.id':SampleTrackingEventType.findBySampleTrackingEventTypeName('Dispatch to MDC lab')?.id]"><i class="glyphicon glyphicon-send"></i> Dispatch to MDC</g:link>
</g:if>

<g:if test="${((aliquotInstance.aliquotType.aliquotTypeName == 'Punch Biopsy Frozen' || aliquotInstance.aliquotType.aliquotTypeName == 'Punch Biopsy FFPE, NBF' || aliquotInstance.aliquotType.aliquotTypeName == 'Punch Biopsy FFPE') || aliquotInstance.aliquotType.aliquotTypeName == 'Section' ||
        aliquotInstance.aliquotType.aliquotTypeName == 'Punch biopsy, PAXgene' || aliquotInstance.aliquotType.aliquotTypeName == 'FNA' || aliquotInstance.aliquotType.aliquotTypeName == 'Needle biopsy') && (!aliquotInstance?.sampleTrackingEvent?.empty && !geldb.SampleTrackingEvent.findBySampleTrackingEventTypeAndIdentifiedSample(SampleTrackingEventType.findBySampleTrackingEventTypeName('Received at MDC lab'), aliquotInstance))}">
    <a class='btn btn-primary btn-xs' <g:link controller="sampleTrackingEvent" action="create" params="['identifiedSample.id': aliquotInstance?.id, 'sampleTrackingEventType.id':SampleTrackingEventType.findBySampleTrackingEventTypeName('Received at MDC lab')?.id]"><i class="glyphicon glyphicon-check"></i> Received at MDC</g:link>
</g:if>

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

                    <g:if test="${auditLogInstance.className == 'Aliquot'}">
                        <td>${fieldValue(bean: auditLogInstance, field: "eventName")} Aliquot</td>
                    </g:if>
                    <g:elseif test="${auditLogInstance.className == 'GelSuitabilityReport'}">
                        <td>${fieldValue(bean: auditLogInstance, field: "eventName")} Gel Suitability Report</td>
                    </g:elseif>
                    <g:elseif test="${auditLogInstance.className == 'FixationReport'}">
                        <td>${fieldValue(bean: auditLogInstance, field: "eventName")} Fixation Report</td>
                    </g:elseif>
                    <g:elseif test="${auditLogInstance.className == 'SampleTrackingEvent'}">
                        <td>${fieldValue(bean: auditLogInstance, field: "eventName")} ${SampleTrackingEvent.findById(auditLogInstance?.persistedObjectId)?.sampleTrackingEventType}</td>
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
