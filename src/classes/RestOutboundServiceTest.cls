/**
 * @author ercarval - Topi
 */
@isTest
private class RestOutboundServiceTest {

    @isTest
    static void sendRequest() {

        EventQueueFixtureFactory.createOutboundEventConfigWithOAuthConfig('SYNC_OUT', 'CommandName', 'OAUTH'  );

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('SYNC_OUT');

        Test.setMock( HttpCalloutMock.class , new HttpMock ('{"response":"ok"}', true) );
        Test.startTest();

        RestOutboundServiceMock mock = new RestOutboundServiceMock(event);

        String response = mock.send('XXXX');

        response = mock.get( new Map<String, String> {'param' => 'value'});
        response = mock.get( '/url/mapping');


        Test.stopTest();

    }

    public class RestOutboundServiceMock extends AbstractRestOutboundService {

        public RestOutboundServiceMock() {
        }

        public RestOutboundServiceMock(EventQueue event) {
            super ( event );
        }

        override
        public Object processResult( String response ) {
            return response;
        }

    }
}