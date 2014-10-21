<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_USER">
    <ul class="nav nav-tabs">
        %{--<li class="active"><a href="#">Home</a></li>--}%
        <li>
            <g:link controller="Participant" action="index">Participant</g:link>
        </li>

        <li>
            <g:link controller="SolidSpecimen" action="index">Solid Specimen</g:link>
        </li>

        <li>
            <g:link controller="FluidSpecimen" action="index">Fluid Specimen</g:link>
        </li>

        <li>
            <g:link controller="SampleTrackingEvent" action="index">Sample Tracking</g:link>
        </li>

        <li>
            <g:link controller="Aliquot" action="index">Aliquot</g:link>
        </li>

        %{--<li>--}%
            %{--<g:link controller="Derivation" action="index">Derivation</g:link>--}%
        %{--</li>--}%

        <li>
            <g:link controller="PlateOrBox" action="index">Plate or Box</g:link>
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

        %{--<li><a href="http://localhost:8080/GELdb/SampleAcquisition/index">Sample Acquisition</a></li>--}%
        %{--<li><a href="http://localhost:8080/GELdb/SampleTrackingEvent/index">Sample Tracking Event</a></li>--}%
        %{--<li><a href="http://localhost:8080/GELdb/Aliquot/index">Aliquot</a></li>--}%
        %{--<li><a href="http://localhost:8080/GELdb/Plate/index">Plate</a></li>--}%
        %{--<li><a href="http://localhost:8080/GELdb/DNA_Extract/index">DNA Extract</a></li>--}%
        %{--<li><a href="http://localhost:8080/GELdb/DNA_Library/index">DNA Library</a></li>--}%
        %{--<li><a href="http://localhost:8080/GELdb/FlowCell/index">Flow Cell</a></li>--}%
        %{--<li><a href="http://localhost:8080/GELdb/SequencingRun/index">Sequencing Run</a></li>--}%
        %{--<li><a href="#">Participant</a></li>--}%
        %{--<li><a href="#">Participant</a></li>--}%
        %{--<li><a href="#">Participant</a></li>--}%

    </ul>
</sec:ifAnyGranted>