package geldb

/**
 * Created by nasulla on 26/07/2014.
 */
class CentrifugationParameters {
    Date startTime
    Integer centrifugationSpeed
    boolean centrifugationBrake
    Float centrifugationTemperature
    Date endTime


    String toString(){
        """${startTime},
            ${centrifugationSpeed},
            ${centrifugationBrake},
            ${centrifugationTemperature},
            ${endTime}"""
    }

}
