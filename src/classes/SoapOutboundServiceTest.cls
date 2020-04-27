/**
 * @author: ercarval - topi
 */
@isTest
public class SoapOutboundServiceTest {

    @isTest
    static void givenSoapServiceWhenCreatedThenServiceIsConfiguredByEventType() {

        EventQueueFixtureFactory.createConfigForMockCommandLogTrace();

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('PROCESS_MOCK_EVENT_TRACE');

        SoapOutboundServiceMock ouboundService = new SoapOutboundServiceMock( event, new SoapProxyServiceMock() );

        ouboundService.send();

    }

    public class SoapOutboundServiceMock extends AbstractSoapOutboundService {

        public SoapOutboundServiceMock (EventQueue event, SoapProxyService service) {
            super(event, service);
        }

        override
        public void requestPrepare() {
            //apply transformation here
        }

        override
        public void callService () {

        }

        override
        public Object processResponse() {
            return null;
        }


    }


    public class SoapProxyServiceMock implements SoapProxyService {

        public String endpointUrl;
        public String headerValue;
        public String clientCertName;
        public String clientCert;
        public String clientCertPasswd;
        public Integer timeout;

        public String getEndPoint () {
            return endpointUrl;
        }

        public void setEndPoint (String url) {
            this.endpointUrl = url;
        }

        public void addAuthenticationHeader(String headerValue) {
            this.headerValue = headerValue;
        }

        public void setClientCertName (String clientCertName) {
            this.clientCertName = clientCertName;
        }

        public void setClientCert( String clientCert ) {
            this.clientCert = clientCert;
        }

        public void setClientCertPassword( String clientCertPasswd ) {
            this.clientCertPasswd = clientCertPasswd;
        }

        public void setTimeout( Integer timeout ) {
            this.timeout = timeout;
        }


    }

}