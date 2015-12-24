
<%@ page import="geldb.AliquotType; groovy.time.TimeCategory; groovy.time.TimeDuration; geldb.Aliquot" %>
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

                <td valign="top" class="value"><g:link controller="staffMember" action="show" id="${aliquotInstance?.derivedFrom?.derivedBy?.id}">${aliquotInstance?.derivedFrom?.derivedBy?.encodeAsHTML()}</g:link></td>

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

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.aliquotType.label" default="Aliquot Type" /></td>

            <td valign="top" class="value"><g:link controller="aliquotType" action="show" id="${aliquotInstance?.aliquotType?.id}">${aliquotInstance?.aliquotType?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.barcode.label" default="Barcode" /></td>

            <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "barcode")}</td>

        </tr>

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

                <td valign="top" class="value"><g:link controller="units" action="show" id="${aliquotInstance?.unit?.id}">${aliquotInstance?.unit?.encodeAsHTML()}</g:link></td>

            </tr>
        </g:if>

        <g:if test="${aliquotInstance?.derivedFrom?.derivationProcess?.name() == 'Tissue_disruption' || aliquotInstance?.derivedFrom?.derivationProcess?.name() == 'Tissue_disruption_centrifugation_with_buffer'}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.aliquotVolumeMass.label" default="Volume/Mass" /></td>

                <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "aliquotVolumeMass")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.unit.label" default="Unit" /></td>

                <td valign="top" class="value"><g:link controller="units" action="show" id="${aliquotInstance?.unit?.id}">${aliquotInstance?.unit?.encodeAsHTML()}</g:link></td>

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

                <td valign="top" class="value"><g:link controller="position" action="show" id="${aliquotInstance?.position?.id}">${aliquotInstance?.position?.encodeAsHTML()}</g:link></td>

            </tr>
        </g:if>

        <g:if test="${aliquotInstance.sampleTrackingEvent}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.sampleTrackingEvent.label" default="Sample Tracking Event" /></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${aliquotInstance.sampleTrackingEvent}" var="t">
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

        %{--<tr class="prop">--}%
            %{--<td valign="top" class="name"> Dispatched</td>--}%

            %{--<td valign="top" style="text-align: left;" class="value">--}%
                %{--<% def dispatchItem = DispatchItem?.listOrderById() %>--}%
                %{--<ul>--}%
                    %{--<g:each in="${dispatchItem}" var="item">--}%
                        %{--<g:if test="${item.identifiedSample.id == aliquotInstance.id}">--}%
                            %{--<li><g:link controller="dispatchItem" action="show" id="${item.id}">${item?.encodeAsHTML()}</g:link></li>--}%
                        %{--</g:if>--}%
                    %{--</g:each>--}%
                %{--</ul>--}%
            %{--</td>--}%

        %{--</tr>--}%

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
                <td valign="top" class="name"><g:message code="aliquot.fixationReport.label" default="Genomic Block Fixation Report" /></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${aliquotInstance.fixationReport}" var="f">
                            <li><g:link controller="fixationReport" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>
        </g:if>

        <g:if test="${aliquotInstance.dNA_Extract}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.dNA_Extract.label" default="DNA Extract" /></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${aliquotInstance.dNA_Extract}" var="d">
                            <li><g:link controller="DNA_Extract" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>
        </g:if>

        </tbody>
    </table>
</section>

<hr style="border:1; height:1px" />

<p class="text-primary">Available Actions</p>

<g:if test="${aliquotInstance?.position?.id == null && aliquotInstance?.exhausted != true}">
    <a class='btn btn-primary btn-small' <g:link controller="position" action="create" params="['containedSamples': aliquotInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'position.label', default: 'Position')])}</g:link>
</g:if>

<g:if test="${aliquotInstance?.specimen?.instanceOf(SolidSpecimen)}">
    <a class='btn btn-primary btn-small' <g:link controller="colocation" action="create" params="['aliquot.id': aliquotInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'colocation.label', default: 'Colocation')])}</g:link>
</g:if>

<g:if test="${!aliquotInstance.fixationReport && (aliquotInstance.aliquotType.aliquotTypeName == 'Punch Biopsy FFPE, NBF' || aliquotInstance.aliquotType.aliquotTypeName == 'Punch Biopsy FFPE')}">
    <a class='btn btn-primary btn-small' <g:link controller="fixationReport" action="create" params="['aliquot.id': aliquotInstance?.id, 'fixationStartDateAliquot': aliquotInstance?.specimen?.collectionDate]"><i class="glyphicon glyphicon-plus"></i> Add Genomic Block Fixation Report</g:link>
