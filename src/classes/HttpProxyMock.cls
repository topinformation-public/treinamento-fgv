/**
 * @author ercarval
 */
@isTest
public class HttpProxyMock extends RestProxy {

    public String response ;

    public HttpProxyMock() {
        super();
    }

    public HttpProxyMock(EventConfiguration__c config) {
        super(config);
    }

    public HttpProxyMock(EventQueue event) {
        super(event.config);
        this.event = event;
    }

    public HttpProxyMock(EventQueue event ,  String response) {
        super(event.config);
        this.event = event;
        this.response  = response;
    }

    override
    public String get( Map<String, String> uriParameters) {
        return this.response;
    }

    override
    public String send( Object obj ) {
        return this.response;
    }

}