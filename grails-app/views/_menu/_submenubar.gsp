<!-- 
This menu is used to show function that can be triggered on the content (an object or list of objects).
-->

<%-- Only show the "Pills" navigation menu if a controller exists (but not for home) --%>
<g:if test="${	params.controller != null
			&&	params.controller != ''
			&&	params.controller != 'home'
            &&	params.controller != 'participant'
            &&	params.controller != 'sampleTrackingEvent'
}">

    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
	<ul id="Menu" class="nav nav-pills margin-top-small">

		<g:set var="entityName" value="${message(code: params.controller+'.label', default: params.controller.substring(0,1).toUpperCase() + params.controller.substring(1).toLowerCase())}" />

        <g:if test="${ params.controller != 'solidSpecimen' && params.controller != 'FFPE_Tissue_Report' && params.controller != 'gelSuitabilityReport'}">
            <li class="${ params.action == "list" ? 'active' : '' }">
                <g:link action="list"><i class="glyphicon glyphicon-th-list"></i> <g:message code="default.list.label" args="[entityName]"/></g:link>
            </li>
            <g:if test="${ params.controller == 'aliquot'}">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-warning-sign" style="color: red"></i> Worklists <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <g:link action="awaitingFFaliquots">Awaiting FF Aliquots</g:link>
                        </li>
                        <li>
                            <g:link action="awaitingFFPEaliquots">Awaiting FFPE Aliquots</g:link>
                        </li>
                    </ul>
                </li>
                <li class=${ params.action == "createMultiple" ? 'active' : '' }>
                    <g:link action="createMultiple"><span style="color:#28fff8"><i class="glyphicon glyphicon-th-large"></i></span> Create Multiple Aliquots</g:link>
                </li>
            </g:if>
            <g:if test="${ params.controller == 'fluidSpecimen'}">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-warning-sign" style="color: red"></i> Worklists <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <g:link action="awaitingBlood">Awaiting Blood</g:link>
                        </li>
                        <li>
                            <g:link action="listBloodFollowUp">Follow up Blood</g:link>
                        </li>
                    </ul>
                </li>
                <li class=${ params.action == "createMultiple" ? 'active' : '' }>
                    <g:link action="createMultiple"><span style="color:#28fff8"><i class="glyphicon glyphicon-th-large"></i></span> Create Multiple Fluid Specimen</g:link>
                </li>
            </g:if>
            <g:if test="${ params.controller == 'DNA_Extract'}">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-warning-sign" style="color: red"></i> Worklists <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <g:link action="aliquotsPendingForExtraction">Pending to be extracted</g:link>
                        </li>
                        <li>
                            <g:link action="readyToDispatch">Ready to dispatch list</g:link>
                        </li>
                        <li>
                            <g:link action="reservedDNASampleList">Reserved DNA list</g:link>
                        </li>
                        <li>
                            <g:link action="failedDNASampleList">Failed DNA list</g:link>
                        </li>
                    </ul>
                </li>
                <li class=${ params.action == "addBarcode" ? 'active' : '' }>
                    <g:link action="addBarcode"><span style="color:rgba(6, 6, 12, 0.97)"><i class="glyphicon glyphicon-barcode"></i></span> Add Barcode</g:link>
                </li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-stats" style="color: red"></i> Control Charts <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <g:link action="ffControlChart">FF Control Chart</g:link>
                        </li>
                        <li>
                            <g:link action="controlChart">FFPE Control Charts</g:link>
                        </li>
                    </ul>
                </li>
            </g:if>
            <g:if test="${ params.action == 'show' || params.action == 'edit'}">
                <li class="${ params.action == "edit" ? 'active' : '' }">
                    <g:link action="edit" id="${params.id}"><i class="glyphicon glyphicon-pencil"></i> <g:message code="default.edit.label"  args="[entityName]"/></g:link>
                </li>
                <li class="">
                    <g:render template="/_common/modals/deleteTextLink"/>
                </li>
            </g:if>
        </g:if>

        <g:if test="${params.controller == 'location'
                        || params.controller == 'period'
                        || params.controller == 'freezer'
                        || params.controller == 'ICD10'
                        || params.controller == 'shelf'
                        || params.controller == 'study'
                        || params.controller == 'units'
                        || params.controller == 'centre'
                        || params.controller == 'aliquot'
                        || params.controller == 'destination'
                        || params.controller == 'previousTreatmentType'}">

        <li class="${ params.action == "create" ? 'active' : '' }">
            <g:link action="create"><i class="glyphicon glyphicon-plus"></i> <g:message code="default.new.label"  args="[entityName]"/></g:link>
        </li>
        </g:if>
        <g:if test="${ params.controller == 'sequencingRun'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Sequencing Run</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'aliquotType'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Aliquot Type</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'anatomicalSite'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Anatomical Site</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'collectionMethod'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Collection Method</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'DNAExtractionStatus'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New DNA Extraction Status</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'methodOfTransport'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Method of Transport</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'sampleTrackingEventType'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Sample Tracking Event Type</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'staffMember'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Staff Member</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'stagingSystem'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Staging System</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'tumourLocation'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Tumour Location</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'tumourType'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Tumour Type</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'plateOrBox'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Plate or Box</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'sampleTrackingEvent'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Sample Tracking Event</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'fluidSpecimen'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Fluid Specimen</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'DNA_Extract'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New DNA/RNA Extract</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'DNA_Library'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New DNA Library</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'dispatchRecord'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Dispatch Record</g:link>
            </li>
        </g:if>
        <g:if test="${ params.controller == 'sampleType'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Sample Type</g:link>
            </li>
        </g:if>

        <g:if test="${ params.controller == 'DNAExtractionKit'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New DNA Extraction Kit</g:link>
            </li>
        </g:if>

        <g:if test="${ params.controller == 'ExtractionType'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Extraction Type</g:link>
            </li>
        </g:if>

        <g:if test="${ params.controller == 'tissueProcessor'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Tissue Processor</g:link>
            </li>
        </g:if>

    </ul>
