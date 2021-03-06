<%@ page import="geldb.Aliquot" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'aliquot.label', default: 'Aliquot')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>

<body>

<section id="create-aliquot" class="first">

    <g:hasErrors bean="${aliquotInstance}">
        <div class="alert alert-danger">
            <g:renderErrors bean="${aliquotInstance}" as="list" />
        </div>
    </g:hasErrors>

    <g:form action="save" method="post" class="form-horizontal" role="form">
        <g:render template="form"/>

        <div class="form-actions margin-top-medium">
            <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'save', default: 'Save')}" />
            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
        </div>
    </g:form>

</section>
<hr style="border:1; height:1px" />
</body>

</html>
