package geldb.FluidSpecimen

import grails.transaction.Transactional

/**
 * ExportFluidSpecimenService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class ExportFluidSpecimenService {

    def getFormatters(){
        def gelID = { domain, value ->
            return value.toString().replace('[','').replace(']','').replace('null','').replace(',','').trim()
        }
        Map formatters = ["participant.studySubject.studySubjectIdentifier":gelID]
        return formatters
    }

    def getFields(){
        List fields = ["participant.studySubject.studySubjectIdentifier", "fluidSampleType", "primaryContainer", "barcode", "timePoint", "exhausted", "notes","collectionDate","collectionTime","collectionLocation","collectedBy","fluidSpecimenVolume", "volumeUnit"]
        return fields
    }

    def getLabels(){
        Map labels = ["fluidSampleType":"FluidSample Type", "primaryContainer":"Primary Container", "barcode":"Barcode", "timePoint":"Time Point", "exhausted":"Exhausted", "notes":"Notes", "collectionDate":"Collection Date", "collectionTime":"Collection Time",
                      "collectionLocation":"Collection Location", "collectedBy":"Collected By", "fluidSpecimenVolume":"Fluid Specimen Volume", "volumeUnit":"Volume Unit", "participant.studySubject.studySubjectIdentifier":"GEL Study ID"]
        return labels
    }

    def getParameters(){
        Map parameters = [title: "FluidSpecimens", "column.widths": [0.2, 0.3, 0.5]]
        return parameters
    }

}
