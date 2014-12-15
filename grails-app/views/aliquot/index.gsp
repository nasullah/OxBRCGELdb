
<%@ page import="geldb.Aliquot" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'aliquot.label', default: 'Aliquot')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-aliquot" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
                <g:sortableColumn property="aliquotType" title="${message(code: 'aliquot.aliquotType.label', default: 'Aliquot Type')}" />

                <g:sortableColumn property="blockNumber" title="${message(code: 'aliquot.blockNumber.label', default: 'Block Number')}" />

                <g:sortableColumn property="sapphireIdentifier" title="${message(code: 'aliquot.sapphireIdentifier.label', default: 'Sapphire Identifier')}" />

                <g:sortableColumn property="aliquot.specimen.participant.studySubject.studySubjectIdentifier" title="${message(code: 'aliquot.specimen.participant.studySubject.studySubjectIdentifier.label', default: "Participant's GeL Id")}" />

            </tr>
		</thead>
		<tbody>
		<g:each in="${aliquotInstanceList}" status="i" var="aliquotInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${aliquotInstance.id}">${fieldValue(bean: aliquotInstance, field: "aliquotType")}</g:link></td>

                <td>${fieldValue(bean: aliquotInstance, field: "blockNumber")}</td>

                <td>${fieldValue(bean: aliquotInstance, field: "sapphireIdentifier")}</td>

                <td>${fieldValue(bean: aliquotInstance.specimen.participant.studySubject, field: "studySubjectIdentifier").toString().replace('[', '').replace(']','')}</td>

            </tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${aliquotInstanceCount}" />
	</div>
</section>

</body>

</html>
