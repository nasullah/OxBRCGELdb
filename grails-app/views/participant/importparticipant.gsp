
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
        <div class="input-group">
            <input type="text" class="form-control" placeholder="Participant's NHS Number">
            <div class="input-group-btn">
                <button type="button" class="btn btn-success" ><span class="glyphicon glyphicon-import"></span> Import</button>

            </div><!-- /btn-group -->
        </div><!-- /input-group -->
    </div><!-- /.col-lg-6 -->
</div><!-- /.row -->


</body>

</html>