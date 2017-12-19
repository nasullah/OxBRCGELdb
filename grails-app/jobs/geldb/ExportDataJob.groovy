package geldb



class ExportDataJob {
    def exportAllSpecimenCronJobService
    def exportAllAliquotCronJobService
    def exportAllDNACronJobService
    static triggers = {
        cron name: 'myTrigger', cronExpression: "0 10 1 ? * MON-SUN"
    }

    def execute() {
        exportAllSpecimenCronJobService.exportAllSpecimen()
        exportAllAliquotCronJobService.exportAllAliquot()
        exportAllDNACronJobService.exportAllDNA()
    }
}
