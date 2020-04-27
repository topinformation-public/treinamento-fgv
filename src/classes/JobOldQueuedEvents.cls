/**
 * @author ercarval
 */
global with sharing class JobOldQueuedEvents implements Schedulable {

    public static Integer jobCountForTest = 0;

    public JobOldQueuedEvents() {
    }

    global void execute(SchedulableContext sc) {
        EventExecutor.processOldQueuedEvents();
    }

    /**
     * Start Schedule execution for this class
     */
    public static void start ()  {
        new ScheduleHelper().scheduleIntoMinutesInterval(  new JobOldQueuedEvents() , 9);
    }

    public static void abort () {
        new ScheduleHelper().abort ('JobOldQueuedEvents');
    }


}