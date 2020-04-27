/**
 * @author: Eduardo Ribeiro de Carvalho - ercarval
 */
public class EventExecutor implements Queueable,  Database.AllowsCallouts {

    private List<Queue__c> events;

    public static final Integer FUTURE_CALL_SIZE = 5;

    public EventExecutor () {
    }

    public EventExecutor (Queue__c queue) {
        this();
        events = new List<Queue__c> ();
        events.add (queue);
    }

    public EventExecutor (List<Queue__c> events) {
        this.events = events;
    }

    /**
     * Processar todos os eventos em um escopo futuro
     * @param Map<String, String> - devera ser enviado os dados Id do Evento e Nome do Evento.
     */
    @future(callout = true)
    public static void processEvents ( Map<String, String> events ) {
        processEvents ( EventQueueActiveRecord.findQueuedEvents(events.keySet()) );
    }


    public static void processEvents (List<Queue__c> processingQueue) {

        List<Attachment> payloads = new List<Attachment>();
        List<EventQueue> events = new List<EventQueue>();

        String eventsIntoBatch4Log = JSON.serialize(processingQueue);
        for (Queue__c queue : processingQueue) {

            EventQueue event = new EventQueue(queue);

            event.log( 'Events into Batch to Process \n ' + eventsIntoBatch4Log + '\n'  );

            event.process();
            events.add(event);
        }

        // Apply All DMLs After callout execution
        for (EventQueue event : events) {
            event.postExecute ();
            event.appendProcessLogToAttachament();
            payloads.addAll( event.payloads );
        }

        EventQueueActiveRecord.updateAll (processingQueue);
        EventQueueActiveRecord.storePayloads(payloads);

    }

    public static void processPendingEvents () {
        List<Queue__c> queues = EventQueueActiveRecord.findPendingQueuedEvents(
                                    DateTimeHelper.removeSencondsIntoCurrentDate(120) , 80 ) ;
        reprocess (queues);
    }

    public static void processOldQueuedEvents () {
        List<Queue__c> queues = EventQueueActiveRecord.findPendingQueuedEvents(
                                    new String[] {EventQueueStatusType.QUEUED.name()},
                                    DateTimeHelper.removeSencondsIntoCurrentDate(600) , 80 ) ;
        reprocess (queues);
    }

    public static void processErrorEvents () {
        List<Queue__c> queues =  EventQueueActiveRecord.findEventsWithError(
                                     DateTimeHelper.removeSencondsIntoCurrentDate(60) , 80 ) ;
        reprocess (queues);
    }

    public static void reprocess (List<Queue__c> queues) {

        List<Queue__c> enqueue = new List<Queue__c>();

        for (Queue__c queue : queues ) {
            queue.status__c = EventQueueStatusType.QUEUED.name();
            enqueue.add (queue);
        }

        update queues;

    }

    public void execute(QueueableContext context) {
        if (events == null || events.isEmpty() )
            events = EventQueueActiveRecord.findPendingQueuedEvents (EventQueueStatusType.WORKFLOW, 20);

        EventExecutor.processEvents(events);
    }



}