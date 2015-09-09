<%@ page import="geldb.PathologyImage" %>



            <g:if test="${pathologyImageInstance?.solidSpecimenReport?.id !=null}">
                <div class="${hasErrors(bean: pathologyImageInstance, field: 'solidSpecimenReport', 'error')} required">
                    <label for="solidSpecimenReport" class="control-label"><g:message code="pathologyImage.solidSpecimenReport.label" default="Solid Specimen Report" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" id="solidSpecimenReport" name="solidSpecimenReport.id" from="${geldb.SolidSpecimenReport.list()}" optionKey="id" required="" value="${pathologyImageInstance?.solidSpecimenReport?.id}" class="many-to-one"/>
                        <span class="help-inline">${hasErrors(bean: pathologyImageInstance, field: 'solidSpecimenReport', 'error')}</span>
                    </div>
                </div>
            </g:if>

            <g:if test="${pathologyImageInstance?.gelSuitabilityReport?.id !=null}">
                <div class="${hasErrors(bean: pathologyImageInstance, field: 'gelSuitabilityReport', 'error')} required">
                    <label for="gelSuitabilityReport" class="control-label"><g:message code="pathologyImage.gelSuitabilityReport.label" default="Gel Suitability Report" /><span class="required-indicator">*</span></label>
                    <div>
                        <g:select class="form-control" id="gelSuitabilityReport" name="gelSuitabilityReport.id" from="${geldb.GelSuitabilityReport.list()}" optionKey="id" required="" value="${pathologyImageInstance?.gelSuitabilityReport?.id}" class="many-to-one"/>
                        <span class="help-inline">${hasErrors(bean: pathologyImageInstance, field: 'gelSuitabilityReport', 'error')}</span>
                    </div>
                </div>
            </g:if>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: pathologyImageInstance, field: 'takenDate', 'error')} required">
                        <label for="takenDate" class="control-label"><g:message code="pathologyImage.takenDate.label" default="Taken Date" /><span class="required-indicator">*</span></label>
                        <div>
                            <bs:datePicker name="takenDate" precision="day"  value="${pathologyImageInstance?.takenDate}"  />
                            <span class="help-inline">${hasErrors(bean: pathologyImageInstance, field: 'takenDate', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: pathologyImageInstance, field: 'takenBy', 'error')} ">
                        <label for="takenBy" class="control-label"><g:message code="pathologyImage.takenBy.label" default="Taken By" /></label>
                        <div>
                            <g:textField class="form-control" name="takenBy" value="${pathologyImageInstance?.takenBy}"/>
                            <span class="help-inline">${hasErrors(bean: pathologyImageInstance, field: 'takenBy', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: pathologyImageInstance, field: 'type', 'error')} required">
                        <label for="type" class="control-label"><g:message code="pathologyImage.type.label" default="Type" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" name="type" from="${geldb.ImageSubject?.values()}" keys="${geldb.ImageSubject.values()*.name()}" required="" value="${pathologyImageInstance?.type?.name()}" noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: pathologyImageInstance, field: 'type', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: pathologyImageInstance, field: 'samplePointer', 'error')} ">
                        <label for="samplePointer" class="control-label"><g:message code="pathologyImage.samplePointer.label" default="Upload Image" /></label>
                        <div>
                            <input type="file" id="photographFile" name="photographFile" />
                            %{--<g:textField class="form-control" name="samplePointer" value="${pathologyImageInstance?.samplePointer}"/>--}%
                            %{--<span class="help-inline">${hasErrors(bean: pathologyImageInstance, field: 'samplePointer', 'error')}</span>--}%
                        </div>
                    </div>
                </div>
            </div>

