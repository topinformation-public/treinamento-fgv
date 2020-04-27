/**
 * @author: Eduardo Ribeiro de Carvalho - ercarval
 */
trigger EventConsumer on Queue__c (after insert, after update) {

    //all elements with status__c = Queued
    Map<String, String> events = new Map<String, String>();

    Integer i = 0;

    if ( System.isBatch() || System.isFuture() ) {
        System.debug('DeQueueProcessor Esta sendo chamada em future ' );
        return;
    }

    for (Queue__c event : trigger.new) {

        if (event.status__c != EventQueueStatusType.QUEUED.name()) continue;

        // Controle de Callouts, so pode ser realizado 100 simultaneos.
        if (i == EventExecutor.FUTURE_CALL_SIZE) {
            EventExecutor.processEvents(events);
            events = new Map<String, String>();
            i = 0;
        }

        events.put(event.id, event.eventName__c);
        i++;
    }

    if (events.size() > 0) {
        System.debug('DeQueueProcessor - Process last batch ' + events.size() );
        EventExecutor.processEvents(events);
    }

}