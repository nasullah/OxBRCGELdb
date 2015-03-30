
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'test.label', default: 'Test')}" />
    <title>Import Participant from Consent Management System</title>
</head>

<body>

    <hr style="border:1; height:1px" />

    <div class="row">
        <div class="col-lg-6">
            <g:form controller="participant" action="getJson">
            <div class="input-group">
                <g:textField type="text" name="nhsOrHospitalNumberId" class="form-control"  placeholder="Participant's NHS Number without spaces" ></g:textField>
                <div class="input-group-btn">
                    <button type="submit" class="btn btn-success" ><span class="glyphicon glyphicon-import"></span> Import</button>
                </div>
            </g:form>
            </div>
        </div>
    </div>

</body>

</html>

