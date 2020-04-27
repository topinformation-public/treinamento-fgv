/**
 * @author ercaval
 */
public abstract class AbstractRestOutboundService {

    protected BaseRestProxy httpProxy;

    protected EventQueue    event;

    public AbstractRestOutboundService() {
    }

    public AbstractRestOutboundService(EventQueue event) {
        this();
        setup ( event );
    }

    virtual
    public BaseRestProxy getHttpRequestProxy (EventQueue event) {
        return new RestProxy( event );
    }

    protected abstract Object processResult( String response );


    /**
     * Setup Http Proxy wit Event Information
     */
    public void setup (EventQueue event) {
        this.event = event;
        this.httpProxy = getHttpRequestProxy( event );
    }

    public String send ( Object data  ) {

        event.log ('Sending message ' + JSON.serialize (data));

        String response = null;

        try {

            response =  this.httpProxy.send( data  );

            event.log ('Result Message ' +  response);

        } catch (Exception e) {

            event.errorProcessingEvent(e);

            throw e;

        }

        return response;
    }

    virtual
    public String get( Map<String, String> uriParameters ) {

        event.log ('Sending message ' + uriParameters);

        String response = null;

        try {

            response =  this.httpProxy.get( uriParameters  );

            event.log ('Result Message ' +  response);

        } catch (Exception e) {

            event.errorProcessingEvent(e);

            throw e;

        }

        return response;
    }

    virtual
    public String get( String uriParameters ) {

        event.log ('Sending message ' + uriParameters);

        String response = null;

        try {

            response =  this.httpProxy.get( uriParameters  );

            event.log ('Result Message ' +  response);

        } catch (Exception e) {

            event.errorProcessingEvent(e);

            throw e;

        }

        return response;
    }

    public EventQueue getEvent() {
        return this.event;
    }

    virtual
    public void publishEventLog() {
        this.event.save();
    }

}