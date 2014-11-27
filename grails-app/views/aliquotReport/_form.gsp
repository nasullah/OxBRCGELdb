<%@ page import="geldb.StaffRole; geldb.AliquotReport" %>



            <div class="${hasErrors(bean: aliquotReportInstance, field: 'aliquot', 'error')} required">
                <label for="aliquot" class="control-label"><g:message code="aliquotReport.aliquot.label" default="Aliquot" /><span class="required-indicator">*</span></label>
                <div>
                    <g:select class="form-control" id="aliquot" name="aliquot.id" from="${geldb.Aliquot.list()}" optionKey="id" required="" value="${aliquotReportInstance?.aliquot?.id}" class="many-to-one"/>
                    <span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'aliquot', 'error')}</span>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotReportInstance, field: 'reportDate', 'error')} required">
                        <label for="reportDate" class="control-label"><g:message code="aliquotReport.reportDate.label" default="Report Date" /><span class="required-indicator">*</span></label>
                        <div>
                            <bs:datePicker name="reportDate" precision="day"  value="${aliquotReportInstance?.reportDate}"  />
                            <span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'reportDate', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotReportInstance, field: 'reportStaff', 'error')} required">
                        <label for="reportStaff" class="control-label"><g:message code="aliquotReport.reportStaff.label" default="Report Staff" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="reportStaff" name="reportStaff.id" from="${geldb.StaffMember.findAllByStaffRoleOrStaffRole(StaffRole.findByRole('Pathologist'),StaffRole.findByRole('Surgeon'))}"
                                      optionKey="id" required="" value="${aliquotReportInstance?.reportStaff?.id}" />
                            <span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'reportStaff', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotReportInstance, field: 'comments', 'error')} ">
                        <label for="comments" class="control-label"><g:message code="aliquotReport.comments.label" default="Comments" /></label>
                        <div>
                            <g:textArea class="form-control" name="comments" cols="40" rows="5" value="${aliquotReportInstance?.comments}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'comments', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotReportInstance, field: 'percentageOfTumourInSample', 'error')} ">
                        <label for="percentageOfTumourInSample" class="control-label"><g:message code="aliquotReport.percentageOfTumourInSample.label" default="Percentage Of Tumour In Sample" /></label>
                        <div>
                            <g:field class="form-control" name="percentageOfTumourInSample" type="number" value="${aliquotReportInstance.percentageOfTumourInSample}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'percentageOfTumourInSample', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotReportInstance, field: 'cellularity', 'error')} ">
                        <label for="cellularity" class="control-label"><g:message code="aliquotReport.cellularity.label" default="Cellularity" /></label>
                        <div>
                            <g:select class="form-control" name="cellularity" from="${geldb.Cellularity?.values()}" keys="${geldb.Cellularity.values()*.name()}" value="${aliquotReportInstance?.cellularity?.name()}" noSelection="['': '']"/>
                            <span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'cellularity', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			<div class="${hasErrors(bean: aliquotReportInstance, field: 'dysplasticNonInvasiveElements', 'error')} ">
				<label for="dysplasticNonInvasiveElements" class="control-label"><g:message code="aliquotReport.dysplasticNonInvasiveElements.label" default="Dysplastic Non Invasive Elements" /></label>
				<div>
					<bs:checkBox name="dysplasticNonInvasiveElements" value="${aliquotReportInstance?.dysplasticNonInvasiveElements}" />
					<span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'dysplasticNonInvasiveElements', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotReportInstance, field: 'sysplasticNonInvasiveNotes', 'error')} ">
                        <label for="sysplasticNonInvasiveNotes" class="control-label"><g:message code="aliquotReport.sysplasticNonInvasiveNotes.label" default="Sysplastic Non Invasive Notes" /></label>
                        <div>
                            <g:textField class="form-control" name="sysplasticNonInvasiveNotes" value="${aliquotReportInstance?.sysplasticNonInvasiveNotes}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'sysplasticNonInvasiveNotes', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotReportInstance, field: 'tumourContentVerifiedBy', 'error')} ">
                        <label for="tumourContentVerifiedBy" class="control-label"><g:message code="aliquotReport.tumourContentVerifiedBy.label" default="Tumour Content Verified By" /></label>
                        <div>
                            <g:select class="form-control" name="tumourContentVerifiedBy" from="${geldb.TumourContentVerification?.values()}" keys="${geldb.TumourContentVerification.values()*.name()}" value="${aliquotReportInstance?.tumourContentVerifiedBy?.name()}" noSelection="['': '']"/>
                            <span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'tumourContentVerifiedBy', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotReportInstance, field: 'tumourContentVerificationOther', 'error')} ">
                        <label for="tumourContentVerificationOther" class="control-label"><g:message code="aliquotReport.tumourContentVerificationOther.label" default="Tumour Content Verification Other" /></label>
                        <div>
                            <g:textField class="form-control" name="tumourContentVerificationOther" value="${aliquotReportInstance?.tumourContentVerificationOther}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'tumourContentVerificationOther', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotReportInstance, field: 'percentageNecrosis', 'error')} ">
                        <label for="percentageNecrosis" class="control-label"><g:message code="aliquotReport.percentageNecrosis.label" default="Percentage Necrosis" /></label>
                        <div>
                            <g:field class="form-control" name="percentageNecrosis" type="number" value="${aliquotReportInstance.percentageNecrosis}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'percentageNecrosis', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			<div class="${hasErrors(bean: aliquotReportInstance, field: 'microMacroDissectionUsedToEnrichSample', 'error')} ">
				<label for="microMacroDissectionUsedToEnrichSample" class="control-label"><g:message code="aliquotReport.microMacroDissectionUsedToEnrichSample.label" default="Micro Macro Dissection Used To Enrich Sample" /></label>
				<div>
					<bs:checkBox name="microMacroDissectionUsedToEnrichSample" value="${aliquotReportInstance?.microMacroDissectionUsedToEnrichSample}" />
					<span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'microMacroDissectionUsedToEnrichSample', 'error')}</span>
				</div>
			</div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotReportInstance, field: 'detailsOfMacroMicrodissection', 'error')} ">
                        <label for="detailsOfMacroMicrodissection" class="control-label"><g:message code="aliquotReport.detailsOfMacroMicrodissection.label" default="Details of Macro Micro Dissection" /></label>
                        <div>
                            <g:textArea class="form-control" name="detailsOfMacroMicrodissection" cols="40" rows="5"  value="${aliquotReportInstance?.detailsOfMacroMicrodissection}"/>
                            <span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'detailsOfMacroMicrodissection', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotReportInstance, field: 'suitableForExtraction', 'error')} required">
                        <label for="suitableForExtraction" class="control-label"><g:message code="aliquotReport.suitableForExtraction.label" default="Suitable For Extraction" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="suitableForExtraction" name="suitableForExtraction.id" from="${geldb.DNAExtractionStatus.list()}" optionKey="id" required="" value="${aliquotReportInstance?.suitableForExtraction?.id}" />
                            <span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'suitableForExtraction', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>

			%{--<div class="${hasErrors(bean: aliquotReportInstance, field: 'aliquotPhoto', 'error')} ">--}%
				%{--<label for="aliquotPhoto" class="control-label"><g:message code="aliquotReport.aliquotPhoto.label" default="Aliquot Photo" /></label>--}%
				%{--<div>--}%
					%{----}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${aliquotReportInstance?.aliquotPhoto?}" var="a">--}%
    %{--<li><g:link controller="aliquotPhoto" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="aliquotPhoto" action="create" params="['aliquotReport.id': aliquotReportInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'aliquotPhoto.label', default: 'AliquotPhoto')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%

					%{--<span class="help-inline">${hasErrors(bean: aliquotReportInstance, field: 'aliquotPhoto', 'error')}</span>--}%
				%{--</div>--}%
			%{--</div>--}%

