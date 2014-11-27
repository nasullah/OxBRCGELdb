package geldb

/**
 * Created by Nasullah.Alham on 10/11/2014.
 */
class TissueIschaemia {

    Date startDate
    String startTime
    Date endDate
    Date endTime
    Period period
    String reportedBy

    String toString(){
        """${startDate},
            ${startTime},
            ${endDate},
            ${endTime},
            ${period},
            ${reportedBy}"""
    }

}
