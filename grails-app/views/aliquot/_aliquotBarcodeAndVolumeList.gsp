



            <p></p>

            <g:each var="number" in="${aliquotBarcodeVolumeList}" status="i">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="input-group">
                            <label class="control-label">Aliquot ${number} Biobanking Identifier</label>
                            <g:field type="text" class="form-control" name="sapphireIdentifier_${i}" placeholder="Biobanking Identifier"/>
                            <span class="input-group-addon">
                            </span>
                            <label class="control-label">Aliquot ${number} Barcode</label>
                            <g:field type="text" class="form-control" name="barcode_${i}" placeholder="Barcode"/>
                            <span class="input-group-addon">
                            </span>
                            <label class="control-label">Aliquot ${number} Volume/Mass</label>
                            <g:field type="number decimal" class="form-control" name="aliquotVolumeMass_${i}" placeholder="Aliquot Volume Mass" value="1"/>
                        </div>
                    </div>
                </div>
            </g:each>

            <div class="row">
                <div class="col-lg-6">
                    <div class="${hasErrors(bean: aliquotInstance, field: 'unit', 'error')}">
                        <label for="unit" class="control-label"><g:message code="aliquot.unit.label" default="Unit" /><span class="required-indicator">*</span></label>
                        <div>
                            <g:select class="form-control" id="unit" name="unit.id" from="${geldb.Units.list().sort()}" optionKey="id" value="${aliquotInstance?.unit?.id}" required="" noSelection="['':'- Choose -']"/>
                            <span class="help-inline">${hasErrors(bean: aliquotInstance, field: 'unit', 'error')}</span>
                        </div>
                    </div>
                </div>
            </div>