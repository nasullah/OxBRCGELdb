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
    <div style="background: rgba(255, 78, 65, 0.75);">
        <div class="container">
            <p>
            <h5 class="text-center">Remove Participant from NGS-LIMS</h5>
            <p>
            <div class="row">
                <div class="col-lg-6">
                    <g:form controller="participant" action="test">
                        <label class="control-label"><small>Enter Participant's NHS Number (without spaces)</small></label>
                        <richui:autoComplete class="form-control" name="personName" action="${createLinkTo('dir': 'participant/searchParticipant')}" onItemSelect="callPerson(id)"  />
                        <g:hiddenField id ="personId" name ="personId" value=""/>
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