</g:if>

<!--
This menu is used to show function that can be triggered on the content (an object or list of objects).
-->

<%-- Only show the "Pills" navigation menu if a controller exists (but not for home) --%>
<g:if test="${	params.controller != null
&&	params.controller == 'participant'

}">

    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
    <ul id="Menu" class="nav nav-pills margin-top-small">

        <g:set var="entityName" value="${message(code: params.controller+'.label', default: params.controller.substring(0,1).toUpperCase() + params.controller.substring(1).toLowerCase())}" />

        <li class="${ params.action == "list" ? 'active' : '' }">
            <g:link action="list"><i class="glyphicon glyphicon-th-list"></i> <g:message code="default.list.label" args="[entityName]"/></g:link>
        </li>

        <li class="${ params.action == "create" ? 'active' : '' }">
            <g:link action="create"><i class="glyphicon glyphicon-plus"></i> <g:message code="default.new.label"  args="[entityName]"/></g:link>
        </li>

        <li class="">
            <a href="/GELdb/importparticipant"><span style="color:#46d010"><i class="glyphicon glyphicon-import"></i></span> Import Participant</a>
        </li>

        <li class="">
            <a href="/GELdb/scanbarcode"><span style="color:#060e02"><i class="glyphicon glyphicon-barcode"></i></span> Scan Barcode</a>
        </li>

        <g:if test="${ params.action == 'show' || params.action == 'edit' }">
            <!-- the item is an object (not a list) -->
            <li class="${ params.action == "edit" ? 'active' : '' }">
                <g:link action="edit" id="${params.id}"><i class="glyphicon glyphicon-pencil"></i> <g:message code="default.edit.label"  args="[entityName]"/></g:link>
            </li>
            <li class="">
                <g:render template="/_common/modals/deleteTextLink"/>
            </li>
        </g:if>

    </ul>
</g:if>