</g:if>

<g:if test="${(aliquotInstance?.aliquotType?.aliquotTypeName == 'Fresh Frozen Tissue' && aliquotInstance?.derivedFrom?.id == null) || (aliquotInstance?.aliquotType?.aliquotTypeName == 'Punch Biopsy Frozen' && aliquotInstance?.derivedFrom?.id == null)}">
    <a class='btn btn-primary btn-small' <g:link controller="derivation" action="create" params="['aliquot.id': aliquotInstance?.id, 'derivationProcess':'FrozenSection', 'aliquotType':geldb.AliquotType.findAllByAliquotTypeName('Section')?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'derivation.label', default: 'Derivation (Section)')])}</g:link>
    <a class='btn btn-primary btn-small' <g:link controller="derivation" action="create" params="['aliquot.id': aliquotInstance?.id, 'derivationProcess':'Tissue_disruption', 'aliquotType':geldb.AliquotType.findAllByAliquotTypeName('All Prep Lysate')?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'derivation.label', default: 'Derivation (All Prep lysate)')])}</g:link>
</g:if>

<g:if test="${aliquotInstance?.aliquotType?.aliquotTypeName == 'All Prep Lysate' && aliquotInstance?.derivedFrom?.id != null}">
    <a class='btn btn-primary btn-small' <g:link controller="derivation" action="create" params="['aliquot.id': aliquotInstance?.derivedFrom?.aliquot?.id, 'derivationProcess':aliquotInstance?.derivedFrom?.derivationProcess?.getKey(),
                                                                                                  'aliquotType':aliquotInstance?.aliquotType?.id, 'derivationDate':aliquotInstance?.derivedFrom?.derivationDate, 'derivedBy.id':aliquotInstance?.derivedFrom?.derivedBy?.id]"><i class="glyphicon glyphicon-plus"></i> Add Duplicate Aliquot</g:link>
</g:if>

<g:if test="${(!aliquotInstance?.derivedFrom?.aliquot?.gelSuitabilityReport && aliquotInstance?.aliquotType?.aliquotTypeName != 'Buffy Coat' && aliquotInstance?.aliquotType?.aliquotTypeName != 'Plasma' && !aliquotInstance?.gelSuitabilityReport && aliquotInstance?.aliquotType?.aliquotTypeName != 'Section'
        && aliquotInstance?.aliquotType?.aliquotTypeName != 'Blood Germline'&& aliquotInstance?.aliquotType?.aliquotTypeName != 'Plasma EDTA cfDNA'&& aliquotInstance?.aliquotType?.aliquotTypeName != 'Plasma Strek cfDNA'&& aliquotInstance?.aliquotType?.aliquotTypeName != 'Plasma PST'
        && aliquotInstance?.aliquotType?.aliquotTypeName != 'Blood PAXgene'&& aliquotInstance?.aliquotType?.aliquotTypeName != 'Serum SST' && aliquotInstance?.aliquotType?.aliquotTypeName != 'Full Blood' && aliquotInstance?.aliquotType?.aliquotTypeName != 'All Prep Lysate')}">
    <a class='btn btn-primary btn-small' <g:link controller="gelSuitabilityReport" action="create" params="['aliquot.id': aliquotInstance?.id]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'gelSuitabilityReport.label', default: 'GeL Suitability Report')])}</g:link>
</g:if>

<g:if test="${aliquotInstance?.derivedFrom?.id == null && aliquotInstance?.exhausted != true}">
    <a class='btn btn-primary btn-small' <g:link controller="aliquot" action="create" params="['specimen.id': aliquotInstance?.specimen?.id,'exhausted': aliquotInstance?.exhausted,'passFail': aliquotInstance?.passFail,
                                                                                           'passFailReason': aliquotInstance?.passFailReason,'notes': aliquotInstance?.notes,'createdOn':aliquotInstance?.createdOn,
                                                                                           'aliquotVolumeMass': aliquotInstance?.aliquotVolumeMass,'unit': aliquotInstance?.unit?.id,'blockNumber': aliquotInstance?.blockNumber,
                                                                                           'aliquotType': aliquotInstance?.aliquotType?.id, 'aliquotRanking': aliquotInstance?.aliquotRanking]"><i class="glyphicon glyphicon-plus"></i> ${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Duplicate Aliquot')])}</g:link>

</g:if>
<hr style="border:1; height:1px" />

</body>

</html>
