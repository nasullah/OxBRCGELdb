
<%@ page import="geldb.Aliquot; geldb.PrimaryContainerType; geldb.FluidSpecimen" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="kickstart" />
    <title>Main Project Fluid Specimen Summary</title>
</head>

<body>

<section id="index-fluidSpecimen" class="first">

    <table class="table table-bordered margin-top-medium">
        <thead>
        <tr>

            <th>Participant ID</th>

            <th>GL DNA Extract</th>

            <th>EDTA tube GL</th>

            <th>EDTA tube Plasma</th>

            <th>Streck tube Plasma</th>

            <th>PST tube Plasma</th>

            <th>PAXgene RNA</th>

            <th>SST tube Serum</th>


        </tr>
        </thead>
        <tbody>
        <g:each in="${summary}" status="i" var="participantInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <%def gelID = participantInstance?.studySubject?.studySubjectIdentifier?.findResult {it?.size() ? it : null}%>
                <td><g:link controller="participant" action="summaryReport" params="[gelStudyId : gelID]">${gelID}</g:link></td>

                <% def glDnaExtract = FluidSpecimen?.findAllByParticipantAndPrimaryContainer(participantInstance, PrimaryContainerType.EDTA_GL)
                   def size = Aliquot?.findAllBySpecimenInList(glDnaExtract)?.dNA_Extract?.findAll()?.size()
                %>
                <g:if test="${size == 0}">
                    <td><span class="text-danger">Pending</span></td>
                </g:if>
                <g:else>
                    <td>Processed</td>
                </g:else>

                <% def edtaGL = FluidSpecimen?.findAllByParticipantAndPrimaryContainer(participantInstance, PrimaryContainerType.EDTA_GL) %>
                <td>${Aliquot.findAllBySpecimenInList(edtaGL)?.size()}</td>

                <% def edtaCfDNA = FluidSpecimen?.findAllByParticipantAndPrimaryContainer(participantInstance, PrimaryContainerType.EDTA_cfDNA) %>
                <td>${Aliquot.findAllBySpecimenInList(edtaCfDNA)?.size()}</td>

                <% def strekCfDNA = FluidSpecimen?.findAllByParticipantAndPrimaryContainer(participantInstance, PrimaryContainerType.Strek_cfDNA) %>
                <td>${Aliquot.findAllBySpecimenInList(strekCfDNA)?.size()}</td>

                <% def pST = FluidSpecimen?.findAllByParticipantAndPrimaryContainer(participantInstance, PrimaryContainerType.PST) %>
                <td>${Aliquot.findAllBySpecimenInList(pST)?.size()}</td>

                <% def pAXgene = FluidSpecimen?.findAllByParticipantAndPrimaryContainer(participantInstance, PrimaryContainerType.PAXgene) %>
                <td>${Aliquot.findAllBySpecimenInList(pAXgene)?.size()}</td>

                <% def sST = FluidSpecimen?.findAllByParticipantAndPrimaryContainer(participantInstance, PrimaryContainerType.SST) %>
                <td>${Aliquot.findAllBySpecimenInList(sST)?.size()}</td>

            </tr>
        </g:each>
        </tbody>
    </table>
    <div>
    </div>
</section>


</body>

</html>
