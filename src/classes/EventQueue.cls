/**
 * @author: ercarval - topi
 */
global class EventQueue extends EventQueueActiveRecord {

    private boolean decreasedRetry;

    public EventConfiguration__c config  {get; set;}

    public Queue__c event {get; set;}

    public List<Attachment> payloads {get; set;}

    public List<String> processingLog {get; set;}

    private ICommand command;

    public EventQueue() {
        init();
    }

    public EventQueue(Queue__c event) {
        this();
        init(event);
    }

    public EventQueue(EventType type) {
        this();
        init(new Queue__c(eventName__c = type.name()));
    }

    public EventQueue(Id id) {
        this();
        init ( findOne (id) );
    }

    public void init() {
        event = new Queue__c();
        payloads = new List<Attachment>();
        processingLog = new List<String>();
        decreasedRetry = false;
    }

    public void init(Queue__c event) {
        this.event = event;
        setPayload();
        configEvent();
    }

    public void configEvent() {
        this.config = getEventConfiguration(this.getEventName());
    }

    public Queue__c get() {
        return event;
    }

    public String getPayload() {
        return getLastAttachedPayloadForEvent();
    }

    public Object getPayloadFromJson(Type clazz) {
        return JSON.deserialize( getPayload() , clazz );
    }

    public void addPayload(String name, String content) {
        payloads.add ( new Attachment(parentId = event.id
                                      , name = name + '.txt'
                                               , body = Blob.valueOf(content)) );
    }

    public String getEventName() {
        return this.event.eventName__c;
    }

    public String getStatus () {
        return this.event.status__c;
    }

    public String getBusinessDocumentNumber () {
        return this.event.businessDocument__c;
    }

    public void setStatus (String status) {
        this.event.status__c = status;
    }

    public void setStatus (EventQueueStatusType eventType) {
        this.event.status__c = eventType.name();
    }

    public String getStackTrace () {
        return this.event.exceptionStackTrace__c;
    }

    public String getObjectId() {
        return this.event.ObjectId__c;
    }

    public String getEventId() {
        return this.event.Id;
    }

    public String getInternalId () {
        return this.event.InternalId__c;
    }

    public void process () {

        log( '--------------------EVENT START EXECUTION-----------------' );

        // not execute for UNHANDLED
        if ( !hasHandlerFor(getEventName()) ) {
            setToUnhadledEvent();
            return;
        }

        if ( isRequestDisabled() ) {
            setStatus(  EventQueueStatusType.IGNORED.name() );
            return;
        }

        try {

            configEvent();
            this.command = getCommand();
            this.command.execute( this );
            successfullyDeliveyEvent ();

        } catch (IntegrationBusinessException e) {
            errorProcessingEvent(e);
            disableRetry();
        } catch (Exception e) {
            errorProcessingEvent(e);
            decreaseRetry();
        }

        log( '--------------------EVENT END EXECUTION-----------------' );
    }


    /**
     * execute all Update DMLs
     */
    public void postExecute () {

        log( '--------------------POST EXECUTE START -----------------' );

        // not execute for UNHANDLED
        if (  isIgnored ()
                || !hasHandlerFor( getEventName() )
                || !(this.command instanceOf IUpdatableCommmad)  ) {

            log ( '-------------------- POST EXECUTE SKIPED -----------' );

            return;
        }

        try {

            IUpdatableCommmad updatableCommand = (IUpdatableCommmad) this.command;
            updatableCommand.postUpdateExecute (this);

            if (!hasError()) {
                successfullyDeliveyEvent ();
            }

        } catch (IntegrationBusinessException e) {
            errorProcessingEvent(e);
            disableRetry();
        } catch (Exception e) {
            errorProcessingEvent(e);
            decreaseRetry();
        }

        log( '--------------------POST EXECUTE END -----------------' );

    }

    public boolean hasError () {
        return getStatus() == EventQueueStatusType.ERROR.name();
    }

    public boolean isIgnored () {
        return getStatus() == EventQueueStatusType.IGNORED.name();
    }

    public ICommand getCommand () {
        log ('Get Command Info for ' + this.getEventInfo() );
        return CommandFactory.createIntanceFor ( this.config.commandClassName__c );
    }

    public void setToUnhadledEvent () {
        setStatus(  EventQueueStatusType.UNHANDLED.name() );
    }

    public EventQueue successfullyProcessedEvent () {
        setStatus( EventQueueStatusType.SUCCESS.name() );
        event.StatusMessage__c = '';
        event.ExceptionStackTrace__c = '';
        return this;
    }

    public EventQueue successfullyDeliveyEvent () {

        if ( !isIgnored() )  {
            setStatus( EventQueueStatusType.DELIVERED.name() );
        }

        event.StatusMessage__c = '';
        event.ExceptionStackTrace__c = '';
        return this;
    }

    public EventQueue errorProcessingEvent ( DmlException e) {

        setStatus( EventQueueStatusType.ERROR.name() );
        event.statusMessage__c =  e.getTypeName() + ' :  { ' +  e.getDmlMessage(0) + ' }';
        event.exceptionStackTrace__c =  e.getStackTraceString();

        logException ();

        return this;
    }

    public EventQueue errorProcessingEvent ( Exception e) {

        setStatus( EventQueueStatusType.ERROR.name() );
        event.statusMessage__c =  e.getTypeName() + ' :  { ' +  e.getMessage() + ' }';
        event.exceptionStackTrace__c =  e.getStackTraceString();

        logException ();

        return this;
    }

    private void logException () {
        log(' \n \n ------- EVENT THROWS EXCEPTION ------- \n\n ' );
        log( event.statusMessage__c );
        log( event.exceptionStackTrace__c );
    }

    private EventQueue disableRetry () {
        event.retryCount__c = 0;
        event.IsRetryDisabled__c = true;
        return this;
    }

    private EventQueue decreaseRetry () {
        if (event.retryCount__c == 0 || decreasedRetry) return this;
        event.retryCount__c -=  1;
        decreasedRetry = true;
        return this;
    }

    public void setPayload(String payload) {

        if (this.payloads == null) this.payloads = new List<Attachment>();

        if (payload == null || payload.trim() == '' ) return;

        addPayload(event.eventName__c, payload);
    }

    public void setPayload() {

        if (String.isEmpty( event.payload__c )) return;

        setPayload(event.payload__c);
        event.payload__c = '';

    }

    public void setObjectId(Id objId) {
        this.event.objectId__c = objId;
    }

    public boolean isRequestDisabled () {
        if (this.config == null) return false;
        return this.config.disableDispatcher__c;
    }


    public EventQueue save() {

        if (event == null) return this;

        if (event.payload__c != null && event.payload__c != '') {
            setPayload(event.payload__c);
            event.payload__c = ''; //clear this old field;
        }

        appendProcessLogToAttachament();

        save(event);

        storePayloads();

        return this;
    }

    private void storePayloads() {

        if ( payloads == null || payloads.isEmpty())  return ;

        correlateAttachedPayloadWithEvent ();

        storePayloads(payloads);

    }

    private List<Attachment> correlateAttachedPayloadWithEvent () {

        if ( this.payloads == null || this.payloads.isEmpty()) return new List<Attachment>() ;

        for (Attachment attch : this.payloads) {
            if (attch.ParentId == null)
                attch.ParentId = event.id;
        }

        return this.payloads;

    }

    /**
     * rethink this method to improve testability
     */
    public String getLastAttachedPayloadForEvent () {

        List<Attachment> attachs = findLastPayloadProcessedForEvent( this.event.id , this.getEventName());

        if (attachs == null || attachs.isEmpty()) return null;

        Attachment attach =  attachs.get(0);

        return attach.Body.toString();

    }

    override
    public String toString() {
        return getEventInfo();
    }

    public String getEventInfo () {
        return 'Event [ ' + this.event.Id + ' | ' + this.event.businessDocument__c + ' ] - ' + getEventName();
    }

    public void log (String message) {
        appendLog(message);
    }

    public void appendLog (String message) {
        if (this.processingLog == null) this.processingLog = new List<String>();
        processingLog.add (message);
        System.debug (message);
    }

    public void appendProcessLogToAttachament () {

        if (processingLog == null || processingLog.isEmpty()) return;

        System.debug ('\n\n ................. appendProcessLogToAttachament Logged Lines [ ' + processingLog.size() + ' ] ');

        addPayload ( 'ExecutionTrace_' + System.now() + '_' + (event.businessDocument__c == null ? '' : event.businessDocument__c)
                     , convertProcessingLogToStringFile() );

        processingLog.clear();

    }

    public String convertProcessingLogToStringFile () {
        String log = '';
        for (String value : processingLog) {
            log += '\n' +  value;
        }
        return log;
    }


    public void createAllEvents ( List<EventQueue> events) {

        List<Queue__c> queues = new List<Queue__c>();
        List<Attachment> payloads = new List<Attachment>();

        for ( EventQueue event : events  ) {
            Queue__c queue = event.get();
            queues.add(queue);
        }

        createAll (queues);

        for (  EventQueue event : events ) {
            payloads.addAll( event.correlateAttachedPayloadWithEvent () );
        }

        storePayloads (payloads);


    }


}