<g:if test="${	params.controller != null
&&	params.controller == 'sampleTrackingEvent'}">

    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
    <ul id="Menu" class="nav nav-pills margin-top-small">

        <g:set var="entityName" value="${message(code: params.controller+'.label', default: params.controller.substring(0,1).toUpperCase() + params.controller.substring(1).toLowerCase())}" />

        %{--<li class="${ params.action == "list" ? 'active' : '' }">--}%
            %{--<g:link action="list"><i class="glyphicon glyphicon-th-list"></i> Sample Tracking Event List</g:link>--}%
        %{--</li>--}%

        %{--<li class="${ params.action == "create" ? 'active' : '' }">--}%
            %{--<g:link action="create"><i class="glyphicon glyphicon-plus"></i> Dispatch Sample</g:link>--}%
        %{--</li>--}%

        <li class=${ params.action == "awaitingToBeDispatchedToMDC" ? 'active' : '' }>
            <g:link action="awaitingToBeDispatchedToMDC"><span style="color:red"><i class="glyphicon glyphicon-list"></i></span> Awaiting to be dispatched to MDC</g:link>
        </li>

        <li class=${ params.action == "inTransitToMDC" ? 'active' : '' }>
            <g:link action="inTransitToMDC"><span style="color:red"><i class="glyphicon glyphicon-list"></i></span> Aliquots in transit to MDC</g:link>
        </li>

        %{--<li class="${ params.action == "createReceived" ? 'active' : '' }">--}%
            %{--<g:link action="createReceived"><i class="glyphicon glyphicon-plus"></i>  Receive Sample</g:link>--}%
        %{--</li>--}%
        <g:if test="${ params.action == 'show' || params.action == 'edit' }">
            <li class="${ params.action == "edit" ? 'active' : '' }">
                <g:link action="edit" id="${params.id}"><i class="glyphicon glyphicon-pencil"></i> Edit Sample Tracking Event</g:link>
            </li>
            <li class="">
                <g:render template="/_common/modals/deleteTextLink"/>
            </li>
        </g:if>
    </ul>
</g:if>

<g:if test="${ params.controller == 'solidSpecimen'}">
    <ul id="Menu" class="nav nav-pills margin-top-small">
        <li class="${ params.action == "list" ? 'active' : '' }">
            <g:link action="list"><i class="glyphicon glyphicon-th-list"></i> List Main Specimen</g:link>
        </li>
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-warning-sign" style="color: red"></i> Worklists <b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li>
                    <g:link action="awaitingMainSpecimen">Awaiting Main Specimen</g:link>
                </li>
                <li>
                    <g:link action="awaitingMainSpecimenReport">Awaiting Main Specimen Reports</g:link>
                </li>
            </ul>
        </li>
        <li class="${ params.action == "create" ? 'active' : '' }">
            <g:link action="create"><i class="glyphicon glyphicon-plus"></i> New Main Specimen</g:link>
        </li>
        <g:if test="${ params.controller == 'solidSpecimen' && params.action == 'show' || params.controller == 'solidSpecimen' && params.action == 'edit' }">
            <li class="${ params.action == "edit" ? 'active' : '' }">
                <g:link action="edit" id="${params.id}"><i class="glyphicon glyphicon-pencil"></i> Edit Main specimen</g:link>
            </li>
            <li class="">
                <g:render template="/_common/modals/deleteTextLink"/>
            </li>
        </g:if>
    </ul>
</g:if>

<g:if test="${ params.controller == 'FFPE_Tissue_Report'}">
    <ul id="Menu" class="nav nav-pills margin-top-small">
        <li class="${ params.action == "list" ? 'active' : '' }">
            <g:link action="list"><i class="glyphicon glyphicon-th-list"></i> List Main Specimen Report</g:link>
        </li>
        <g:if test="${ params.controller == 'FFPE_Tissue_Report' && params.action == 'show' || params.controller == 'FFPE_Tissue_Report' && params.action == 'edit' }">
            <li class="${ params.action == "edit" ? 'active' : '' }">
                <g:link action="edit" id="${params.id}"><i class="glyphicon glyphicon-pencil"></i> Edit Main specimen Report</g:link>
            </li>
            <li class="">
                <g:render template="/_common/modals/deleteTextLink"/>
            </li>
        </g:if>
    </ul>
</g:if>

<g:if test="${ params.controller == 'gelSuitabilityReport'}">
    <ul id="Menu" class="nav nav-pills margin-top-small">
        <li class="${ params.action == "list" ? 'active' : '' }">
            <g:link action="list"><i class="glyphicon glyphicon-th-list"></i> List GeL Suitability Report</g:link>
        </li>
        <g:if test="${ params.controller == 'gelSuitabilityReport' && params.action == 'show' || params.controller == 'gelSuitabilityReport' && params.action == 'edit' }">
            <li class="${ params.action == "edit" ? 'active' : '' }">
                <g:link action="edit" id="${params.id}"><i class="glyphicon glyphicon-pencil"></i> Edit GeL Suitability Report</g:link>
            </li>
            <li class="">
                <g:render template="/_common/modals/deleteTextLink"/>
            </li>
        </g:if>
    </ul>
</g:if>



