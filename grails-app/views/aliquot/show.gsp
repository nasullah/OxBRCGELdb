
<%@ page import="geldb.Aliquot" %>
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



        <g:if test="${aliquotInstance?.derivedFrom?.id !=null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.derivedFrom.label" default="Derived From" /></td>

                <td valign="top" class="value"><g:link controller="derivation" action="show" id="${aliquotInstance?.derivedFrom?.id}">${aliquotInstance?.derivedFrom?.encodeAsHTML()}</g:link></td>

            </tr>
        </g:if>

        <g:if test="${aliquotInstance?.colocation?.id !=null}">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="aliquot.colocation.label" default="Colocation" /></td>

                <td valign="top" class="value"><g:link controller="colocation" action="show" id="${aliquotInstance?.colocation?.id}">${aliquotInstance?.colocation?.encodeAsHTML()}</g:link></td>

            </tr>
        </g:if>

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

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.blockNumber.label" default="Block Number" /></td>

            <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "blockNumber")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.biobankIdentifier.label" default="Biobank Identifier" /></td>

            <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "biobankIdentifier")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.exhausted.label" default="Exhausted" /></td>

            <td valign="top" class="value"><g:formatBoolean boolean="${aliquotInstance?.exhausted}" /></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.passFail.label" default="Pass Fail" /></td>

            <td valign="top" class="value"><g:formatBoolean boolean="${aliquotInstance?.passFail}" /></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.passFailReason.label" default="Pass Fail Reason" /></td>

            <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "passFailReason")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.notes.label" default="Notes" /></td>

            <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "notes")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.aliquotType.label" default="Aliquot Type" /></td>

            <td valign="top" class="value"><g:link controller="aliquotType" action="show" id="${aliquotInstance?.aliquotType?.id}">${aliquotInstance?.aliquotType?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.barcode.label" default="Barcode" /></td>

            <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "barcode")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.position.label" default="Position" /></td>

            <td valign="top" class="value"><g:link controller="position" action="show" id="${aliquotInstance?.position?.id}">${aliquotInstance?.position?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.aliquotVolumeMass.label" default="Aliquot Volume/Mass" /></td>

            <td valign="top" class="value">${fieldValue(bean: aliquotInstance, field: "aliquotVolumeMass")}</td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.unit.label" default="Unit" /></td>

            <td valign="top" class="value"><g:link controller="units" action="show" id="${aliquotInstance?.unit?.id}">${aliquotInstance?.unit?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.aliquotReport.label" default="Aliquot Report" /></td>

            <td valign="top" class="value"><g:link controller="aliquotReport" action="show" id="${aliquotInstance?.aliquotReport?.id}">${aliquotInstance?.aliquotReport?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.colocationWith.label" default="Colocation With" /></td>

            <td valign="top" style="text-align: left;" class="value">
                <ul>
                    <g:each in="${aliquotInstance.colocationWith}" var="c">
                        <li><g:link controller="colocation" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                    </g:each>
                </ul>
            </td>

        </tr>

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

        <tr class="prop">
            <td valign="top" class="name"><g:message code="aliquot.derivation.label" default="Derivation" /></td>

            <td valign="top" style="text-align: left;" class="value">
                <ul>
                    <g:each in="${aliquotInstance.derivation}" var="d">
                        <li><g:link controller="derivation" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
                    </g:each>
                </ul>
            </td>

        </tr>

        </tbody>
    </table>
</section>
<hr style="border:1; height:1px" />

<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="aliquot" action="create" params="['specimen.id': aliquotInstance?.specimen,'exhausted': aliquotInstance?.exhausted,'passFail': aliquotInstance?.passFail,
                                                                                                    'passFailReason': aliquotInstance?.passFailReason,'notes': aliquotInstance?.notes,'barcode': aliquotInstance?.barcode,
                                                                                                    'aliquotVolumeMass': aliquotInstance?.aliquotVolumeMass,'unit': aliquotInstance?.unit?.id,'blockNumber': aliquotInstance?.blockNumber,
                                                                                                    'aliquotType': aliquotInstance?.aliquotType?.id,'biobankIdentifier': aliquotInstance?.biobankIdentifier]">${message(code: 'default.add.label', args: [message(code: 'aliquot.label', default: 'Duplicate Aliquot')])}</g:link>
    </a></div>
</div>
<hr style="border:1; height:1px" />

<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="colocation" action="create" params="['aliquot.id': aliquotInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'colocation.label', default: 'Colocation')])}</g:link>
    </a></div>
</div>
<g:if test="${aliquotInstance?.position?.id == null}">
    <hr style="border:1; height:1px" />
    <div class="one-to-many">
        <div><a class='btn btn-primary btn-small' <g:link controller="position" action="create" params="['containedAliquot.id': aliquotInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'position.label', default: 'Plate or Box Storage Position')])}</g:link>
        </a></div>
    </div>
</g:if>
<g:if test="${aliquotInstance?.aliquotReport?.id == null}">
    <hr style="border:1; height:1px" />
    <div class="one-to-many">
        <div><a class='btn btn-primary btn-small' <g:link controller="aliquotReport" action="create" params="['aliquot.id': aliquotInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquotReport.label', default: 'Aliquot Report')])}</g:link>
        </a></div>
    </div>
</g:if>
<hr style="border:1; height:1px" />
<div class="one-to-many">
    <div><a class='btn btn-primary btn-small' <g:link controller="DNA_Extract" action="create" params="['aliquot': aliquotInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'DNA_Extract.label', default: 'DNA Extract')])}</g:link>
    </a></div>
</div>
<hr style="border:1; height:1px" />
</body>

</html>
