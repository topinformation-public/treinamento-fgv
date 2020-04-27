/**
 * @author ercarval
 */
@isTest
private class AbstractOutboundCommandTest {

    /**
     * @Before like
     */
    @TestSetup
    public static void setup() {
        EventQueueFixtureFactory.createEventConfigForUnhandledEvent();
    }

    @isTest
    public static void givenOutboundEventThenGenericOutboundCommandTransformAndSendRequest () {

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('SYNC_OUTBOUND');

        OutboundCommandMock outboundMock = new OutboundCommandMock();

        outboundMock.execute(event);

        System.assert( outboundMock.targetObject instanceOf Contact );
        System.assertEquals( outboundMock.targetObject , outboundMock.MOCK_OBJ );
        System.assert( outboundMock.postResultExecuted );

    }


    public class OutboundCommandMock extends AbstractOutboundCommand {

        public final Contact MOCK_OBJ = new Contact (email = 'Bisso');

        @TestVisible
        private String toBeTransformed = '{"attributes":{"type":"Contact"},"Email":"Bisso"}';

        @TestVisible
        private Contact mockResponse;


        @TestVisible
        private boolean postResultExecuted;

        override
        public Object send() {
            return MOCK_OBJ;
        }

        override
        public Object transformToSend () {
            return JSON.deserialize( toBeTransformed , Contact.class );
        }

        override
        public void processResult (Object responseObject) {
            postResultExecuted = true;
        }

    }


}