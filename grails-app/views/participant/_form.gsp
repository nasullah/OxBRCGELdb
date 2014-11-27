<%@ page import="geldb.Participant" %>


            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'familyName', 'error')} ">
                        <label for="familyName" class="control-label"><g:message code="participant.familyName.label" default="Family Name" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="familyName" value="${participantInstance?.familyName}" required=""/>
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'familyName', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'givenName', 'error')} ">
                        <label for="givenName" class="control-label"><g:message code="participant.givenName.label" default="Given Name" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="givenName" value="${participantInstance?.givenName}" required=""/>
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'givenName', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'dateOfBirth', 'error')} ">
                        <label for="dateOfBirth" class="control-label"><g:message code="participant.dateOfBirth.label" default="Date Of Birth" /></label>
                        <div>
                            <bs:datePicker name="dateOfBirth" precision="day"   value="${participantInstance?.dateOfBirth}" default="none"  /><span class="">Select or enter date as YYYY-MM-DD</span>
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'dateOfBirth', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'gender', 'error')} ">
                        <label for="gender" class="control-label"><g:message code="participant.gender.label" default="Gender" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" name="gender" from="${participantInstance.constraints.gender.inList}" value="${participantInstance?.gender}" valueMessagePrefix="participant.gender" required=""/>
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'gender', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'nHSNumber', 'error')} ">
                        <label for="nHSNumber" class="control-label"><g:message code="participant.nHSNumber.label" default="NHS Number" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="nHSNumber" value="${participantInstance?.nHSNumber}" required=""/>
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'nHSNumber', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'hospitalNumber', 'error')} ">
                        <label for="hospitalNumber" class="control-label"><g:message code="participant.hospitalNumber.label" default="Hospital Number" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:textField class="form-control" name="hospitalNumber" value="${participantInstance?.hospitalNumber}" required=""/>
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'hospitalNumber', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'diagnosis', 'error')} required">
                        <label for="diagnosis" class="control-label"><g:message code="participant.diagnosis.label" default="Diagnosis" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="diagnosis" name="diagnosis.id" from="${geldb.ICD10.list()}" optionKey="id" required="" value="${participantInstance?.diagnosis?.id}" />
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'diagnosis', 'error')}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="${hasErrors(bean: participantInstance, field: 'centre', 'error')} required">
                        <label for="centre" class="control-label"><g:message code="participant.centre.label" default="Centre" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="centre" name="centre.id" from="${geldb.Centre.list()}" optionKey="id" required="" value="${participantInstance?.centre?.id}" />
                            <span class="help-inline">${hasErrors(bean: participantInstance, field: 'centre', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>
