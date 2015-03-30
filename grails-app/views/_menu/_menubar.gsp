<sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_USER, ROLE_CAN_SEE_DEMOGRAPHICS">
    <ul class="nav nav-tabs">

        <sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_CAN_SEE_DEMOGRAPHICS">
            <li>
                <g:link controller="Participant" action="index">Participant</g:link>
            </li>
        </sec:ifAnyGranted>

        <li>
            <g:link controller="FluidSpecimen" action="index">Fluid Specimen</g:link>
        </li>

        <li>
            <g:link controller="SolidSpecimen" action="index">Main Specimen</g:link>
        </li>

        <li>
            <g:link controller="Aliquot" action="index">Aliquot</g:link>
        </li>

        <li>
            <g:link controller="DNA_Extract" action="index">DNA Extract</g:link>
        </li>

        <li>
            <g:link controller="DNA_Library" action="index">DNA Library</g:link>
        </li>

        <li>
            <g:link controller="SequencingRun" action="index">Sequencing Run</g:link>
        </li>

        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                More  <b class="caret"></b>
            </a>
            <ul class="dropdown-menu">

                <li>
                    <g:link controller="dispatchRecord" action="index">Sample Dispatch</g:link>
                </li>

                <li>
                    <g:link controller="plateOrBox" action="index">Plate/Box</g:link>
                </li>

                <li>
                    <g:link controller="SampleTrackingEvent" action="index">Sample Tracking</g:link>
                </li>

                <li>
                    <g:link controller="participant" action="summaryReport">Summary Report</g:link>
                </li>

                <li>
                    <g:link controller="position" action="index">Position</g:link>
                </li>

            </ul>
        </li>

    </ul>
</sec:ifAnyGranted>