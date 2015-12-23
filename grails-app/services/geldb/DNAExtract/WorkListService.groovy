package geldb.DNAExtract

import geldb.Aliquot
import geldb.AliquotType
import grails.transaction.Transactional

/**
 * WorkListService
 * A service class encapsulates the core business logic of a Grails application
 */
@Transactional
class WorkListService {

    def workLists(sampleType) {
        if (sampleType == 'Samples awaiting FF DNA extraction') {
            def aliquotInstanceList = Aliquot.createCriteria().list{
                and {
                    isEmpty('dNA_Extract')
                    eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy Frozen'))
                }
            }
            [aliquotInstanceList: aliquotInstanceList.sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}, title: sampleType]
        }else if (sampleType == 'Samples awaiting FFPE DNA extraction') {
            def aliquotInstanceList = Aliquot.createCriteria().list{
                and {
                    isEmpty('dNA_Extract')
                    or {
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy FFPE, NBF'))
                        eq('aliquotType', AliquotType.findByAliquotTypeName('Punch Biopsy FFPE'))
                    }
                }
            }
            [aliquotInstanceList: aliquotInstanceList.sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}, title: sampleType]
        }else if (sampleType == 'Samples awaiting Germline DNA extraction') {
            def aliquotInstanceList = Aliquot.createCriteria().list{
                and {
                    isEmpty('dNA_Extract')
                    eq('aliquotType', AliquotType.findByAliquotTypeName('Buffy Coat'))
                }
            }
            [aliquotInstanceList: aliquotInstanceList.sort {it.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}}, title: sampleType]
        }
    }
}
