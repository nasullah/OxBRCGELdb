<%@ page import="geldb.DispatchedBox" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Upload Result</title>
</head>

<body>

<hr/>

<div>
    <a class='btn btn-primary btn-sm' <g:link controller="dispatchedBox" action="show" params="['id': dispatchedBox]"><i class="glyphicon glyphicon-arrow-right"></i> Go to Box</g:link>
</div>

<hr>

<h3>Failed to upload</h3>

<g:if test="${!failedList?.empty}">
    <div style="color: red">
        <g:each in="${failedList}">
            <p>${it}</p>
        </g:each>
    </div>
</g:if>
<g:else>
    <p>No item failed to upload</p>
</g:else>

<hr/>

<h3>Uploaded</h3>

<g:if test="${!passedList?.empty}">
    <div style="color: green">
        <g:each in="${passedList}">
            <p>${it}</p>
        </g:each>
    </div>
</g:if>
<g:else>
    <p>No item uploaded</p>
</g:else>

</body>

</html>