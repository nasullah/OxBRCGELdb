%{--<%@ page import="geldb.AcquisitionReport" %>--}%



            %{--<div class="${hasErrors(bean: acquisitionReportInstance, field: 'specimen', 'error')} required">--}%
                %{--<label for="specimen" class="control-label"><g:message code="acquisitionReport.specimen.label" default="Specimen" /><span class="required-indicator">*</span></label>--}%
                %{--<div>--}%
                    %{--<g:select class="form-control" id="specimen" name="specimen.id" from="${geldb.Specimen.list()}" optionKey="id" required="" value="${acquisitionReportInstance?.specimen?.id}" class="many-to-one"/>--}%
                    %{--<span class="help-inline">${hasErrors(bean: acquisitionReportInstance, field: 'specimen', 'error')}</span>--}%
                %{--</div>--}%
            %{--</div>--}%

            %{--<div class="row">--}%
                %{--<div class="col-lg-6">--}%
                    %{--<div class="${hasErrors(bean: acquisitionReportInstance, field: 'reportDate', 'error')} required">--}%
                        %{--<label for="reportDate" class="control-label"><g:message code="acquisitionReport.reportDate.label" default="Report Date" /><span class="required-indicator">*</span></label>--}%
                        %{--<div>--}%
                            %{--<bs:datePicker name="reportDate" precision="day"  value="${acquisitionReportInstance?.reportDate}"  />--}%
                            %{--<span class="help-inline">${hasErrors(bean: acquisitionReportInstance, field: 'reportDate', 'error')}</span>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%

                %{--<div class="col-lg-6">--}%
                    %{--<div class="${hasErrors(bean: acquisitionReportInstance, field: 'reportStaff', 'error')} required">--}%
                        %{--<label for="reportStaff" class="control-label"><g:message code="acquisitionReport.reportStaff.label" default="Report Staff" /><span class="required-indicator">*</span></label>--}%
                        %{--<div>--}%
                            %{--<g:select class="form-control" id="reportStaff" name="reportStaff.id" from="${geldb.StaffMember.list()}" optionKey="id" required="" value="${acquisitionReportInstance?.reportStaff?.id}"/>--}%
                            %{--<span class="help-inline">${hasErrors(bean: acquisitionReportInstance, field: 'reportStaff', 'error')}</span>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%

                %{--<div class="col-lg-6">--}%
                    %{--<div class="${hasErrors(bean: acquisitionReportInstance, field: 'comments', 'error')} ">--}%
                        %{--<label for="comments" class="control-label"><g:message code="acquisitionReport.comments.label" default="Comments" /></label>--}%
                        %{--<div>--}%
                            %{--<g:textArea class="form-control" name="comments" cols="40" rows="5" value="${acquisitionReportInstance?.comments}"/>--}%
                            %{--<span class="help-inline">${hasErrors(bean: acquisitionReportInstance, field: 'comments', 'error')}</span>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%
            %{--</div>--}%



