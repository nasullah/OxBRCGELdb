<sec:ifAnyGranted roles="ROLE_ADMIN">

    <!DOCTYPE html>
    <html>

    <head>
        <meta name="layout" content="kickstart" />
        <title>Remove Participant & Associated Samples</title>
        <resource:autoComplete/>
    </head>

    <body>

    <p>
    <p>
    <div>
        <div class="container">
            <p>
            <h5 class="text-center">Remove Participant from NGS-LIMS</h5>
            <p>
            <div class="row">
                <div class="col-lg-6">
                    <g:form controller="participant" action="deleteParticipantAndSamples">
                        <label class="control-label"><small>Enter Participant's NHS Number (without spaces)</small></label>
                        <div class="input-group">
                            <g:textField type="text" name="nhsNumber" class="form-control"  placeholder="1234567890" ></g:textField>
                            <div class="input-group-btn">
                                <button type="submit" class="btn btn-danger" ><span class="glyphicon glyphicon-trash"></span> Remove</button>
                            </div>
                        </div>
                    </g:form>
                </div>
            </div>
            <p>
            <p>
        </div>
    </div>

    <hr/>
    <g:javascript plugin="jquery" library="jquery" />
    <script>
        function callPerson(personId){
            document.getElementById('personId').value = personId;
        }
    </script>
    </body>
    </html>

</sec:ifAnyGranted>