
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'test.label', default: 'Test')}" />
    <title>Import Participant from Consent Management System</title>
</head>

<body>
<p>
<p>
<div style="background: rgba(139, 240, 37, 0.14);">
    <div class="container">
        <p>
        <h5 class="text-center">Import Participant</h5>
        <p>
        <div class="row">
            <div class="col-lg-6">
                <g:form controller="participant" action="getJson">
                    <label class="control-label"><small>Enter Participant's NHS Number (without spaces)</small></label>
                    <div class="input-group">
                    <g:textField type="text" name="nhsOrHospitalNumberId" class="form-control"  placeholder="1234567890" ></g:textField>
                    <div class="input-group-btn">
                        <button type="submit" class="btn btn-success" ><span class="glyphicon glyphicon-import"></span> Import</button>
                    </div>
                </g:form>
                </div>
            </div>
        </div>
        <p>
        <p>
    </div>
</div>
<hr style="border:1; height:1px" />
</body>

</html>

