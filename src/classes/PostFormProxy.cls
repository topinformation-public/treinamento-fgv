/**
 * @author ercarval - topi
 */
public virtual class PostFormProxy extends RestProxy {

    private static final String FORM_CONTENT_TYPE = 'application/x-www-form-urlencoded';

    public PostFormProxy() {
        super();
    }

    public PostFormProxy(EventQueue event) {
        super(event.config);
        this.event = event;
    }

    public PostFormProxy(EventConfiguration__c config) {
        super(config);
    }

    /**
     * rewrite Content-Type to application/x-www-form-urlencoded
     */
    override
    protected void setup() {
        super.setup();
        this.httpRequest.setHeader('Content-Type', FORM_CONTENT_TYPE);
        this.httpRequest.setHeader('Accept', 'application/json');
    }

    override
    public void setBody (Object obj) {
        this.httpRequest.setBody ( (String) obj);
    }

}