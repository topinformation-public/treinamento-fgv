/**
 *
 * @author: ercarval
 */
global class JobPendingEvents implements Schedulable {

    public static Integer jobCountForTest = 0;

    global void execute(SchedulableContext sc) {
        
        System.debug('JobPendingEvents ---- ' + Datetime.now() );
        
        EventExecutor.processPendingEvents();
        
        //abort();
        
        //start();

        System.debug('JobPendingEvents ---- ' + Datetime.now() );
    }

    /**
     * Start Schedule execution for this class
     */
    public static void start ()  {
        new ScheduleHelper().scheduleIntoMinutesInterval( new JobPendingEvents() , 1);
    }

    public static void abort () {
        new ScheduleHelper().abort ('JobPendingEvents');
    }

}