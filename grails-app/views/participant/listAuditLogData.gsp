
<%@ page import="GELBootsDB.User; geldb.Participant" %>

<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'participant.label', default: 'Participant')}" />
    <title>User Activity Log</title>
    <r:require module="export"/>

</head>

<body>

<hr style="border:1; height:1px" />

<div style="background: rgba(139, 240, 37, 0.14);">
    <div class="container">
        <p>
        <h5 class="text-center">Export User Activity Log Data</h5>
        <p>
        <div class="row">
            <div class="col-lg-4">
                <div class="fieldcontain">
                    <label style="color: #ec2707" for="delete"><small>Delete After Export ?</small></label>
                    <input type="checkbox" id="delete" />
                </div>
                <a class='btn btn-success btn-xs' id="withDelete" onclick="getExcelWithDelete()"  <g:link controller="participant" action="listAuditLogData" params="['format': 'excel', 'extension': 'xls', 'delete': 'true']"><i class="glyphicon glyphicon-export"></i> Excel Format</g:link>
                <div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Processing&hellip;"/>
                    <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="spinner" />
                </div>
                <a class='btn btn-success btn-xs' id="withoutDelete" onclick="getExcelWithoutDelete()" <g:link controller="participant" action="listAuditLogData" params="['format': 'excel', 'extension': 'xls']"><i class="glyphicon glyphicon-export"></i> Excel Format </g:link>
                <div id="spinnerWithoutDelete" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Processing&hellip;"/>
                    <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="spinner" />
                </div>
            </div>
        </div>
        <p>
        <p>
    </div>
</div>

<hr style="border:1; height:1px" />

<div class="row">
    <div class="col-lg-6">
        <g:form controller="participant" action="listAuditLogData">
            <div class="input-group">
                <g:select class="form-control" id="user" name="user.id" from="${GELBootsDB.User.list().sort{it.username}}" optionKey="id" required=""  value="" noSelection="['':'- Choose User -']" />
                <div class="input-group-btn">
                    <button type="submit" class="btn btn-success" ><span class="glyphicon glyphicon-search"></span> Find User Activity Log</button>
                </div>
            </div>
        </g:form>
    </div>
</div>

<hr style="border:1; height:1px" />

<section id="list-participant" class="first">

    <table class="table table-bordered margin-top-medium">
        <thead>
        <tr>
            <g:sortableColumn property="actor" title="Username" />

            <g:sortableColumn property="eventName" title="Event Name" />

            <g:sortableColumn property="dateCreated" title="Date & Time" />

            <g:sortableColumn property="className" title="Table" />

            <g:sortableColumn property="persistedObjectId" title="Record ID" />

            <g:sortableColumn property="oldValue" title="Old Value" />

            <g:sortableColumn property="newValue" title="New Value" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${listAuditLogData}" status="i" var="auditLogInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td>${fieldValue(bean: auditLogInstance, field: "actor")}</td>

                <td>${fieldValue(bean: auditLogInstance, field: "eventName")}</td>

                <td><g:formatDate date="${auditLogInstance.dateCreated}" /></td>

                <td>${fieldValue(bean: auditLogInstance, field: "className")}</td>

                <td>${fieldValue(bean: auditLogInstance, field: "persistedObjectId")}</td>

                <td>${fieldValue(bean: auditLogInstance, field: "oldValue")}</td>

                <td>${fieldValue(bean: auditLogInstance, field: "newValue")}</td>

            </tr>
        </g:each>
        </tbody>
    </table>

</section>
<g:javascript plugin="jquery" library="jquery" />
<script>
    $('#withDelete').hide();
    $('#delete').on('change', function() {
        if (this.checked) {
            $('#withDelete').show();
            $('#withoutDelete').hide();
        } else{
            $('#withDelete').hide();
            $('#withoutDelete').show();
        }
    });

    function showSpinner() {
        $('#spinner').show();
    }
    function hideSpinner() {
        $('#spinner').hide();
    }
    function hideSpinnerWithoutDelete() {
        $('#spinnerWithoutDelete').hide();
    }
    function getExcelWithDelete(){
        showSpinner();
        ${remoteFunction (controller: 'participant',
                        action: 'listAuditLogData',
                        params:[format:'excel',extension:'xls', delete: 'true'],
                        onSuccess:'hideSpinner()'
                )}
    }
    function getExcelWithoutDelete(){
        $('#spinnerWithoutDelete').show();
        ${remoteFunction (controller: 'participant',
                        action: 'listAuditLogData',
                        params:[format:'excel',extension:'xls'],
                        onSuccess:'hideSpinnerWithoutDelete()'
                )}
    }

</script>
</body>

</html>
