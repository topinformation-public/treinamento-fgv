/**
 * @author: Eduardo Ribeiro de Carvalho - ercarval
 */
public abstract class EventQueueActiveRecord  {

    private Map<String, EventConfiguration__c> config;

    public static String[] PENDING_EVENTS = new String[] { EventQueueStatusType.SCHEDULED.name() };

    public EventQueueActiveRecord () {
        config = EventConfiguration__c.getAll();
    }

    public EventConfiguration__c getEventConfiguration (String eventName) {
        return config.get(eventName);
    }

    public Boolean hasHandlerFor (String eventName) {
        return config.containsKey(eventName);
    }

    public static void updateAll ( List<Queue__c> events ) {
        update events;
    }

    public static void createAll ( List<Queue__c> events ) {
        insert events;
    }

    public Queue__c save (Queue__c event) {

        if (event.id == null) {
            insert event;
            return event;
        }

        update event;
        return event;
    }

    public static void storePayloads(List<Attachment> attachments) {

        System.debug('\n\n\n Storing Payloads ' + attachments);

        try {

            upsert attachments;

        } catch (Exception e) {

            System.debug('\n\n\n [ EXCEPTION ] UNABLE TO STORE PAYLOAD ' + attachments);
            System.debug('\n\n\n ' + e);
            System.debug('\n\n\n --------------------------------------------- ');
            System.debug (e.getStackTraceString());

        }

    }



    public static List<Queue__c> findQueuedEvents (Set<String> keys) {
        return [Select q.status__c, q.statusMessage__c, q.sender__c, q.payload__c , q.retryCount__c, q.receiver__c, q.objectId__c, q.internalId__c, q.externalCreationDate__c, q.exceptionStackTrace__c, q.eventName__c, q.businessDocument__c, q.businessDocumentCorrelatedNumber__c, q.Name, q.Id From Queue__c q where q.id in :keys ] ;
    }

    virtual
    public Queue__c findOne (String id) {
        List<Queue__c> queues = findQueuedEvents ( new Set<String> {id});
        return (!queues.isEmpty()) ? queues.get(0) : null ;
    }

    public boolean hasQueuedEventsForBusinessDocument (String eventName, String businessDocumentNumber) {
        List<Queue__c> events =  [ Select id , name from Queue__c q
                                   where q.eventName__c  = :eventName
                                           and q.status__c = :EventQueueStatusType.QUEUED.name()
                                                   and q.businessDocument__c = :businessDocumentNumber
                                                           limit 1 ];
        return !events.isEmpty();
    }

    virtual
    public List<Queue__c> findLastEventsByNameAndBusinessDocumentNumber (String eventName, String businessDocumentNumber) {
        return [Select q.status__c, q.statusMessage__c, q.sender__c, q.retryCount__c, q.receiver__c, q.payload__c, q.objectId__c, q.internalId__c, q.externalCreationDate__c, q.exceptionStackTrace__c, q.eventName__c, q.businessDocument__c, q.businessDocumentCorrelatedNumber__c, q.Name, q.Id From Queue__c q
                where q.eventName__c  = :eventName
                                        and q.businessDocument__c = :businessDocumentNumber
                                                order by Queue__c.externalCreationDate__c desc
                                                limit 2] ;
    }

    public static List<Queue__c> findPendingQueuedEvents (DateTime lastCreationDate, Integer listSize) {
        return findPendingQueuedEvents ( PENDING_EVENTS, lastCreationDate, listSize );
    }

    public static List<Queue__c> findPendingQueuedEvents (String[] status,  DateTime lastCreationDate, Integer listSize) {
        return [ Select q.parentEvent__c, q.businessDocument__c, q.businessDocumentCorrelatedNumber__c, q.Status__c, q.StatusMessage__c, q.Sender__c, q.RetryCount__c, q.Receiver__c, q.Payload__c,  q.ObjectId__c, q.Name, q.LastModifiedDate,  q.IsRetryDisabled__c, q.InternalId__c, q.Id, q.ExternalCreationDate__c, q.ExceptionStackTrace__c, q.EventName__c, q.CreatedDate
                 From Queue__c q
                 where  q.status__c in :status
                 and q.createdDate < :lastCreationDate
                 order by q.createdDate asc
                 limit : listSize ];
    }

    public static List<Queue__c> findEventsWithError ( DateTime lastCreationDate, Integer listSize) {
        return [ Select q.parentEvent__c, q.businessDocument__c, q.businessDocumentCorrelatedNumber__c, q.Status__c, q.StatusMessage__c, q.Sender__c, q.RetryCount__c, q.Receiver__c, q.Payload__c,  q.ObjectId__c,  q.Name, q.LastModifiedDate,  q.IsRetryDisabled__c,  q.InternalId__c, q.Id, q.ExternalCreationDate__c, q.ExceptionStackTrace__c, q.EventName__c, q.CreatedDate
                 From Queue__c q
                 where  q.status__c = 'ERROR'
                                      and q.createdDate < :lastCreationDate
                                      and q.retryCount__c > 0
                                      and q.IsRetryDisabled__c = false
                                              order by q.createdDate asc
                                              limit : listSize ];
    }

    public static List<Queue__c> findPendingQueuedEvents (EventQueueStatusType status, Integer listSize) {
        return [ Select q.parentEvent__c, q.businessDocument__c, q.businessDocumentCorrelatedNumber__c, q.Status__c, q.StatusMessage__c, q.Sender__c, q.RetryCount__c, q.Receiver__c, q.Payload__c,  q.ObjectId__c,  q.Name, q.LastModifiedDate,  q.IsRetryDisabled__c,  q.InternalId__c, q.Id, q.ExternalCreationDate__c, q.ExceptionStackTrace__c, q.EventName__c, q.CreatedDate
                 From Queue__c q
                 where  q.status__c = :status.name()
                                      order by q.createdDate asc
                                      limit :listSize ];
    }

    virtual
    public List<Attachment> findAttachmentsForEvent (String eventId) {
        return [ SELECT Body, BodyLength, ContentType, CreatedById, CreatedDate, Description, Id, LastModifiedDate, Name, ParentId FROM Attachment where ParentId = :eventId order by  LastModifiedDate desc ];
    }

    virtual
    public List<Attachment> findLastPayloadProcessedForEvent (String eventId, String eventName) {
        return [ SELECT Body, BodyLength, ContentType, CreatedById, CreatedDate, Description, Id, LastModifiedDate, Name, ParentId FROM Attachment where ParentId = :eventId and name like :eventName + '%'  order by  LastModifiedDate desc limit 1 ];
    }

    public static List<Queue__c> findEventTypeForObject(String eventName, String objectId) {
        return [ SELECT Id from Queue__c where EventName__c = :eventName and ObjectId__c = :objectId];
    }

}