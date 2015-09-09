
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Scan 2D Barcode</title>
</head>

<body>
<p>
<p>
<div style="background: rgba(139, 240, 37, 0.14);">
    <div class="container">
        <p>
        <h5 class="text-center"></h5>
        <p>
        <div class="row">
            <div class="col-lg-6">
                <g:form controller="participant" action="scanBarcode">
                    <label class="control-label"><small>Scan 2D Barcode</small></label>
                    <g:textField type="text" name="barcode" class="form-control"></g:textField>
                </g:form>
            </div>
        </div>
        <p>
        <p>
    </div>
</div>
<hr style="border:1; height:1px" />
</body>

</html>