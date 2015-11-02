
<%@ page import="geldb.DNA_Extract" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Import Logs</title>
</head>

<body>

<hr/>

<div style="background: rgba(139, 240, 37, 0.14);">
    <div>
        <a class="text-success">Passed:</a>
    </div>
    <div class="container">
        <g:each in="${passedList}" status="i" var="passedItem">
            <p>${passedItem}</p>
        </g:each>
    </div>
</div>

<hr/>

<div style="background: rgba(255, 115, 115, 0.32);">
    <div>
        <a class="text-danger">Failed:</a>
    </div>
    <div class="container">
        <g:each in="${failedList}" status="i" var="failedItem">
            <p>${failedItem}</p>
        </g:each>
    </div>
</div>

<hr/>

<div style="background: rgba(255, 183, 35, 0.89);">
    <div>
        <a class="text-danger">Duplicated:</a>
    </div>
    <div class="container">
        <g:each in="${duplicatedList}" status="i" var="duplicatedItem">
            <p>${duplicatedItem}</p>
        </g:each>
    </div>
</div>

</body>

</html>