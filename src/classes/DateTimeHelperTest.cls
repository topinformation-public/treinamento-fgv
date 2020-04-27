/**
 *
 * @author: ercarval
 */
@isTest
public with sharing class DateTimeHelperTest {


    testMethod
    private static void removeSecondsFromCurrentDate() {

        DateTime now = System.now();

        DateTime currentTimeWithMinousOneHundredSeconds = now.addSeconds( -1 * 100 ) ;

        System.debug(currentTimeWithMinousOneHundredSeconds);

        DateTime calculatedToTest = DateTimeHelper.removeSencondsIntoDate(now, 100);

        System.debug(calculatedToTest);
        System.assert( currentTimeWithMinousOneHundredSeconds == calculatedToTest);

    }


    testMethod
    private static void removeStringSecondsFromCurrentDate() {

        DateTime now = System.now();

        DateTime currentTimeWithMinousOneHundredSeconds = now.addSeconds( -1 * 100 ) ;

        System.debug(currentTimeWithMinousOneHundredSeconds);

        DateTime calculatedToTest = DateTimeHelper.removeSencondsIntoCurrentDate(100);

        System.debug(calculatedToTest);

    }

    testMethod
    private static void formatDate() {
        Date day = Date.newInstance(2017, 1, 1);

        System.assert(DateTimeHelper.formatDate(day, 'dd/MM/yyyy') == '01/01/2017');
    }

}