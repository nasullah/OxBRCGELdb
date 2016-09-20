package geldb

import grails.plugins.springsecurity.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * PathologyImageController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
@Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS', 'ROLE_READ_ONLY'])
@Transactional(readOnly = true)
class PathologyImageController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PathologyImage.list(params), model: [pathologyImageInstanceCount: PathologyImage.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PathologyImage.list(params), model: [pathologyImageInstanceCount: PathologyImage.count()]
    }

    def show(PathologyImage pathologyImageInstance) {
        respond pathologyImageInstance
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def create() {
        respond new PathologyImage(params)
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def download(long id) {
        PathologyImage pathologyImageInstance = PathologyImage.get(id)
        if ( pathologyImageInstance == null) {
            flash.message = "Pathology Image not found."
            redirect (action:'index')
        } else {
            response.setContentType("APPLICATION/OCTET-STREAM")
            response.setHeader("Content-Disposition", "Attachment;Filename=\"${pathologyImageInstance.samplePointer}\"")

            def file = new File(pathologyImageInstance.samplePointer)
            def fileInputStream = new FileInputStream(file)
            def outputStream = response.getOutputStream()

            byte[] buffer = new byte[4096];
            int len;
            while ((len = fileInputStream.read(buffer)) > 0) {
                outputStream.write(buffer, 0, len);
            }

            outputStream.flush()
            outputStream.close()
            fileInputStream.close()
        }
    }

    @Transactional
    def save(PathologyImage pathologyImageInstance) {

        if (pathologyImageInstance == null) {
            notFound()
            return
        }

        if (pathologyImageInstance.hasErrors()) {
            respond pathologyImageInstance.errors, view: 'create'
            return
        }

        def file = request.getFile('photographFile')
        if (!file.originalFilename) {
            flash.message = "Please choose a file"
            respond pathologyImageInstance, view: 'create'
            return
        }

        pathologyImageInstance.save flush: true

        if (pathologyImageInstance?.gelSuitabilityReport?.id != null){

            try {
                pathologyImageInstance.samplePointer = grailsApplication.config.uploadFolder +
                        pathologyImageInstance.gelSuitabilityReport.aliquot.specimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}.toString() +
                        '.ImageTakenDate.' +pathologyImageInstance.takenDate.format('dd-MM-yyyy') + '.ImageType.' +pathologyImageInstance.type.value + '.' + pathologyImageInstance.id.toString() + '.' + file.originalFilename.toString()
                file.transferTo(new File(pathologyImageInstance.samplePointer))
                pathologyImageInstance.save flush: true
                flash.message = "Pathology Image instance is created with ID ${pathologyImageInstance.id}."
                redirect(controller:'gelSuitabilityReport',action: 'show', params: [id: pathologyImageInstance.gelSuitabilityReport.id])
            }
            catch (Exception ex) {
                log.error(ex)
                flash.message = "Pathology Image instance is created with ID ${pathologyImageInstance.id}, file could not be loaded."
                redirect(controller:'gelSuitabilityReport',action: 'show', params: [id: pathologyImageInstance.gelSuitabilityReport.id])
            }

        }else if (pathologyImageInstance?.solidSpecimenReport?.id != null){

            try {
                pathologyImageInstance.samplePointer = grailsApplication.config.uploadFolder +
                        pathologyImageInstance.solidSpecimenReport.solidSpecimen.participant.studySubject.studySubjectIdentifier.findResult {it?.size() ? it : null}.toString() +
                        '.ImageTakenDate.' +pathologyImageInstance.takenDate.format('dd-MM-yyyy') + '.ImageType.' +pathologyImageInstance.type.value + '.' + pathologyImageInstance.id.toString() + '.' + file.originalFilename.toString()
                file.transferTo(new File(pathologyImageInstance.samplePointer))
                pathologyImageInstance.save flush: true
                flash.message = "Pathology Image instance is created with ID ${pathologyImageInstance.id}."
                redirect(controller:'FFPE_Tissue_Report',action: 'show', params: [id: pathologyImageInstance.solidSpecimenReport.id])
            }
            catch (Exception ex) {
                log.error(ex)
                flash.message = "Pathology Image instance is created with ID ${pathologyImageInstance.id}, file could not be loaded."
                redirect(controller:'FFPE_Tissue_Report',action: 'show', params: [id: pathologyImageInstance.solidSpecimenReport.id])
            }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    def edit(PathologyImage pathologyImageInstance) {
        respond pathologyImageInstance
    }

    @Transactional
    def update(PathologyImage pathologyImageInstance) {
        if (pathologyImageInstance == null) {
            notFound()
            return
        }

        if (pathologyImageInstance.hasErrors()) {
            respond pathologyImageInstance.errors, view: 'edit'
            return
        }

        pathologyImageInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PathologyImage.label', default: 'PathologyImage'), pathologyImageInstance.id])
                redirect pathologyImageInstance
            }
            '*' { respond pathologyImageInstance, [status: OK] }
        }
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN', 'ROLE_CAN_SEE_DEMOGRAPHICS'])
    @Transactional
    def delete(PathologyImage pathologyImageInstance) {

        if (pathologyImageInstance == null) {
            notFound()
            return
        }

        if (pathologyImageInstance.samplePointer){
            def samplePointerFile = new File(pathologyImageInstance.samplePointer)
            if (samplePointerFile.exists()){
                boolean fileDeletedSuccessfully = new File(pathologyImageInstance.samplePointer).delete()
                if (fileDeletedSuccessfully){
                    pathologyImageInstance.delete flush: true
                    if (pathologyImageInstance?.gelSuitabilityReport?.id){
                        flash.message = "Pathology Image Instance has been deleted"
                        redirect(controller:'gelSuitabilityReport',action: 'show', params: [id: pathologyImageInstance.gelSuitabilityReport.id])
                    }else if (pathologyImageInstance?.solidSpecimenReport?.id){
                        flash.message = "Pathology Image Instance has been deleted"
                        redirect(controller:'FFPE_Tissue_Report',action: 'show', params: [id: pathologyImageInstance.solidSpecimenReport.id])
                    }
                } else{
                    if (pathologyImageInstance?.gelSuitabilityReport?.id){
                        flash.message = "Could not delete the image file"
                        redirect(controller:'gelSuitabilityReport',action: 'show', params: [id: pathologyImageInstance.gelSuitabilityReport.id])
                    }else if (pathologyImageInstance?.solidSpecimenReport?.id){
                        flash.message = "Could not delete the image file"
                        redirect(controller:'FFPE_Tissue_Report',action: 'show', params: [id: pathologyImageInstance.solidSpecimenReport.id])
                    }
                }
            }
        }else {
            pathologyImageInstance.delete flush: true
            if (pathologyImageInstance?.gelSuitabilityReport?.id){
                flash.message = "Pathology Image Instance has been deleted"
                redirect(controller:'gelSuitabilityReport',action: 'show', params: [id: pathologyImageInstance.gelSuitabilityReport.id])
            }else if (pathologyImageInstance?.solidSpecimenReport?.id){
                flash.message = "Pathology Image Instance has been deleted"
                redirect(controller:'FFPE_Tissue_Report',action: 'show', params: [id: pathologyImageInstance.solidSpecimenReport.id])
            }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pathologyImageInstance.label', default: 'PathologyImage'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
