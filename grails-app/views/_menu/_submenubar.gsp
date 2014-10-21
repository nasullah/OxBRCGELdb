<!-- 
This menu is used to show function that can be triggered on the content (an object or list of objects).
-->

<%-- Only show the "Pills" navigation menu if a controller exists (but not for home) --%>
<g:if test="${	params.controller != null
			&&	params.controller != ''
			&&	params.controller != 'home'
            &&	params.controller != 'participant'
}">

    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
	<ul id="Menu" class="nav nav-pills margin-top-small">

		<g:set var="entityName" value="${message(code: params.controller+'.label', default: params.controller.substring(0,1).toUpperCase() + params.controller.substring(1).toLowerCase())}" />
		
		<li class="${ params.action == "list" ? 'active' : '' }">
			<g:link action="list"><i class="glyphicon glyphicon-th-list"></i> <g:message code="default.list.label" args="[entityName]"/></g:link>
		</li>

        <g:if test="${ params.controller == 'sequencingRun'
                        || params.controller == 'aliquotType'
                        || params.controller == 'AnatomicalSite'
                        || params.controller == 'location'
                        || params.controller == 'CollectionMethod'
                        || params.controller == 'DNAExtractionStatus'
                        || params.controller == 'period'
                        || params.controller == 'freezer'
                        || params.controller == 'ICD10'
                        || params.controller == 'methodOfTransport'
                        || params.controller == 'SampleTrackingEventType'
                        || params.controller == 'shelf'
                        || params.controller == 'staffMember'
                        || params.controller == 'staffRole'
                        || params.controller == 'StagingSystem'
                        || params.controller == 'study'
                        || params.controller == 'TumourLocation'
                        || params.controller == 'TumourType'
                        || params.controller == 'units'
                        || params.controller == 'plateOrBox'
                        || params.controller == 'sampleTrackingEvent'}">
            <li class="${ params.action == "create" ? 'active' : '' }">
                <g:link action="create"><i class="glyphicon glyphicon-plus"></i> <g:message code="default.new.label"  args="[entityName]"/></g:link>
            </li>
        </g:if>
		
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
            <li><a href="/GELdb/importparticipant"><span style="color:#46d010"><i class="glyphicon glyphicon-import"></i></span> Import Participant</a></li>
        </li>

        <li class=${ params.action == "listBloodFollowUp" ? 'active' : '' }>
            <g:link action="listBloodFollowUp"><span style="color:red"><i class="glyphicon glyphicon-warning-sign"></i></span> Follow up Blood</g:link>
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
