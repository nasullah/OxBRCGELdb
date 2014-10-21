<sec:ifAnyGranted roles="ROLE_ADMIN">

    <li class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color: white">
            <i class="glyphicon glyphicon-cog white"></i>
            Administration
        </a>

        <ul class="dropdown-menu" style="height: auto; max-height: 350px; overflow-x: hidden;">
            <li class="">
                <a tabindex="-1" href="#">
                    <b>User Access Management</b></a>
            </li>

            <p>

            <li class="">
                <a href="${createLink(uri: '/role/create')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Role
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/role')}">
                    <i class="glyphicon glyphicon-search"></i>
                    Search Role
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/user/create')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add User
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/user')}">
                    <i class="glyphicon glyphicon-search"></i>
                    Search User
                </a>
            </li>

            <hr />

            <li class="">
                <a tabindex="-1" href="#">
                    <b>Dropdown Lists Management</b></a>
            </li>

            <p>
            <li class="">
                <a href="${createLink(uri: '/aliquotType')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Aliquot Type
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/AnatomicalSite')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Anatomical Site
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/location')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Collection Location
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/CollectionMethod')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Collection Method
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/DNAExtractionStatus')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add DNA Extraction Status
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/period')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Fixation Period
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/freezer')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Freezer
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/ICD10')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add ICD10 code
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/methodOfTransport')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Method of Transport
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/SampleTrackingEventType')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Sample Tracking Event Type
                </a>
            </li>

            %{--<li class="">--}%
                %{--<a href="${createLink(uri: '/sampleType')}">--}%
                    %{--<i class="glyphicon glyphicon-plus-sign"></i>--}%
                    %{--Add Sample Type--}%
                %{--</a>--}%
            %{--</li>--}%

            <li class="">
                <a href="${createLink(uri: '/shelf')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Shelf
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/staffMember')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Staff Member
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/staffRole')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Staff Role
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/StagingSystem')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Staging System
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/study')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Study
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/TumourLocation')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Tumour Location
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/TumourType')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Tumour Type
                </a>
            </li>

            <li class="">
                <a href="${createLink(uri: '/units')}">
                    <i class="glyphicon glyphicon-plus-sign"></i>
                    Add Units
                </a>
            </li>

        </ul>

    </li>

</sec:ifAnyGranted>
