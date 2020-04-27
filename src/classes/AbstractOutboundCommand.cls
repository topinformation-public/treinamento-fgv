/**
 * Provide template method for ICommand executions
 *
 *  how to Use
 *
 *  class PurchaseApprovedCommand extends AbstractOutboundCommand {
 *
 *      private PurchaseOrderRequest poRequest;
 *
 *      private PurchaseOrderTransformer transformer;
 *
 *      override
 *      public Object tranformToSend () {
 *          salesOrder = (Order) event.getPayloadFromJson( Order.class );
 *      }
 *
 *      // principal execution method
 *      public void execute () {
 *          // implement you logic here
 *      }
 *
 *
 * @author: ercarval - topi
 */
public abstract class AbstractOutboundCommand extends AbstractCommand  {

    @TestVisible
    protected Object targetObject;

    @TestVisible
    private Object responseObject;

    protected BaseRestProxy proxy;

    public AbstractOutboundCommand() {
    }

    //Setup
    virtual
    override
    public void init (EventQueue event) {

        super.init(event);

        proxy = getHttpRequestProxy( event );

        event.log('event Initialized');

    }

    virtual
    override
    public void preExecute() {

        event.log('Apply Event Transformation');

        targetObject = transformToSend();

        event.log('Transformation Applied ' + JSON.serialize(targetObject));

    }

    virtual
    override
    public void execute () {

        event.log('Send Message to Target System ' + event.config.endPointUrl__c );

        event.addPayload ( 'REQUEST_PAYLOAD_' + System.now() , JSON.serialize(targetObject) );

        responseObject = send ();

        event.log('Target System Response ' + JSON.serialize( responseObject ) );

    }


    //
    virtual
    public Object send  () {
        return proxy.send(  targetObject );
    }

    virtual
    override
    public void postExecute () {

        if (!accept()) {

            event.log('Ignore event postExecute ' + event );

            return;
        }

        event.log('Processing Response ');

        processResult(responseObject);

        event.log('Response Processed');

    }

    virtual
    public BaseRestProxy getHttpRequestProxy (EventQueue event) {
        return new RestProxy( event );
    }

    virtual
    public boolean accept () {
        return true;
    }

    public abstract Object transformToSend ();

    public abstract void processResult (Object responseObject);

}