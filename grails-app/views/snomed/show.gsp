
<%@ page import="geldb.Snomed" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'snomed.label', default: 'Snomed')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-snomed" class="first">

    <table class="table">
        <tbody>


        <tr class="prop">
            <td valign="top" class="name"><g:message code="snomed.fFPE_Tissue_Report.label" default="Main Specimen Report" /></td>

            <td valign="top" class="value"><g:link controller="FFPE_Tissue_Report" action="show" id="${snomedInstance?.fFPE_Tissue_Report?.id}">${snomedInstance?.fFPE_Tissue_Report?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="snomed.snomedCode.label" default="Snomed Code" /></td>

            <td valign="top" class="value">${fieldValue(bean: snomedInstance, field: "snomedCode")}</td>

        </tr>

        </tbody>
    </table>
</section>

</body>

</html>
